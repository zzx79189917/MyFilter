//
//  CellData.h
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TableViewCellFrame.h"
@interface CellData : NSObject
@property (nonatomic, copy) NSString *text; // 内容
@property (nonatomic, copy)NSString *imageName; // 配图
@property (nonatomic, copy) NSString *createdAt; // 创建时间
@property (nonatomic, copy) NSString *attitudesCount; // 赞数量

@property (nonatomic, strong) TableViewCellFrame *cellFrame;

- (id)initWithText:(NSString*)text imageName:(NSString*)imageName createdAt:(NSString*)createdAt attitudesCount:(NSString*)attitudesCount;
@end
