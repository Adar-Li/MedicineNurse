//
//  SubjectModel.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        _ID = value;
        
    }
   
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"%@,%@,%@,%@", _ID,_title,_cover_small,_desc];
}



@end
