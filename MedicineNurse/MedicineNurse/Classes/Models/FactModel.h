//
//  FactModel.h
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactModel : NSObject
@property (nonatomic ,strong)NSString   *ID;  //详情页传地址
@property (nonatomic ,strong)NSString  *title;  //标题
@property (nonatomic ,strong)NSString  *cover;  //标题下的图片
@property (nonatomic ,strong)NSString  *cover_small; //图片
@property (nonatomic ,strong)NSString  *special_id; //未知的id
@end
