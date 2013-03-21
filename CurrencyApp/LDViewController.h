//
//  LDViewController.h
//  CurrencyApp
//
//  Created by Cash on 13-3-5.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class LDNavigationBar;

#define kLDFxall_TopRates_Url  @"http://www.fxall.com/web-rateticker/topRates"
#define kLDRefresh_Interval    3

@interface LDViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>

@property (nonatomic, retain) NSArray       *curKeysArray;
@property (nonatomic, retain) NSDictionary  *ratesDictionary;

@property (nonatomic, retain) IBOutlet UITableView *contentView;

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIAlertView *alertor;

- (IBAction)linkLdport:(id)sender;

- (IBAction)linkAnalyse:(id)sender;

@end
