//
//  RootViewController.m
//  FilterOfPic
//
//  Created by zzx🐹 on 15/3/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ImageUtil : NSObject 

+ (UIImage *)imageWithImage:(UIImage*)inImage withColorMatrix:(float*)f;

@end
