//
//  ZZXButton.m
//  MyFilter
//
//  Created by zzx🐹 on 15/4/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ZZXButton.h"

@implementation ZZXButton

+ (instancetype)buttonWithTitle:(NSString *)title normalImage:(NSString*)normalImage highlightedImage:(NSString*)highlighImage
{
    ZZXButton *button=[ZZXButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlighImage] forState:UIControlStateHighlighted];
    return button;
}

@end
