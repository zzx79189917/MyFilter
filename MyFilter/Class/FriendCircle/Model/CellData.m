//
//  CellData.m
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import "CellData.h"
@implementation CellData
-(id)initWithText:(NSString *)text imageName:(NSString*)imageName createdAt:(NSString *)createdAt attitudesCount:(NSString*)attitudesCount
{
    if (self=[super init]) {
        _text=text;
        _imageName=imageName;
        _createdAt=createdAt;
        _attitudesCount=attitudesCount;
        
        self.cellFrame = [[TableViewCellFrame alloc] init];
        [self.cellFrame calculateFrameWithCellData:self];
    }
    return self;
}
@end
