//
//  ViewController.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    web.scalesPageToFit = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.str]];
    web.delegate = self;
    
    [self.view addSubview:web];
    [web loadRequest:request];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //执行事先写好的js代码
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('m_nav_bar')[0].style.display = 'none'"];
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
