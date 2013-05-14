//
//  LDAppDelegate.h
//  CurrencyApp
//
//  Created by Cash on 13-3-5.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LDViewController;
@class LDMainViewController;

@interface LDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LDViewController *viewController;
@property (strong, nonatomic) LDMainViewController *mainViewController;

@end
