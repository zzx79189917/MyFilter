//
//  ZZXTableViewCell.m
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import "ZZXTableViewCell.h"
#import "TableViewCellFrame.h"
#import "UIImage+ZZX.h"
#import "Common.h"
#import <UIImageView+WebCache.h>

@implementation ZZXTableViewCell
{
    UILabel *_text;//内容
    UILabel *_time;//时间
    UILabel *_attitudesText;//赞的数量
    UIButton *_attitudesImage;//赞的图
    UIImageView *_image;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加微博子控件
        _attitudesImage.selected=NO;
        [self addAllSubviews];
        //设置背景
        [self setBg];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x=kTableBorderWidth;
    frame.origin.y+=kTableBorderWidth;
    frame.size.width-=kTableBorderWidth*2;
    frame.size.height-=kCellBorderWidth;
    [super setFrame:frame];
}
-(void)setBg
{
    self.backgroundView=[[UIImageView alloc]initWithImage:[UIImage resizedImage:@"common_card_background.png"]];
    self.selectedBackgroundView=[[UIImageView alloc]initWithImage:[UIImage resizedImage:@"common_card_background_highlighted.png"]];
}
-(void)addAllSubviews
{
    //时间
    _time=[[UILabel alloc]init];
    _time.font=kTimeFont;
    _time.textColor=[UIColor colorWithRed:1.000 green:0.494 blue:0.371 alpha:1.000];
    [self.contentView addSubview:_time];

    //内容
    _text=[[UILabel alloc]init];
    _text.numberOfLines=0;//换行
    _text.font=kTextFont;
    [self.contentView addSubview:_text];
    
    //配图
    _image=[[UIImageView alloc]init];
    [self.contentView addSubview:_image];
    
    //赞
    _attitudesText=[[UILabel alloc]init];
    _attitudesText.font=kTextFont;
    [self.contentView addSubview:_attitudesText];
    
    _attitudesImage=[[UIButton alloc]init];
    [self.contentView addSubview:_attitudesImage];
}
//frame数据
//-(void)setTableViewCellFrame:(TableViewCellFrame *)tableViewCellFrame
//{
//    _tableViewCellFrame=tableViewCellFrame;
//    
//    //内容
//    _text.frame=_tableViewCellFrame.textFrame;
//
//    
//    //配图
//    _image.frame=_tableViewCellFrame.imageFrame;
//
//    
//    //时间
//    _time.frame=_tableViewCellFrame.timeFrame;
//    
//    //赞
//    _attitudesImage.frame=_tableViewCellFrame.attitudesImageFrame;
//    
//    _attitudesText.frame=_tableViewCellFrame.attitudesTextFrame;
//
//}
-(void)setData:(CellData *)data
{
    _data=data;
    
    _text.text=_data.text;
    
    NSURL *url=[NSURL URLWithString:_data.imageName];
//    NSLog(@"%@",url);
    [_image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"img_1"]];
    
    _time.text=_data.createdAt;
    
    _attitudesText.text=_data.attitudesCount;
    
    
    
    //内容
    _text.frame=data.cellFrame.textFrame;
    
    
    //配图
    _image.frame=data.cellFrame.imageFrame;
    _image.contentMode=UIViewContentModeScaleAspectFit;
    
    //时间
    _time.frame=data.cellFrame.timeFrame;
    
    //赞
    _attitudesImage.frame=data.cellFrame.attitudesImageFrame;
    if (_attitudesImage.selected) {
        [_attitudesImage setBackgroundImage:[UIImage imageNamed:@"good_push"] forState:UIControlStateSelected];
        _attitudesImage.selected=NO;
    }
    else
    {
        [_attitudesImage setBackgroundImage:[UIImage imageNamed:@"good_normal"] forState:UIControlStateNormal];
        _attitudesImage.selected=YES;
    }

    _attitudesText.frame=data.cellFrame.attitudesTextFrame;
}
@end
