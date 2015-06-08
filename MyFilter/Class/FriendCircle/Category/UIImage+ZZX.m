//
//  UIImage+ZZX.m
//  新浪微博
//
//  Created by zzx🐹 on 15/1/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImage+ZZX.h"

@implementation UIImage (ZZX)

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];

}
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}
@end
