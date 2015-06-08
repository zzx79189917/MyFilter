//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .'   \\|   |//   `.
//                      /  \\||| : |||//  \
//                     / _||||| -:- |||||- \
//                     | |   \\\ - ///   | |
//                     | \_| ''\---/''   | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.'  >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//               \ \ `-. \_ __\   /__ _/ .-`    / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我太疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员。
//  ZZXEditViecController.m
//  MyFilter
//
//  Created by zzx🐹 on 15/4/21.
//  Copyright (c) 2015年 apple. All rights reserved.
//
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kTextViewWidth 50
#define kTextViewHegiht 20
#define kTextViewSpace 10
#define NUMBERS @"0123456789.-"
#import "ZZXEditViecController.h"
#import "ZZXMainViewController.h"
#import "ZZXUIScrollView.h"
#import "ZZXScrollViewButton.h"
#import "ColorMatrix.h"
#import "ImageUtil.h"
#import "SlidingViewManager.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import <GPUImage.h>
#import "MainTableViewController.h"
#import "ZZXButton.h"
@interface ZZXEditViecController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    UINavigationBar *_navigationBar;
    UINavigationItem *_navTitle;
    NSArray *_buttonArray;
    UIImage *_currentImage;
    UIImage *_firstImage;
    ZZXUIScrollView *_scrollView;
    NSInteger _count;
    
    SlidingViewManager *_sliderView;
    /**
     *  中间三个按钮
     */
    ZZXButton *_baseAdjustButton;
    UITextField *_textField;

    SlidingViewManager *_brightnessSliderView;
    SlidingViewManager *_shareSliderView;
    //设置color的中间按钮
    ZZXButton *_colorAdjustButton;
    SlidingViewManager *_colorSliderView;
    UISlider *_colorSlider;
    float _colorSliderValue;
    //分享按钮
    ZZXButton *_shareButton;
    ZZXButton *_savebutton;
    UISlider *_brightnessSlider;
    float _brightnessSliderValue;
}
@property(nonatomic,strong)UIImageView *startImageView;
@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIView *brightnessBottonView;
@property(nonatomic,strong)UIView *colorBottonView;
@property(nonatomic,strong)UIView *shareBottonView;

@end

@implementation ZZXEditViecController
-(instancetype)init
{
      if(self=[super init])
      {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"notification" object:nil];
      }
    return self;
}
-(void)closePopMenu
{
    [_sliderView slideViewOut];
    [_colorSliderView slideViewOut];
    [_brightnessSliderView slideViewOut];
    [_shareSliderView slideViewOut ];
    _startImageView.image=_currentImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:0.915 alpha:1.000];
    [self initData];
    [self setNavigation];
    [self setImageView];
    [self setScrollView];
    [self setBtn];
    [self setMiddleBtn];
}
////通知传递图片
- (void)tongzhi:(NSNotification *)image{

    NSDictionary *nameDictionary=[image userInfo ];
    UIImage *newImage=[nameDictionary objectForKey:@"imageName"];
    self.image=newImage;
        NSLog(@"%@",newImage);
    self.startImageView.image=newImage;
    _currentImage=newImage;
    _firstImage=newImage;
}
-(void)setMiddleBtn
{
    [self setBaseAdjustButton];
    [self setColorAjustButton];
    [self setShareButton];
    [self setSaveButton];
}
/**
 *  初始化数据
 */
-(void)initData
{
    _buttonArray=[NSArray arrayWithObjects:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐色",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色",@"自定义", nil];
    _count=_buttonArray.count;
}

/**
 *  调节灰度
 */
