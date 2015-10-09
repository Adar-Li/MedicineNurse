//
//  HDetailController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/9.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HDetailController.h"
#import <AFNetworking.h>
#import "HDetailModel.h"


@interface HDetailController ()<UIWebViewDelegate>
{
    NSInteger index;
}

@property(nonatomic,strong)HDetailModel * detailModel;
//创建webView
@property(nonatomic,strong)UIWebView * webView;
//创建头视图
@property(nonatomic,strong)UIView * headerView;

@end

@implementation HDetailController

- (void)viewDidLoad {
    index = 0;
    [super viewDidLoad];
    [self analysisCellData];
    self.navigationController.navigationBarHidden = NO;
    //调用绘制表头事件
    [self drawHeader];
    self.navigationController.tabBarItem.title = @"返回";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//解析数据
- (void)analysisCellData{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:kHomeCellURL(self.ID) parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray * array = responseObject[@"data"][@"items"];
        NSDictionary * dict = [array firstObject];
        
        _detailModel = [HDetailModel new];
        [_detailModel setValuesForKeysWithDictionary:dict];
        
        [self drawUI];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -- 绘制界面事件---
//绘制webView
- (void)drawUI{
    
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(10, 0, kScremWidth -20, kScremHeight)];
    _webView.delegate = self;
    _webView .scalesPageToFit = YES;
    [_webView loadHTMLString:self.detailModel.content baseURL:nil];
    _webView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

//绘制button事件
- (void)drawHeader{
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(kScremWidth /3, 0, 2 * kScremWidth /3, 44)];
    [self.navigationController.navigationBar addSubview:self.headerView];
    UIButton * SizeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [SizeButton setImage:[UIImage imageNamed:@"Text"] forState:UIControlStateNormal];
    [SizeButton addTarget:self action:@selector(changeTextSize) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:SizeButton];
    
}


#pragma mark -- webView的代理事件---
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"];
}
//改变字体大小
- (void)changeTextSize{
    index ++;
    if (index == 1) {
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '350%'"];
    }else if (index == 2){
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'"];
    }else if (index == 3){
        index = 0;
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '250%'"];
    }
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
