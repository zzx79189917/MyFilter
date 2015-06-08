//
//  MainViewController.m
//  MyFilter
//
//  Created by zzx🐹 on 15/4/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#import "ZZXMainViewController.h"
#import "ZZXButton.h"
#import "ZZXEditViecController.h"
#import "CycleScrollView.h"
@interface ZZXMainViewController()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITabBarDelegate>
@property (nonatomic , retain) CycleScrollView *scroll;

@end
@implementation ZZXMainViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUI];
    

}
-(void)setUI
{
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_main"]];
    NSMutableArray *viewsArray = [@[] mutableCopy];
    for (int i = 0; i <3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, kScreenWidth-40, 200)];
        NSString *name=[NSString stringWithFormat:@"img_%d",i+1];
        imageView.image = [UIImage imageNamed:name] ;
        [viewsArray addObject:imageView];
    }
    UIImageView *backView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 70, kScreenWidth-20, 200)];
    backView.image=[UIImage imageNamed:@"backImage_start"];
    [self.view addSubview:backView];
//    __block NSInteger index;
    self.scroll = [[CycleScrollView alloc] initWithFrame:CGRectMake(10, 10, backView.frame.size.width-20, backView.frame.size.height-20) animationDuration:2];
//    self.scroll.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    self.scroll.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
//        index=pageIndex;
        return viewsArray[pageIndex];
    };
    self.scroll.totalPagesCount = ^NSInteger(void){
        return 3;
    };
    self.scroll.TapActionBlock = ^(NSInteger pageIndex){
//        NSLog(@"点击了第%d个",pageIndex);
    };
    [backView addSubview:self.scroll];
//    self.page.currentPage=index;
    
    UIImageView *title=[[UIImageView alloc]initWithFrame:CGRectMake(40, kScreenHeight/2, kScreenWidth-80, 100)];
    title.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:title];
    
    ZZXButton *button=[ZZXButton buttonWithTitle:nil normalImage:@"button_start_normal" highlightedImage:@"button_start_push"];
    button.frame=CGRectMake(115, kScreenHeight/2+120, 100, 50);
    [button addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)selectPhoto
{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker=[[UIImagePickerController alloc]init];
    photoPicker.delegate=self;
    photoPicker.allowsEditing=YES;
    [self presentViewController:photoPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    ZZXEditViecController *vc = [[ZZXEditViecController alloc] init];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        self.selectImage=image;
    }
    NSDictionary *dict=[[NSDictionary alloc]initWithObjectsAndKeys:self.selectImage,@"imageName", nil];
    NSNotification *notification=[NSNotification notificationWithName:@"notification" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [picker pushViewController:vc animated:YES];

}




@end
