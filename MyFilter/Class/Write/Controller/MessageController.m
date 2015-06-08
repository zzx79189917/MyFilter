//
//  MessageController.m
//  MyFilter
//
//  Created by zzx🐹 on 15/6/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MessageController.h"
#import "Common.h"
#import "ZZXEditViecController.h"
#import <BmobSDK/Bmob.h>
@interface MessageController()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *backText;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *currentImage;
@property(nonatomic,strong)UILabel *placeholder;
@end
@implementation MessageController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.915 alpha:1.000];
    self.title=@"发表";
    UIColor *color=[UIColor whiteColor];
    NSDictionary *dic=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dic;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self setUI];
    
}
- (void)back{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)setUI
{
    /**
     文本框
     */
    self.backText=[[UITextView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 200)];
    self.backText.backgroundColor=[UIColor whiteColor];
    self.backText.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backText.font=[UIFont systemFontOfSize:13];
    //    self.backText.textColor=[UIColor colorWithWhite:0.798 alpha:1.000];
    self.backText.delegate=self;
    [self.view addSubview:self.backText];
    /**
     placeholder
     */
    self.placeholder=[[UILabel alloc]initWithFrame:CGRectMake(5, 71, 150, 40)];
    //    self.placeholder.enabled=NO;
    self.placeholder.text=@"输入您的心情文字";
    self.placeholder.textColor=[UIColor colorWithWhite:0.798 alpha:1.000];
    self.placeholder.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.placeholder];
    
    /**
     *  imageview
     */
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(20,self.backText.frame.origin.y+self.backText.frame.size.height-20, 150, 200)];
    self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    self.imageView.image=self.postImage;
    NSLog(@"message:%@",self.postImage);
//    self.imageView.backgroundColor=[UIColor yellowColor];
    
    [self.view addSubview:self.imageView];
    /**
     *  提交按钮
     */
    UIButton *submit=[UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat nextX = 32;
    CGFloat nextW = kScreenWidth - 2*nextX;
    CGFloat nextH = 39;
    CGFloat nextY = 450;
    submit.frame = CGRectMake(nextX, nextY, nextW, nextH);
    [submit setBackgroundImage:[UIImage imageNamed:@"send_normal"] forState:UIControlStateNormal];
    [submit setBackgroundImage:[UIImage imageNamed:@"send_push"] forState:UIControlStateHighlighted];
//    [submit setTitle:@"确认发表" forState:UIControlStateNormal];
    
    [submit addTarget:self action:@selector(submitMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
    
    /**
     *  触摸键盘隐藏
     */
    self.view.userInteractionEnabled=YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
}
-(void)submitMessage:(UIButton*)button
{
    BmobObject  *obj = [BmobObject objectWithClassName:@"FriendCircle"];
    
    [obj setObject:self.backText.text forKey:@"text"];
//    [obj setObject:@"0" forKey:@"attitudesCount"];
    //上传图片
    UIImage *image=self.postImage;
    NSData *data=UIImagePNGRepresentation(image);
    //     __block NSString *imageUrl;
    //把图片直接传到服务器
    [BmobProFile uploadFileWithFilename:@"img_1.png" fileData:data block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url) {
        if (isSuccessful) {
            url=[NSString stringWithFormat:@"%@?t=1&a=305cb5d9fbf2e89c1891b6a9786aa6d5",url];
            [obj setObject:url forKey:@"imageUrl"];
            //打印url
            NSLog(@"url %@",url);
            
            //异步保存
            [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    NSLog(@"sucess");
                } else if (error){
                    //发生错误后的动作
                    NSLog(@"%@",error);
                } else {
                    NSLog(@"Unknow error");
                }
            }];
            
        } else {
            if (error) {
                NSLog(@"error %@",error);
            }
        }
    } progress:^(CGFloat progress) {
        //上传进度，此处可编写进度条逻辑
        NSLog(@"progress %f",progress);
    }];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  触摸关闭键盘
 *
 *  @param gestureRecognizer 手势触摸
 */
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

#pragma mark--textview代理
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeholder.text=@"";
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        self.placeholder.text=@"输入您的心情文字";
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    return YES;
}


@end
