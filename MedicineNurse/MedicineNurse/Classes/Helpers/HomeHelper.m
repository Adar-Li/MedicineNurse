//
//  HomeHelper.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HomeHelper.h"
#import <AFNetworking.h>
#import "RecommendModel.h"

@interface HomeHelper ()
//推荐界面cell
@property(nonatomic,strong)NSMutableArray * itemMutArray;
//推荐页面轮播图
@property(nonatomic,strong)NSMutableArray * ScmutArray;
@end

@implementation HomeHelper

+ (HomeHelper *)shareHomeHelper{
    static   HomeHelper * homeHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        homeHelper = [HomeHelper new];
    });
    return homeHelper;
}

//数据解析的方法
- (void)analysisDataWithURL:(NSString *)urlStr :(void(^)())result{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
   [ manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
       //加载完了再清理
       NSDictionary * dataDict = responseObject[@"data"];
       NSArray * itemsArray = dataDict[@"items"];
       for (NSDictionary * itemDict in itemsArray) {
                 RecommendModel * CMModel = [RecommendModel new];
           [CMModel setValuesForKeysWithDictionary:itemDict];
           if ([urlStr isEqualToString:kHomeTJURL]) {
               [self.itemMutArray addObject:CMModel];
           }else if ([urlStr isEqualToString:kHomeTJSCURL]){
               [self.ScmutArray addObject:CMModel];
           }
           
       }
       result();
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark --lazy load--

//主界面面cell数组
- (NSArray *)itemArray{
        _itemArray = [self.itemMutArray mutableCopy];
    return _itemArray;
}
//主界面cell数组
- (NSMutableArray *)itemMutArray{
    if (_itemMutArray == nil) {
        _itemMutArray = [NSMutableArray array];
    }
    return _itemMutArray;
}

- (NSArray *)SCArray{
    return [self.ScmutArray mutableCopy];
}

- (NSMutableArray *)ScmutArray{
    if (_ScmutArray == nil) {
        _ScmutArray = [NSMutableArray array];
    }
    return _ScmutArray;
}


@end