-(void)setBaseAdjustButton
{
    _baseAdjustButton=[ZZXButton buttonWithTitle:nil normalImage:@"brightness_normal" highlightedImage:@"brightness_push"];
    _baseAdjustButton.frame=CGRectMake(15, 415 , 65, 20);
    [_baseAdjustButton addTarget:self action:@selector(popBritnessView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_baseAdjustButton];
}
-(void)popBritnessView
{
    _brightnessBottonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    _brightnessBottonView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_1"]];
    _brightnessSliderView=[[SlidingViewManager alloc]initWithInnerView:_brightnessBottonView containerView:self.view];
    [_brightnessSliderView slideViewIn];
    
    _brightnessSlider=[[UISlider alloc]initWithFrame:CGRectMake(20, _brightnessBottonView.frame.size.height/2, kScreenWidth-40, 10)];
    _brightnessSlider.maximumValue=0.618;
    _brightnessSlider.minimumValue=-0.618;
    _brightnessSlider.value=0;
    
    [_brightnessSlider addTarget:self action:@selector(adjustBrighterImage:) forControlEvents:UIControlEventValueChanged];
  
    [_brightnessBottonView addSubview:_brightnessSlider];
    
    ZZXButton *cancel=[ZZXButton buttonWithTitle:nil normalImage:@"cancel_normal" highlightedImage:@"cancel_push"];
    cancel.frame=CGRectMake(15,_brightnessBottonView.frame.size.height-30 , 25, 25);
    [cancel addTarget:self action:@selector(closeBrightnessPopView) forControlEvents:UIControlEventTouchUpInside];
    [_brightnessBottonView addSubview:cancel];
    
    ZZXButton *ensure=[ZZXButton buttonWithTitle:nil normalImage:@"ok_normal" highlightedImage:@"ok_push"];
    ensure.frame=CGRectMake(_brightnessBottonView.frame.size.width-40, _brightnessBottonView.frame.size.height-30, 25,25);
    [ensure addTarget:self action:@selector(saveBrightness) forControlEvents:UIControlEventTouchUpInside];
    [_brightnessBottonView addSubview:ensure];
    
    [_brightnessSliderView slideViewIn];
    
}
/**
 *  调节灰度
 *
 *  @param slider 用滑块调节
 */
- (void)adjustBrighterImage:(UISlider*)slider
{
    
//    _brightnessSliderValue=slider.value;
//    UIImage *image=_startImageView.image;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *brighterImage;
//        CIContext *context = [CIContext contextWithOptions:nil];
//        CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
//        NSLog(@"begin3");
//        CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
//        NSLog(@"begin4");
//        [lighten setValue:inputImage forKey:kCIInputImageKey];
//        [lighten setValue:@(_brightnessSliderValue) forKey:@"inputBrightness"];
//        
//        CIImage *result = [lighten valueForKey:kCIOutputImageKey];
//        CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
//        brighterImage = [UIImage imageWithCGImage:cgImage];
//        CGImageRelease(cgImage);
//        NSLog(@"end");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _startImageView.image=brighterImage;
//        });
//    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        float num;
        num=slider.value;
        dispatch_async(dispatch_get_main_queue(), ^{
            _brightnessSliderValue=num;
                    });
                });

    GPUImageBrightnessFilter *selectedFilter=[[GPUImageBrightnessFilter alloc]init];
    //    selectedFilter.mix=0.5;
    //    selectedFilter.scale=-1.0;
    //    selectedFilter.dotScaling=r1;
    NSLog(@"%f",_brightnessSliderValue);
    selectedFilter.brightness=_brightnessSliderValue;
    UIImage *newImg=[selectedFilter imageByFilteringImage:_currentImage];
    
    // 显示图片
    [_startImageView setImage:newImg];
    // 释放C对象
//    CGImageRelease(cgimg);
}

/**
 *  保存和关闭
 */
