//
//  ZZXUIScrollView.m
//  MyFilter
//
//  Created by zzx🐹 on 15/4/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZZXUIScrollView.h"

@implementation ZZXUIScrollView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {

        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_1"]];
        self.scrollEnabled=YES;
        self.bounces=NO;
    }
    return self;
}
@end
