//
//  HomeController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HomeController.h"
#import "HBView.h"
#import "HomeHelper.h"
#import "HomeCell.h"
#import "HCCell.h"
#import "RecommendModel.h"
#import "IanScrollView.h"



@interface HomeController ()<UITableViewDelegate,UITableViewDataSource>
//轮播图标题数组
@property(nonatomic,strong) NSMutableArray * titleArray;
@property(nonatomic,assign)NSInteger currentIndex;
//录播图标题
@property(nonatomic,strong)UILabel * titleLable;

@end

@implementation HomeController

static NSString * homeCell = @"homeCell";
static NSString * hccCell = @"hccCellID";
- (void)viewDidLoad {
    self.currentIndex = 0 ;
    //隐藏navigation标题栏
    self.navigationController.navigationBarHidden = YES;
    
    [super viewDidLoad];


    [[HomeHelper shareHomeHelper]analysisDataWithURL:kHomeTJURL :^{

    
        [self drawTableView];

    }];
    
    self.buttonView = [[HBView alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 60)];
    [self.view addSubview:self.buttonView];
}


- (void)drawTableView{

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScremWidth, kScremHeight - 108) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:homeCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HCCell" bundle:nil] forCellReuseIdentifier:hccCell];
    
    [self drawScrollViewForHeader];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --tableView的代理事件---
//分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [HomeHelper shareHomeHelper].itemArray.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * itemArray = [[HomeHelper shareHomeHelper].itemArray mutableCopy];
    RecommendModel  * item = itemArray[indexPath.row];
    if (item.special_id) {
        HomeCell * cell = [tableView dequeueReusableCellWithIdentifier:homeCell forIndexPath:indexPath];
        [cell setvalueWithModel:item];
        return cell;
    }else{
    HCCell * cell  = [tableView dequeueReusableCellWithIdentifier:hccCell forIndexPath:indexPath];
    [cell setvalueWithModel:item];
    return cell;
    }
}


//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

#pragma msrk --绘制轮播图点击事件---
- (void)drawScrollViewForHeader{
    
    //解析轮播图数据
   [ [HomeHelper shareHomeHelper]analysisDataWithURL:kHomeTJSCURL :^{
       IanScrollView * scrorllView = [[IanScrollView alloc]initWithFrame:CGRectMake(0, 0, kScremWidth, 208)];
       
       NSArray * array = [[HomeHelper shareHomeHelper].SCArray mutableCopy];
       NSMutableArray * urlArray = [[NSMutableArray alloc]initWithCapacity:8];
               self.titleArray = [[NSMutableArray alloc]initWithCapacity:8];
       for (RecommendModel * item in array) {
           NSString * URLStr = item.cover;
           NSString * titleURL = item.name;
           
           [self.titleArray addObject:titleURL];
           [urlArray addObject:URLStr];
       }
       
       
       scrorllView.slideImagesArray = [urlArray mutableCopy];
       scrorllView.withoutAutoScroll = YES;
       //绘制lable
       [self drawLable];
       self.tableView.tableHeaderView = scrorllView ;
       scrorllView.ianCurrentIndex = ^(NSInteger index) {
           self.currentIndex = index;
           
           [self.titleLable removeFromSuperview];
           [self drawLable];
       };
       [scrorllView startLoading];
    }];
    
}

- (void)drawLable{
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 168, kScremWidth - 150, 40)];
    self.titleLable.numberOfLines = 3 ;
    self.titleLable.font =[UIFont systemFontOfSize:15];
    self.titleLable.textColor = [UIColor colorWithRed:0.995 green:0.983 blue:0.995 alpha:1.000];
//    self.titleLable.textAlignment = nste
    self.titleLable.text = self.titleArray[_currentIndex];
    [self.tableView addSubview:self.titleLable];
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