-(void)saveBrightness
{
    _currentImage=_startImageView.image;
    [_brightnessSliderView slideViewOut];
    
}
-(void)closeBrightnessPopView
{
    _startImageView.image=_currentImage;
    [_brightnessSliderView slideViewOut];
}
//中间第二个调色彩按钮
-(void)setColorAjustButton
{
    _colorAdjustButton=[ZZXButton buttonWithTitle:nil normalImage:@"baohedu_normal" highlightedImage:@"baohedu_push"];
    _colorAdjustButton.frame=CGRectMake(90, 415 , 65, 20);

    [_colorAdjustButton addTarget:self action:@selector(popColorView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_colorAdjustButton];
}
-(void)popColorView
{
    _colorBottonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    _colorBottonView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_1"]];
    _colorSliderView=[[SlidingViewManager alloc]initWithInnerView:_colorBottonView containerView:self.view];
//    [_colorSliderView slideViewIn];
    _colorSlider=[[UISlider alloc]initWithFrame:CGRectMake(20, _colorBottonView.frame.size.height/2, kScreenWidth-40, 10)];
    _colorSlider.maximumValue=2;
    _colorSlider.minimumValue=0;
    _colorSlider.value=1;
    [_colorSlider addTarget:self action:@selector(adjustColorImage:) forControlEvents:UIControlEventValueChanged];
    [_colorBottonView addSubview:_colorSlider];
    
    ZZXButton *cancel=[ZZXButton buttonWithTitle:nil normalImage:@"cancel_normal" highlightedImage:@"cancel_push"];
    cancel.frame=CGRectMake(15,_colorBottonView.frame.size.height-30 , 25, 25);
    [cancel addTarget:self action:@selector(closeColorPopView) forControlEvents:UIControlEventTouchUpInside];
    [_colorBottonView addSubview:cancel];
    
   ZZXButton *ensure=[ZZXButton buttonWithTitle:nil normalImage:@"ok_normal" highlightedImage:@"ok_push"];
    ensure.frame=CGRectMake(_colorBottonView.frame.size.width-40, _colorBottonView.frame.size.height-30, 25,25);
    [ensure addTarget:self action:@selector(saveColor) forControlEvents:UIControlEventTouchUpInside];
    [_colorBottonView addSubview:ensure];
    
    [_colorSliderView slideViewIn];
    
}
-(void)saveColor
{
    _currentImage=_startImageView.image;
    [_colorSliderView slideViewOut];
    
}
-(void)closeColorPopView
{
    _startImageView.image=_currentImage;
    [_colorSliderView slideViewOut];
}
- (void)adjustColorImage:(UISlider*)slider
{
    //异步
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        _colorSliderValue=slider.value;
//        UIImage *colorImage;
//        CIContext *context=[CIContext contextWithOptions:nil];
//        CIImage *inputImage=[CIImage imageWithCGImage:_currentImage.CGImage];
//        CIFilter *lighten=[CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage,@"inputIntensity",@(_colorSliderValue), nil];
//        CIImage *result=[lighten valueForKey:kCIOutputImageKey];
//        CGImageRef cgImage=[context createCGImage:result fromRect:[inputImage extent]];
//        colorImage=[UIImage imageWithCGImage:cgImage];
//        CGImageRelease(cgImage);
//        //回到主线程
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _startImageView.image=colorImage;
//        });
//    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        float num;
        num=slider.value;
        dispatch_async(dispatch_get_main_queue(), ^{
            _colorSliderValue=num;
        });
    });
    
    GPUImageSaturationFilter *selectedFilter=[[GPUImageSaturationFilter alloc]init];
    //    selectedFilter.mix=0.5;
    //    selectedFilter.scale=-1.0;
    //    selectedFilter.dotScaling=r1;
    NSLog(@"%f",_brightnessSliderValue);
    selectedFilter.saturation=_colorSliderValue;
    UIImage *newImg=[selectedFilter imageByFilteringImage:_firstImage];
    [_startImageView setImage:newImg];
}
-(void)setSaveButton
{
    _savebutton=[ZZXButton buttonWithTitle:nil normalImage:@"save_nromal" highlightedImage:@"save_push"];
    _savebutton.frame=CGRectMake(240, 415 , 65, 20);
    [_savebutton addTarget:self action:@selector(savePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_savebutton];
}
//分享按钮
-(void)setShareButton
{
    _shareButton=[ZZXButton buttonWithTitle:nil normalImage:@"share_normal" highlightedImage:@"share_push"];
    _shareButton.frame=CGRectMake(165, 415 , 65, 20);
    [_shareButton addTarget:self action:@selector(popShareMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shareButton];
}
-(void)popShareMenu
{
    _shareBottonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    _shareBottonView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_1"]];
    _shareSliderView=[[SlidingViewManager alloc]initWithInnerView:_shareBottonView containerView:self.view];
    
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame=CGRectMake(0,_shareBottonView.frame.size.height-40 , kScreenWidth, 40);
    [cancel setBackgroundImage:[UIImage imageNamed:@"rectangle_2"] forState:UIControlStateNormal];
    [cancel setTitle:@"关闭" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(closeSharePopView) forControlEvents:UIControlEventTouchUpInside];
    [_shareBottonView addSubview:cancel];

    UIButton *WX=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *WXLogo=[UIImage imageNamed:@"WX_logo"];
    WX.frame=CGRectMake(10, 25, 58, 58);
    [WX setBackgroundImage:WXLogo forState:UIControlStateNormal];
    [WX addTarget:self action:@selector(weixinShare) forControlEvents:UIControlEventTouchUpInside];
    [_shareBottonView addSubview:WX];
    
    UIButton *WB=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *WBLogo=[UIImage imageNamed:@"WB_logo"];
    WB.frame=CGRectMake(78, 25, 58, 58);
    [WB setBackgroundImage:WBLogo forState:UIControlStateNormal];
    [WB addTarget:self action:@selector(weiboShare) forControlEvents:UIControlEventTouchUpInside];
    [_shareBottonView addSubview:WB];
    
    [_shareSliderView slideViewIn];
}
-(void)closeSharePopView
{
        [_shareSliderView slideViewOut];
}
-(void)weixinShare
{
    [self sendImageContent];
}
-(void)weiboShare
{
    [self sharePic];
}
-(void)sharePic
{
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"是否分享" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=1;
    [alert show];
    alert.delegate=self;
    
}
/**
 *  scrollview
 */
-(void)setScrollView
{
     _scrollView=[[ZZXUIScrollView alloc]initWithFrame:CGRectMake(0,kScreenHeight-125 , kScreenWidth, 125)];
    _scrollView.contentSize = CGSizeMake(100*_count+(_count+1)*5, _scrollView.frame.size.height);
    [self.view addSubview:_scrollView];
}

/**
 *  建立scrollview中的button
 */
-(void)setBtn
{
    for (int i=0; i<_count; i++) {
        ZZXScrollViewButton *button=[ZZXScrollViewButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(5+i*105, 5, 100, 115);
        button.backgroundColor=[UIColor redColor];
        [button setTag:i];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeFilter:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
}
/**
 *  切换滤镜
 *
 *  @param button 根据滤镜色
 */
-(void)changeFilter:(ZZXScrollViewButton*)button
{
    float *filterName = NULL;
    switch (button.tag) {
        case 0:
            break;
        case 1:
            filterName=colormatrix_lomo;
            
            break;
            
        case 2:
            filterName=colormatrix_heibai;
            break;
            
        case 3:
            filterName=colormatrix_huajiu;
            break;
        case 4:
            filterName=colormatrix_gete;
            break;
        case 5:
            filterName=colormatrix_ruise;
            break;
        case 6:
            filterName=colormatrix_danya;
            break;
        case 7:
            filterName=colormatrix_jiuhong;
            break;
        case 8:
            filterName=colormatrix_qingning;
            break;
        case 9:
            filterName=colormatrix_langman;
            break;
        case 10:
            filterName=colormatrix_guangyun;
            break;
        case 11:
            filterName=colormatrix_landiao;
            break;
        case 12:
            filterName=colormatrix_menghuan;
            break;
        case 13:
            filterName=colormatrix_yese;
            break;
        case 14:
            [button addTarget:self action:@selector(popBottomView) forControlEvents:UIControlEventTouchUpInside];
            break;
    }
    if (button.tag!=0&&button.tag!=14) {
        _startImageView.image = [ImageUtil imageWithImage:_firstImage withColorMatrix:filterName];
    }
    else if(button.tag==0)
    {
        _startImageView.image=_firstImage;
    }
    _currentImage=_startImageView.image;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.3];
    [UIView commitAnimations];
}
/**
 *  弹出自定义滤镜view
 */
//弹出下框
-(void)popBottomView
{
    NSLog(@"123");
    _bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 160)];
    _bottomView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_1"]];
    //    [self setSlider];
    
    _sliderView= [[SlidingViewManager alloc] initWithInnerView:_bottomView containerView:self.view];
    int k=101;
    for(int i=0;i<4;i++)
    {
        for (int j=0;j<5; j++) {
            _textField=[[UITextField alloc]initWithFrame:CGRectMake(10+63*j, 5+kTextViewHegiht*i+kTextViewSpace*i, kTextViewWidth, kTextViewHegiht)];
            _textField.backgroundColor=[UIColor whiteColor];
            _textField.delegate=self;
            _textField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
            _textField.returnKeyType=UIReturnKeyDefault;
            _textField.tag=k;
            _textField.text=@"0.0";
            k++;
            [_bottomView addSubview:_textField];
        }
    }
    UIButton *cancel=[UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame=CGRectMake(15,_bottomView.frame.size.height-30 , 25, 25);
    [cancel addTarget:self action:@selector(closePopView) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:cancel];
    
    UIButton *ensure=[UIButton buttonWithType:UIButtonTypeCustom];
    ensure.frame=CGRectMake(_colorBottonView.frame.size.width-40, _colorBottonView.frame.size.height-30, 25,25);
    [ensure addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:ensure];
    [_sliderView slideViewIn];
    
}
-(void)changeColor
{
    float a[20];
    NSString *str;
    UITextField *excessiveTextField=[[UITextField alloc]init];
    for (int i=0; i<20; i++) {
        excessiveTextField=(UITextField*)[_bottomView viewWithTag:i+101];
        str=[excessiveTextField.text stringByAppendingString:@"f"];
        a[i]=[str floatValue];
    }
    float colormatrix_zidingyi[] = {
        a[0],  a[1], a[2], a[3], a[4],
        a[5],  a[6], a[7], a[8], a[9],
        a[10],  a[11], a[12], a[13], a[14],
        a[15],  a[16], a[17], a[18],a[19] };
    
    _startImageView.image = [ImageUtil imageWithImage:_currentImage withColorMatrix:colormatrix_zidingyi];
    [_sliderView slideViewOut];
    
}
-(void)closePopView
{
    [_sliderView slideViewOut];
}


/**
 *  创建建立imageview
 */
-(void)setImageView
{
    _startImageView=[[UIImageView alloc]initWithFrame:CGRectMake(5, _navigationBar.frame.size.height+10, [UIScreen mainScreen].bounds.size.width-10, 330)];
    _startImageView.backgroundColor=[UIColor whiteColor];
    _startImageView.image=self.image;
    [self.view addSubview:_startImageView];
}
/**
 *  navigation
 */
-(void)setNavigation
{
    _navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [_navigationBar setBackgroundImage:[UIImage imageNamed:@"rectangle_2"] forBarMetrics:UIBarMetricsDefault];
    NSMutableDictionary *attributes=[NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName]=[UIColor whiteColor];
    attributes[NSFontAttributeName]=[UIFont systemFontOfSize:18];
    [_navigationBar setTitleTextAttributes:attributes];
    
    
    _navTitle = [[UINavigationItem alloc] initWithTitle:@"详细介绍"];
    [_navigationBar pushNavigationItem:_navTitle animated:YES];
    [self.view addSubview:_navigationBar];
    
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    NSMutableDictionary *itemAttributes=[NSMutableDictionary dictionary];
    itemAttributes[NSForegroundColorAttributeName]=[UIColor whiteColor];
    itemAttributes[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:itemAttributes forState:UIControlStateNormal];
    
    
    UIBarButtonItem *leftBtn=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnToAlbum)];
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"朋友圈" style:UIBarButtonItemStylePlain target:self action:@selector(pushFriendCircle)];
    _navTitle.leftBarButtonItem=leftBtn;
    _navTitle.rightBarButtonItem=rightBtn;
    [_navigationBar setItems:[NSArray arrayWithObjects:_navTitle, nil]];
}
-(void)pushFriendCircle
{
    
    MainTableViewController *vc=[[MainTableViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"rectangle_2"] forBarMetrics:UIBarMetricsDefault];
    vc.mainPostImage=self.startImageView.image;
    [self presentViewController:nav animated:YES completion:nil];
}
/**
 *  返回相册
 */
