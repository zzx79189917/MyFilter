//
//  main.m
//  MyFilter
//
//  Created by zzx🐹 on 15/4/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
int main(int argc, char * argv[]) {
    @autoreleasepool {
        [Bmob registerWithAppKey:@"ad552330a050c95ceea613e5a55a8cd9"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
