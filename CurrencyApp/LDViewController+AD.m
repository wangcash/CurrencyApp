//
//  LDViewController+AD.m
//  CurrencyApp
//
//  Created by Cash on 13-5-21.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDViewController+AD.h"

@implementation LDViewController (AD)

- (id)init
{
  self = [super init];
  if (self) {
    //去掉NavBar上显示文字。
    [self.navBar setItems:nil];
    
    //表格top上的广告文字
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
    
    self.topView = view;
    [view release];
    
//    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 460+(iPhone5?88:0)-44, 320, 44)];
  }
  return self;
}

@end
