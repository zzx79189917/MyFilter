//
//  ZZXButton.h
//  MyFilter
//
//  Created by zzx🐹 on 15/4/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZXButton : UIButton
@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *title;

+ (instancetype)buttonWithTitle:(NSString *)title normalImage:(NSString*)normalImage highlightedImage:(NSString*)highlighImage ;
@end
