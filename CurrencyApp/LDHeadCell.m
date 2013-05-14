//
//  LDHeadCell.m
//  CurrencyApp
//
//  Created by Cash on 13-3-10.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDHeadCell.h"
#import "LDHelper.h"

@implementation LDHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      UILabel *currency = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 95, 32)];
      currency.font = [UIFont fontWithName:@"Verdana-Bold" size:15];
      currency.backgroundColor = [UIColor clearColor];
      currency.textColor = RGB(85, 85, 85);
      currency.text = @"CURRENCY";
      currency.textAlignment = NSTextAlignmentLeft;
      [self addSubview:currency];
      
      UILabel *bid = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, 105, 32)];
      bid.font = [UIFont fontWithName:@"Verdana-Bold" size:15];
      bid.backgroundColor = [UIColor clearColor];
      bid.textColor = RGB(85, 85, 85);
      bid.text = @"BID";
      bid.textAlignment = NSTextAlignmentRight;
      [self addSubview:bid];
      
      UILabel *offer = [[UILabel alloc] initWithFrame:CGRectMake(205, 8, 110, 32)];
      offer.font = [UIFont fontWithName:@"Verdana-Bold" size:15];
      offer.backgroundColor = [UIColor clearColor];
      offer.textColor = RGB(85, 85, 85);
      offer.text = @"OFFER";
      offer.textAlignment = NSTextAlignmentRight;
      [self addSubview:offer];
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
