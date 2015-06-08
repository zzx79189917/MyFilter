//
//  TableViewCellFrame.h
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CellData;
@interface TableViewCellFrame : NSObject

//@property (nonatomic, strong) CellData *cellData;

@property(nonatomic,readonly)CGFloat  cellHeight;//Cell的高度
@property (nonatomic, readonly) CGRect textFrame; // 内容
@property (nonatomic, readonly) CGRect imageFrame; // 配图
@property(nonatomic,readonly)CGRect attitudesTextFrame;//赞的框
@property(nonatomic,readonly)CGRect attitudesImageFrame;//赞的图
@property(nonatomic,readonly)CGRect timeTextFrame;//赞的框
@property (nonatomic, readonly) CGRect timeFrame; // 时间
- (void)calculateFrameWithCellData:(CellData *)data;
@end
