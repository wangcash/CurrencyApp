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
    
//    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 460+(iPhone5?88:0)-44, 320, 44)];
  }
  return self;
}

@end
