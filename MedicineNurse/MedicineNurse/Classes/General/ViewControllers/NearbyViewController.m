//
//  NearbyViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "NearbyViewController.h"
#import <MAMapKit/MAMapKit.h>
#define APIKey @"9dc8634f93bc571986b8388e632d0336"
@interface NearbyViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
    UIButton *_locationButton;
}
@end

@implementation NearbyViewController
- (void)initControllers{
    _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locationButton.frame = CGRectMake(20, CGRectGetHeight(_mapView.bounds)- 80, 40, 40);
    _locationButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    _locationButton.backgroundColor = [UIColor whiteColor];
    _locationButton.layer.cornerRadius = 5;
    
    [_locationButton addTarget:self action:@selector(locationAction)  forControlEvents:UIControlEventTouchUpInside];
    [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    [_mapView addSubview:_locationButton];
}

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated{
    if (mode == MAUserTrackingModeNone) {
        [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }else{
        [_locationButton setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}

- (void)locationAction{
    if (_mapView.userTrackingMode != MAUserTrackingModeFollow) {
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    }
}

- (void)initMapView{
    [MAMapServices sharedServices].apiKey = APIKey;
    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
    [self.view addSubview:_mapView];
    _mapView.showsUserLocation = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView.showsUserLocation = YES;
    [self initMapView];
    [self initControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
