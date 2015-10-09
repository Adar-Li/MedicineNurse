//
//  NearbyViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.


#import "NearbyViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

//高德地图APIKey

#define APIKey @"9ae47b84e6f5888883343d16258db9fd"

@interface NearbyViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic,strong)MAMapView * mapView;
{
    //地图
    MAMapView *_mapView;
    //搜索
    AMapSearchAPI *_search;
    //定位模式按钮
    UIButton *_locationButton;
    CLLocation *_currentLocation;
    
    UITableView *_tableView;
    //记录回调信息的数组
    NSArray *_pois;
    
    NSMutableArray *_annotations;
}
@end
@implementation NearbyViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // _search = [[AMapSearchAPI alloc]init];
    [self initMapView];
    [self initControllers];
    [self initSearch];
    [self initAttributes];
    [self initTableView];
    

    
}

//添加地图定位模式选择按钮
- (void)initControllers{
    //添加button
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.frame = CGRectMake(20, CGRectGetHeight(_mapView.bounds)- 100, 40, 40);
    _locationButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    _locationButton.backgroundColor = [UIColor whiteColor];
    _locationButton.layer.cornerRadius = 5;
    
    [_locationButton addTarget:self action:@selector(locationAction)  forControlEvents:UIControlEventTouchUpInside];
    [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    [_mapView addSubview:_locationButton];
    
    
    //添加一个搜索的按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    searchButton.frame = CGRectMake(80, CGRectGetHeight(_mapView.bounds) - 100, 40, 40);
    searchButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_mapView addSubview:searchButton];

    
}



//通过图片来判断当前的定位模式
//箭头是none,圆点是follow

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated{
    if (mode == MAUserTrackingModeFollow) {
        [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }else{
        [_locationButton setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
    


    


}

//初始化搜索

- (void)initSearch{
      //_search = [[AMapSearchAPI alloc]initWithSearchKey:APIKey Delegate:self];
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
}


//地图的初始化方法
- (void)initMapView{
    //设置APIkey
    [MAMapServices sharedServices].apiKey = APIKey;
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)*0.5 - 64)];
    _mapView.delegate = self;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    
    [self.view addSubview:_mapView];
    //打开定位功能
    _mapView.showsUserLocation = YES;
    //显示指南针
    _mapView.showsCompass= YES;
    //显示比例尺
    _mapView.showsScale = YES;
    _mapView.userTrackingMode = 1;
    
    // NSLog(@"%@",[NSBundle mainBundle].bundleIdentifier);
}

//数据变量的初始化
- (void)initAttributes{
    _annotations = [NSMutableArray array];
    _pois = nil;
}

//tableView的初始化
- (void)initTableView
{
    CGFloat halfHeight = CGRectGetHeight(self.view.bounds) * 0.5;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, halfHeight, CGRectGetWidth(self.view.bounds), halfHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Helper

//定位模式不是跟随的时候,我们将它改为跟随
- (void)locationAction{
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow) {
        
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
    
}

//回调用户信息,打印用户当前坐标
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    NSLog(@"userLocation: %@", userLocation.location);
    //将打印出来的地址信息记录在变量当中
    _currentLocation = [userLocation.location copy];
    //    if(updatingLocation)
    //    {
    //        //取出当前位置的坐标
    //        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    //    }
}
//逆地理编码搜索请求
- (void)reGeoAction
{
    if (_currentLocation)
    {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        
        [_search AMapReGoecodeSearch:request];
    }
}

- (void)searchAction
{
    if (_currentLocation == nil || _search == nil)
    {
        NSLog(@"search failed");
        return;
    }
    //周边搜索
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc]init];
    //中心店为用户当前位置
    request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    //关键字
    request.keywords = @"餐饮";
    //发起搜索请求
    [_search AMapPOIAroundSearch:request];
    
}


#pragma mark - AMapSearchDelegate
//search回调请求
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    //打印错误回调
    NSLog(@"request :%@, error :%@", request, error);
}

//搜索的回调
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    NSLog(@"request: %@", request);
    NSLog(@"response: %@", response);
    
    if (response.pois.count > 0)
    {
        _pois = response.pois;
        
        //刷新tableView
        [_tableView reloadData];
        
        // 清空标注
        [_mapView removeAnnotations:_annotations];
        [_annotations removeAllObjects];
    }
}


//在系统大头针上设置气泡
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{

    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.canShowCallout= YES; //设置气泡可以弹出,默认为 NO
        annotationView.animatesDrop = YES; //设置标注动画显示,默认为 NO
        annotationView.draggable = YES; //设置标注可以拖动,默认为 NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
- (void)viewDidAppear:(BOOL)animated{
    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"你瞅啥";
//    pointAnnotation.subtitle = @"就瞅你啦,咋地";
//    [_mapView addAnnotation:pointAnnotation];
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSLog(@"response :%@", response);
    
    //title = 用户的城市
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0)
    {
        title = response.regeocode.addressComponent.province;
    }
    
    _mapView.userLocation.title = title;
    //用户的详细地址
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    // 选中定位annotation的时候进行逆地理编码查询
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        [self reGeoAction];
    }
}
#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    AMapPOI *poi = _pois[indexPath.row];
    
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.address;
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pois.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 为点击的poi点添加标注
    AMapPOI *poi = _pois[indexPath.row];
    
    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    annotation.title = poi.name;
    annotation.subtitle = poi.address;
    
    [_mapView addAnnotation:annotation];
    
    [_annotations addObject:annotation];
}


/*
 
 #pragma mark - Navigation
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 // Get the new view controller using [segue destinationViewController].
 
 // Pass the selected object to the new view controller.
 
 }
 
 */



@end
