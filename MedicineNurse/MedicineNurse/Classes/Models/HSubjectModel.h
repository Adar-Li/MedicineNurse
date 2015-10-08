//
//  HSubjectModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/8.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSubjectModel : NSObject

//id
@property(nonatomic,strong)NSString * ID;
//标题名
@property(nonatomic,strong)NSString * name;
//简短介绍
@property(nonatomic,strong)NSString * desc;
//小图
@property(nonatomic,strong)NSString * cover_small;

//大图
@property(nonatomic,strong)NSString * cover;

@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * create_time;
@property(nonatomic,strong)NSString * modify_time;


@end
