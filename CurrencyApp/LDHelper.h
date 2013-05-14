//
//  LDHelper.h
//  CurrencyApp
//
//  Created by Cash on 13-5-14.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#ifndef CurrencyApp_LDHelper_h
#define CurrencyApp_LDHelper_h


// [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480+(iPhone5?88:0))];
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


// [view setBackgroundColor:RGBA(220, 211, 204, 1.0)];
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#endif
