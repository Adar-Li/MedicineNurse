//
//  FactModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "FactModel.h"

@implementation FactModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
 
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@", _ID,_title,_cover,_cover_small,_special_id];
}

@end
