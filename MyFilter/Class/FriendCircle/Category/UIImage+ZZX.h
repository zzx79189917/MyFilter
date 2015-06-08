//
//  UIImage+ZZX.h
//  新浪微博
//
//  Created by zzx🐹 on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZZX)
#pragma mark -加载全屏图片
+ (UIImage *)resizedImage:(NSString *)imgName;
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;
@end
