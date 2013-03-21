//
//  LDViewController.m
//  CurrencyApp
//
//  Created by Cash on 13-3-5.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDViewController.h"
#import "LDHeadCell.h"
#import "LDCurrencyCell.h"
#import "LDNavigationBar.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"

#define __Used_NSTimer__

@interface LDViewController ()



@end

@implementation LDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    //读入CurrencyKyes备用
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistURL = [bundle URLForResource:@"CurrencyKeys" withExtension:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfURL:plistURL];
    self.curKeysArray = plistArray;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
#ifdef __Used_NSTimer__
  /* NSTimer方式实现 */
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
  [self refreshInBackground];
  [self makeTimer];
#else
  /* GCD方式实现 */
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    while (true) {
      // 下载数据
      NSString *urlString = [NSString stringWithFormat:@"%@?_=%u", kLDFxall_TopRates_Url, (NSUInteger)[[NSDate date] timeIntervalSince1970]];
      NSURL *url = [NSURL URLWithString:urlString];
      NSString *responseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
      NSDictionary *dict = [responseString objectFromJSONString];
      self.ratesDictionary = [dict objectForKey:@"rates"];
      //NSLog(@"%@", responseString);

      dispatch_async(dispatch_get_main_queue(), ^{
        [self.contentView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
      });

      [NSThread sleepForTimeInterval:3];
    }
  });
#endif
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#ifdef __Used_NSTimer__
- (void)makeTimer
{
  if (self.timer == nil) {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kLDRefresh_Interval
                                                  target:self
                                                selector:@selector(refreshInBackground)
                                                userInfo:nil
                                                 repeats:YES];
  }
}

- (void)destroyTimer
{
  if (self.timer) {
    [self.timer invalidate];
    self.timer = nil;
  }
}

- (void)showAlert
{
  if (self.alertor == nil) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                    message:@"连接服务器失败！"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"尝试重连", nil];
    self.alertor = alert;
    [alert release];
    
    [self.alertor show];
  }
}

/**
 * 更新数据并发出重绘tableview消息
 */
- (void)refreshInBackground
{
  NSString *urlString = [NSString stringWithFormat:@"%@?_=%u", kLDFxall_TopRates_Url, (NSUInteger)[[NSDate date] timeIntervalSince1970]];
  
  NSURL *url = [NSURL URLWithString:urlString];
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  [request setCompletionBlock:^{
    NSString *responseString = [request responseString];
    NSDictionary *dict = [responseString objectFromJSONString];
    self.ratesDictionary = [dict objectForKey:@"rates"];
    [self.contentView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
  }];
  [request setFailedBlock:^{
    //NSError *error = [request error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self destroyTimer];
    [self showAlert];

    NSLog(@"alert");
  }];
  [request startAsynchronous];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  switch (buttonIndex) {
    case 1: //尝试重连
      [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      [self refreshInBackground];
      [self makeTimer];
      break;
      
    default: //取消
      break;
  }
  self.alertor = nil;
}
#endif

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
  
  [view setBackgroundColor:[UIColor grayColor]];
  
  UILabel *labelTop = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
  labelTop.textColor = [UIColor whiteColor];
  labelTop.backgroundColor = [UIColor clearColor];
  labelTop.textAlignment = NSTextAlignmentCenter;
  labelTop.text = @"总行交易员的外汇知识和交易技巧";
  [view addSubview:labelTop];
  [labelTop release];
  
  UILabel *labelBottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
  labelBottom.textColor = [UIColor whiteColor];
  labelBottom.backgroundColor = [UIColor clearColor];
  labelBottom.textAlignment = NSTextAlignmentCenter;
  labelBottom.text = @"立体式思维解析外汇市场";
  [view addSubview:labelBottom];
  [labelBottom release];
  
  return [view autorelease];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.curKeysArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0) {
    return 40;
  }
  else {
    return 60;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *LDCurrencyCellIdentifier = @"LDCurrencyCellIdentifier";
  static NSString *LDHeadCellIdentifier = @"LDHeadCellIdentifier";
  
  static BOOL nibsRegistered = NO;
  if (!nibsRegistered) {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      [tableView registerNib:[UINib nibWithNibName:@"LDHeadCell_iPhone" bundle:nil]
      forCellReuseIdentifier:LDHeadCellIdentifier];
      
//      [tableView registerNib:[UINib nibWithNibName:@"LDCurrencyCell_iPhone" bundle:nil]
//      forCellReuseIdentifier:LDCurrencyCellIdentifier];
    } else {
      [tableView registerNib:[UINib nibWithNibName:@"LDHeadCell_iPad" bundle:nil]
      forCellReuseIdentifier:LDHeadCellIdentifier];
      
//      [tableView registerNib:[UINib nibWithNibName:@"LDCurrencyCell_iPad" bundle:nil]
//      forCellReuseIdentifier:LDCurrencyCellIdentifier];
    }
    nibsRegistered = YES;
  }
  
  UITableViewCell *cell;
  
  if (indexPath.row == 0) {
    cell = [tableView dequeueReusableCellWithIdentifier:LDHeadCellIdentifier];
    if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:LDHeadCellIdentifier] autorelease];
    }
    
  }
  else {
    cell = [tableView dequeueReusableCellWithIdentifier:LDCurrencyCellIdentifier];
    if (cell == nil) {
      cell = [[[LDCurrencyCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:LDCurrencyCellIdentifier] autorelease];
    }
    
    NSDictionary *curDictionary = [self.ratesDictionary objectForKey:[self.curKeysArray objectAtIndex:indexPath.row - 1]];
    
    LDCurrencyCell *curCell = (LDCurrencyCell *)cell;
    curCell.curKey = [curDictionary objectForKey:@"instrument"];
    curCell.curBid = [curDictionary objectForKey:@"formattedBid"];
    curCell.curOffer = [curDictionary objectForKey:@"formattedAsk"];
    curCell.curChange = [curDictionary objectForKey:@"formattedChange"];
    curCell.curLow = [curDictionary objectForKey:@"formattedLow"];
    curCell.curHigh = [curDictionary objectForKey:@"formattedHigh"];
  }
  
  return cell;
}

- (void)linkLdport:(id)sender
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ldport.com/"]]; 
}

- (IBAction)linkAnalyse:(id)sender
{
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ldport.com/plus/list.php?tid=132"]]; 
}

@end
