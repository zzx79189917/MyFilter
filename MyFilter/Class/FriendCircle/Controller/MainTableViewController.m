//
//  MainTableViewController.m
//  FriendCircle
//
//  Created by zzx🐹 on 15/5/26.
//  Copyright (c) 2015年 ZZX. All rights reserved.
//

#import "MainTableViewController.h"
#import "ZZXTableViewCell.h"
#import "TableViewCellFrame.h"
#import "CellData.h"
#import <BmobSDK/Bmob.h>
#import "MessageController.h"
#import "MJRefresh.h"
@interface MainTableViewController ()
{
    NSMutableArray *_feedbackArray;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithWhite:0.915 alpha:1.000];
    
    self.title=@"朋友圈";
    UIColor *color=[UIColor whiteColor];
    NSDictionary *dic=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes=dic;
    _feedbackArray=[NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    [self addData];
    [self loadData];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(sendMessage)];
//    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self loadData];
//}
-(void)sendMessage
{
    MessageController *message=[[MessageController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:message];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"rectangle_2"] forBarMetrics:UIBarMetricsDefault];
    message.postImage=self.mainPostImage;
    [self presentViewController:nav animated:YES completion:nil];}
- (void)back:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)addData
{
    BmobObject  *obj = [BmobObject objectWithClassName:@"FriendCircle"];

    [obj setObject:@"这是第四条" forKey:@"text"];
    [obj setObject:@"0" forKey:@"attitudesCount"];
    //上传图片
    UIImage *image=[UIImage imageNamed:@"img_1"];
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
//    //异步保存
//    [obj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//        if (isSuccessful) {
//            NSLog(@"sucess");
//        } else if (error){
//            //发生错误后的动作
//            NSLog(@"%@",error);
//        } else {
//            NSLog(@"Unknow error");
//        }
//    }];
}
-(void)loadData
{
//    _feedbackArray = nil;

    BmobQuery *query = [BmobQuery queryWithClassName:@"FriendCircle"];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        __weak typeof (self) wself =self;
        for (BmobObject *obj in array) {
            NSString *text=[obj objectForKey:@"text"];
            NSString *attitudesCount=[obj objectForKey:@"attitudesCount"];
            NSDate *date=[obj createdAt];
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"EEE MMM dd HH:mm:ss zzzz yyyy";
            fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            // 获得当前时间
            NSDate *now = [NSDate date];
            // 获得当前时间发送时间的间隔（差多少秒）
            NSTimeInterval delta = [now timeIntervalSinceDate:date];
            NSString *createdAt;
            // 根据时间间隔算出合理的字符串
            if (delta < 60) { // 1分钟内
                createdAt= @"刚刚";
            } else if (delta < 60 * 60) { // 1小时内
                createdAt= [NSString stringWithFormat:@"%.f分钟前", delta/60];
            } else if (delta < 60 * 60 * 24) { // 1天内
                createdAt= [NSString stringWithFormat:@"%.f小时前", delta/60/60];
            } else {
                fmt.dateFormat = @"MM-dd HH:mm";
                createdAt =[fmt stringFromDate:date];
            }
            NSString *imageName=[obj objectForKey:@"imageUrl"];
            CellData *data=[[CellData alloc] initWithText:text imageName:imageName createdAt:createdAt attitudesCount:attitudesCount];
            [_feedbackArray addObject:data];
        }
        [wself.tableView reloadData];
        [self.tableView.header endRefreshing];
            NSLog(@"%lu",(unsigned long)_feedbackArray.count);
    }];
    [_feedbackArray removeAllObjects];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _feedbackArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifer=@"Cell";
    ZZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    if (cell==nil) {
        cell=[[ZZXTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifer];
    }
//    cell.backgroundColor=[UIColor redColor];
    cell.data = _feedbackArray[indexPath.row];
    return cell;
}

//返回每一行cell高度 每次tableView刷新数据的时候都会调用 一次性算出所有高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[_feedbackArray[indexPath.row] cellFrame] cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
