//
//  LDMainViewController.m
//  CurrencyApp
//
//  Created by Cash on 13-5-12.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDViewController.h"
#import "LDHeadCell.h"
#import "LDCurrencyCell.h"
#import "LDNavigationBar.h"

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
    _curKeysArray = [plistArray retain];
    
    _navBar  = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"FX rates"];
    [_navBar setItems:@[item]];
    
//    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 460+(iPhone5?88:0)-44, 320, 44)];
    
    CGFloat navBarHeight  = _navBar  ? _navBar.frame.size.height  : 0.0f;
    CGFloat toolBarHeight = _toolBar ? _toolBar.frame.size.height : 0.0f;
    _contentView = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarHeight, 320, 460+(iPhone5?88:0)-navBarHeight-toolBarHeight)
                                                style:UITableViewStylePlain];
    _contentView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _contentView.dataSource      = self;
    _contentView.delegate        = self;
    _contentView.backgroundColor = RGB(220, 211, 204);
    
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    _topLabel.textColor       = [UIColor whiteColor];
    _topLabel.backgroundColor = [UIColor grayColor];
    _topLabel.textAlignment   = NSTextAlignmentCenter;
    _topLabel.font            = [UIFont fontWithName:@"Verdana" size:[UIFont systemFontSize]];

  }
  return self;
}

- (void)dealloc
{
  [_curKeysArray release];
  
  [_navBar release];
  [_toolBar release];
  [_contentView release];
  [_topLabel release];
  [super dealloc];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.view setBackgroundColor:[UIColor grayColor]];
  
  if (self.navBar) {
    [self.view addSubview:self.navBar];
  }
  
  if (self.toolBar) {
    [self.view addSubview:self.toolBar];
  }
  
  if (self.contentView) {
    [self.view addSubview:self.contentView];
  }
  
  /* GCD方式实现 */
  [self refreshInBackground];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

/**
 * 更新数据并发出重绘tableview消息
 */
- (void)refreshInBackground
{
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    while (true) {
      // 下载数据
      NSString *urlString = [NSString stringWithFormat:@"%@?_=%u", kLDFxall_TopRates_Url, (NSUInteger)[[NSDate date] timeIntervalSince1970]];
      NSURL *url = [NSURL URLWithString:urlString];
      ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
      [request startSynchronous];
      NSError *error = [request error];
      if (!error) {
        self.ratesDict = [[request responseString] objectFromJSONString];
        
        self.ratesDictionary = [self.ratesDict objectForKey:@"rates"];
        self.updateTimeString = [self.ratesDict objectForKey:@"updateDateTime"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.contentView reloadData];
          [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        [NSThread sleepForTimeInterval:3];
      }
      else {
        dispatch_async(dispatch_get_main_queue(), ^{
          [MBProgressHUD hideHUDForView:self.view animated:YES];
          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                          message:@"连接服务器失败！"
                                                         delegate:self
                                                cancelButtonTitle:@"取消"
                                                otherButtonTitles:@"尝试重连", nil];
          [alert show];
          [alert release];
        });
        break;
      }
    }
  });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
  switch (buttonIndex) {
    case 1: //尝试重连
      [self refreshInBackground];
      break;
      
    default: //取消
      break;
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if (self.topView) {
    return self.topView.frame.size.height;
  }
  else {
    return self.topLabel.frame.size.height;
  }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if (self.topView) {
    return self.topView;
  }
  else {
    if (self.updateTimeString) {
      self.topLabel.text = [NSString stringWithFormat:@"Updated %@ GMT", self.updateTimeString];
    }
    else {
      self.topLabel.text = @"Updating...";
    }
    return self.topLabel;
  }
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
  
  UITableViewCell *cell;
  
  if (indexPath.row == 0) {
    cell = [tableView dequeueReusableCellWithIdentifier:LDHeadCellIdentifier];
    if (cell == nil) {
      cell = [[[LDHeadCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:LDHeadCellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

@end