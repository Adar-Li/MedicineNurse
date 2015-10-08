//
//  HBView.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/7.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "HBView.h"

#define kScremHeight [UIScreen mainScreen].bounds.size.height
#define kScremWidth [UIScreen mainScreen].bounds.size.width

@implementation HBView

//重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawButton];
    }
    return self;
}

//绘制button
- (void)drawButton{
    
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScremWidth, 40)];
    //第一个按钮
    self.Button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.Button1.frame = CGRectMake(20 , 0, (kScremWidth- 40) / 5, 40);
    [self.Button1 setTitle:@"推荐" forState:UIControlStateNormal];
    self.Button1.tintColor = [UIColor redColor];
    self.Button1.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [buttonView addSubview:self.Button1];
    //第二个按钮
    self.Button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.Button2.frame = CGRectMake(20 +(kScremWidth- 40) / 5, 0,(kScremWidth- 40) / 5 , 40);
    [self.Button2 setTitle:@"专题" forState:UIControlStateNormal];
    self.Button2.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [buttonView addSubview:self.Button2];
    //第三个按钮
    self.Button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.Button3.frame = CGRectMake(20 + 2 *(kScremWidth- 40) / 5, 0,(kScremWidth- 40) / 5 , 40);
    [self.Button3 setTitle:@"真相" forState:UIControlStateNormal];
    self.Button3.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [buttonView addSubview:self.Button3];
    //第四个按钮
    self.button4  = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button4.frame =  CGRectMake(20 + 3 *(kScremWidth- 40) / 5, 0,(kScremWidth- 40) / 5 , 40);
    [self.button4 setTitle:@"肿瘤" forState:UIControlStateNormal];
    self.button4.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [buttonView addSubview:self.button4];
    //第五个按钮
    self.button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button5.frame =CGRectMake(20 + 4 *(kScremWidth- 40) / 5, 0,(kScremWidth- 40) / 5 , 40);
    [self.button5 setTitle:@"编辑" forState:UIControlStateNormal
     ];
    self.button4.titleLabel.textAlignment = NSTextAlignmentCenter ;
    [buttonView addSubview:self.button5];
    [self addSubview:buttonView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
