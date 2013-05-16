//
//  LDMainViewController.h
//  CurrencyApp
//
//  Created by Cash on 13-5-12.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "LDHelper.h"
#import "LoggerClient.h"

@class LDNavigationBar;

#define kLDFxall_TopRates_Url  @"http://www.fxall.com/web-rateticker/topRates"
#define kLDRefresh_Interval    3

@interface LDViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MBProgressHUDDelegate>

@property (nonatomic, retain) NSArray       *curKeysArray;
@property (nonatomic, retain) NSDictionary  *ratesDict;

@property (nonatomic, retain) NSDictionary  *ratesDictionary;
@property (   atomic, retain) NSString      *updateTimeString;

@property (nonatomic, retain) UINavigationBar *navBar;
@property (nonatomic, retain) UIToolbar       *toolBar;

@property (nonatomic, retain) UITableView     *contentView;
@property (nonatomic, retain) UIView          *topView;
@property (nonatomic, retain) UILabel         *topLabel;

@end
