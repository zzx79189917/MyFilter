//
//  ZZXTableViewCell.h
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"
@class TableViewCellFrame;
@interface ZZXTableViewCell : UITableViewCell
//@property(nonatomic,strong) TableViewCellFrame *tableViewCellFrame;
@property(nonatomic,strong) CellData *data;
@end
