//
//  LDHeadCell.m
//  CurrencyApp
//
//  Created by Cash on 13-3-10.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDHeadCell.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@implementation LDHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//      UILabel *label = nil;
//      
//      label = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 95, 32)];
//      label.font = [UIFont fontWithName:@"Verdana-Bold" size:15];
//      label.textColor = RGB(85, 85, 85);
//      label.text = @"CURRENCY";
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