-(void)returnToAlbum
{
    NSLog(@"返回");
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark --相册选取代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        _firstImage=image;
        _currentImage=image;
        _startImageView.image=image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  保存图片
 */
-(void)savePhoto
{
    NSLog(@"保存");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
    alert.tag=2;
    alert.delegate = self;
    [alert show];
}
#pragma mark--alert代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==2) {
        if(buttonIndex == 1)
        {
            UIImage *img = _startImageView.image;// 要保存的图片
            UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);// 保存图片到相册中
        }
    }
    if (alertView.tag==1) {
        if(buttonIndex == 1)
        {
            NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
            //分界线 --AaB03x
            NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
            //结束符 AaB03x--
            NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
            //获取access_token的值和得到图片文件，转化为NSData
            NSString *txt=@"图片分享";
            UIImage *sinaImg=_startImageView.image;
            NSData *imgdata=UIImagePNGRepresentation(sinaImg);
            
            //设置上传的参数
            NSMutableString *body=[[NSMutableString alloc]init];
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"source"];
            //添加字段的值
            [body appendFormat:@"%@\r\n",@"4229803236"];
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"access_token"];
            //添加字段的值
            [body appendFormat:@"2.00faICPDS_h9KBf3c3c1fa99Qg9nRE\r\n"];
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"status"];
            //添加字段的值
            [body appendFormat:@"%@\r\n",txt];
            //    [body appendFormat:@"Content-Type: application/x-www-form-urlencoded\r\n\r\n"];
            
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //声明pic字段，文件名为568.png
            [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"14.png\"\r\n"];
            //声明上传文件的格式
            [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
            
            NSLog(@"%@",body);
            
            //声明结束符：--AaB03x--
            NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
            
            NSMutableData *myRequestData=[NSMutableData data];
            [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
            [myRequestData appendData:imgdata];
            //加入结束符--AaB03x--
            [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
            //设置HTTPHeader中Content-Type的值
            NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
            
            NSString *postlen=[NSString stringWithFormat:@"%lu",(unsigned long)[myRequestData length]];
            NSURL *url=[NSURL URLWithString:@"https://upload.api.weibo.com/2/statuses/upload.json"];
            NSMutableURLRequest *request=[[NSMutableURLRequest alloc]init];
            [request setURL:url];
            [request setHTTPMethod:@"post"];
            [request setTimeoutInterval:5];
            [request setValue:postlen forHTTPHeaderField:@"Content-Length"];
            [request setValue:content forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:myRequestData];
            NSURLConnection  *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
            [connection start];
            
        }
    }
    
}
- (void) sendImageContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    
    WXImageObject *ext = [WXImageObject object];
    
//    UIImage* image = [UIImage imageNamed:@"picture"];
//    NSLog(@"%@",image);
    ext.imageData = UIImagePNGRepresentation(_startImageView.image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存失败,请重新保存" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        //        alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [alert show];
        
    }
    else// 没有error
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end
