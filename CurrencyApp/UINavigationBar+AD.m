//
//  UINavigationBar+AD.m
//  CurrencyApp
//
//  Created by Cash on 13-5-21.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "UINavigationBar+AD.h"

@implementation UINavigationBar (AD)

- (UIImage *)barBackground
{
  return [UIImage imageNamed:@"NavBarBg"];
}

- (void)didMoveToSuperview
{
  //iOS5 only
  if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
  {
    [self setBackgroundImage:[self barBackground] forBarMetrics:UIBarMetricsDefault];
    
    //TODO:只处理了UIBarMetricsDefault，没有处理UIBarMetricsLandscapePhone
    //NSLog(@"%D", [UIDevice currentDevice].orientation);
  }
}

//this doesn't work on iOS5 but is needed for iOS4 and earlier
- (void)drawRect:(CGRect)rect
{
  //draw image
  [[self barBackground] drawInRect:rect];
}

@end
