//
//  OauthViewController.m
//  shareMessage
//
//  Created by zzx🐹 on 15/2/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "OauthViewController.h"
#import "Config.h"
#import "ZZXEditViecController.h"
@interface OauthViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@end

@implementation OauthViewController

-(void)loadView
{
    _webView=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor=[UIColor redColor];
    self.view=_webView;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
    //加载登陆界面
    NSString *urlStr=[kWBAuthorizeURL stringByAppendingFormat:@"?display=mobile&client_id=%@&redirect_uri=%@",kWBAppKey,kWBRedirectURI];
//    NSString *urlStr=[kRRAuthorizeURL stringByAppendingFormat:@"?display=mobile&client_id=%@&scope=read_user_blog+publish_blog&redirect_uri=%@&response_type=code",kRRAppKey,kRRRedirectURI];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSLog(@"%@",url);
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    NSLog(@"%@",request);
    [_webView loadRequest:request];
    
    //设置代理
    _webView.delegate=self;
    
}
#pragma mark-设置webview代理
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //获得全路径
    NSString *urlStr=request.URL.absoluteString;
    //查找code=范围
    NSRange range=[urlStr rangeOfString:@"code="];
    if (range.length!=0) {
        NSInteger index=range.location+range.length;
        NSString *requestToken=[urlStr substringFromIndex:index];
                NSLog(@"requestToken:%@",requestToken);
        [self getAccessToken:requestToken];
}
//    self.view.window.rootViewController=[[MainViewController alloc]init];
    
    return YES;
}

#pragma mark-获取accessToken
-(void)getAccessToken:(NSString*)requestToken
{
    NSString *param=[kWBGetAccessTokenURL stringByAppendingFormat:@"?client_id=%@&redirect_uri=%@&client_secret=%@&grant_type=authorization_code&code=%@",kWBAppKey,kWBRedirectURI,kWBAppSecret,requestToken];
//    NSString *param=[kRRGetAccessTokenURL stringByAppendingFormat:@"?client_id=%@&redirect_uri=%@&client_secret=%@&grant_type=authorization_code&code=%@",kRRAppKey,kRRRedirectURI,kRRAppSecret,requestToken];
    [self getParam:param];

}
-(void)getParam:(NSString*)param
{
    //access_token调用的URL
    NSURL *urlString=[NSURL URLWithString:param];
    //创建请求
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:urlString cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSString *str=@"type=focus-c";
    NSData *data=[str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    //连接服务器
    NSData *received=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str1=[[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
    NSLog(@"返回数据%@",str1);
    NSError *error;
    //获取access_token
    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:&error];
    NSString *access_token=[dictionary objectForKey:@"access_token"];
    NSLog(@"access_token:%@",access_token);
    
    _accessToken=access_token;
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:_accessToken forKey:@"RR"];
    self.view.window.rootViewController=[[ZZXEditViecController alloc]init];
}
@end
