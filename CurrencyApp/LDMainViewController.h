//
//  LDMainViewController.h
//  CurrencyApp
//
//  Created by Cash on 13-5-12.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class LDNavigationBar;

#define kLDFxall_TopRates_Url  @"http://www.fxall.com/web-rateticker/topRates"
#define kLDRefresh_Interval    3

@interface LDMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>

@property (nonatomic, retain) NSArray       *curKeysArray;
@property (nonatomic, retain) NSDictionary  *ratesDict;

@property (nonatomic, retain) NSDictionary  *ratesDictionary;
@property (nonatomic, retain) NSString      *updateTimeString;

@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, retain) UITabBar        *tabBar;
@property (nonatomic, retain) UITableView     *contentView;
@property (nonatomic, retain) UIView          *topView;

- (IBAction)linkLdport:(id)sender;

- (IBAction)linkAnalyse:(id)sender;

@end
