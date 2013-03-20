//
//  LDNavigationBar.h
//  CurrencyApp
//
//  Created by Cash on 13-3-20.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDNavigationBar : UINavigationBar

@property (nonatomic, strong) UIImageView *navigationBarBackgroundImage;
@property (nonatomic, strong) UIImage *landscapeBarBackground;
@property (nonatomic, strong) UIImage *portraitBarBackground;

- (void)setBackgroundForDeviceOrientation:(UIDeviceOrientation)orientation;
- (void)clearBackground;

@end
