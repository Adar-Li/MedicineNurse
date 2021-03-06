//
//  HomeHelper.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeHelper;



@interface HomeHelper : NSObject
//推荐页面cell
@property(nonatomic,strong)NSArray * itemArray;
//轮播图
@property(nonatomic,strong)NSArray * SCArray;

+ (HomeHelper *)shareHomeHelper;
//数据解析的方法
- (void)analysisDataWithURL:(NSString *)urlStr :(void(^)())result;

- (void)analysisCellDataWithURL:(NSString *)urlStr :(void(^)())result;

@end
