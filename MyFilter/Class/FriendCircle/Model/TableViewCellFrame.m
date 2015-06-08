//
//  TableViewCellFrame.m
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import "TableViewCellFrame.h"
#import "CellData.h"
#import "Common.h"
@implementation TableViewCellFrame
- (void)calculateFrameWithCellData:(CellData *)data{
    //整个cell宽度
    CGFloat cellWidth=kScreenWidth-2*kTableBorderWidth;
    
    //文本
    CGFloat textX=kCellBorderWidth;
    CGFloat textY=kCellBorderWidth;
    CGSize textSize=[data.text sizeWithFont:kTextFont constrainedToSize:CGSizeMake(cellWidth-2*kCellBorderWidth, MAXFLOAT)];
    _textFrame=(CGRect){{textX,textY},textSize};
    //图片
    CGFloat imageX=textX;
    CGFloat imageY=CGRectGetMaxY(_textFrame)+kCellBorderWidth;
    CGSize imageSize=CGSizeMake(kImageWidth, kImageHeight);
    _imageFrame=(CGRect){{imageX,imageY},imageSize};
    //赞的数量
    CGFloat attitudesTextY=CGRectGetMaxY(_imageFrame)+kCellBorderWidth;
    CGSize attitudesTextSize=[data.createdAt
                              sizeWithFont:kTimeFont];
    CGFloat attitudesTextX=cellWidth-50;
    _attitudesTextFrame=(CGRect){{attitudesTextX,attitudesTextY},attitudesTextSize};
    //赞的图片
    CGSize attitudesImageSize=CGSizeMake(kAttitudesImageWidth, kAttitudesImageHeight);
    CGFloat attitudesImageX=cellWidth-90;
    CGFloat attitudesImageY=attitudesTextY;
    _attitudesImageFrame=(CGRect){{attitudesImageX,attitudesImageY},attitudesImageSize};
    //时间
    CGSize timeNameSize=[data.createdAt sizeWithFont:kTimeFont];
    CGFloat timeY=attitudesTextY;
    CGFloat timeX=cellWidth-200;
    _timeFrame=(CGRect){{timeX,timeY},timeNameSize};
    
    _cellHeight=kCellBorderWidth+kCellMargin+CGRectGetMaxY(_timeFrame);
    
}
@end
