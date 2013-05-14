//
//  LDCurrencyCell.m
//  CurrencyApp
//
//  Created by Cash on 13-3-5.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDCurrencyCell.h"
#import "RTLabel.h"
#import "LDHelper.h"

@implementation LDCurrencyCell

@synthesize curKey    = _curKey;
@synthesize curBid    = _curBid;
@synthesize curOffer  = _curOffer;
@synthesize curChange = _curChange;
@synthesize curLow    = _curLow;
@synthesize curHigh   = _curHigh;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 覆盖背景颜色
    UIView *view = nil;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 310, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view release];
    view = nil;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(5, 30, 95, 30)];
    view.backgroundColor = RGB(238, 233, 230);
    [self.contentView addSubview:view];
    [view release];
    view = nil;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(101, 30, 103, 30)];
    view.backgroundColor = RGB(238, 233, 230);
    [self.contentView addSubview:view];
    [view release];
    view = nil;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(205, 30, 110, 30)];
    view.backgroundColor = RGB(238, 233, 230);
    [self.contentView addSubview:view];
    [view release];
    view = nil;
    
    // 覆盖label
    self.currencyLabel = [[RTLabel alloc] initWithFrame:CGRectMake(7, 5, 95, 21)];
    [self.currencyLabel setTextAlignment:RTTextAlignmentLeft];
    [self.contentView addSubview:self.currencyLabel];
    [self.currencyLabel release];
    
    self.bidLabel = [[RTLabel alloc] initWithFrame:CGRectMake(96, 2, 103, 25)];
    [self.bidLabel setTextAlignment:RTTextAlignmentRight];
    [self.contentView addSubview:self.bidLabel];
    [self.bidLabel release];
    
    self.offerLabel = [[RTLabel alloc] initWithFrame:CGRectMake(200, 2, 110, 25)];
    [self.offerLabel setTextAlignment:RTTextAlignmentRight];
    [self.contentView addSubview:self.offerLabel];
    [self.offerLabel release];
    
    self.changeLabel = [[RTLabel alloc] initWithFrame:CGRectMake(7, 35, 95, 21)];
    [self.changeLabel setTextAlignment:RTTextAlignmentLeft];
    [self.contentView addSubview:self.changeLabel];
    [self.changeLabel release];
    
    self.lowLabel = [[RTLabel alloc] initWithFrame:CGRectMake(96, 32, 103, 25)];
    [self.lowLabel setTextAlignment:RTTextAlignmentRight];
    [self.contentView addSubview:self.lowLabel];
    [self.lowLabel release];
    
    self.highLabel = [[RTLabel alloc] initWithFrame:CGRectMake(200, 32, 110, 25)];
    [self.highLabel setTextAlignment:RTTextAlignmentRight];
    [self.contentView addSubview:self.highLabel];
    [self.highLabel release];
  }
  return self;
}

- (void)dealloc
{
  self.curKey     = nil;
  self.curBid     = nil;
  self.curOffer   = nil;
  self.curChange  = nil;
  self.curLow     = nil;
  self.curHigh    = nil;
  
  self.currencyLabel  = nil;
  self.bidLabel       = nil;
  self.offerLabel     = nil;
  self.changeLabel    = nil;
  self.lowLabel       = nil;
  self.highLabel      = nil;
  
  [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)setCurKey:(NSString *)curKey
{
  if (![curKey isEqualToString:_curKey]) {
    id t = [curKey copy];
    [_curKey release];
    _curKey = t;

    if (self.curKey != nil) {
      NSString *string = [NSString stringWithFormat:@"<font face='Verdana-Bold' size=16 color='#000066'>%@</font>", self.curKey];
      [self.currencyLabel setText:string];
    }
  }
}

- (void)setCurBid:(NSString *)curBid
{
  if (![curBid isEqualToString:_curBid]) {
    id t = [curBid copy];
    [_curBid release];
    _curBid = t;

    if (self.curBid != nil) {
      NSString *string = [NSString stringWithFormat:@"<font face='Verdana' size=16 color='#000066'>%@", self.curBid];
      string = [string stringByReplacingOccurrencesOfString:@"<span class='dpsBig'>"
                                                 withString:@"</font><font face='Verdana' size=20 color='#000066'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span><span class='dpsSmall'>"
                                                 withString:@"</font><font face='Verdana' size=16 color='#999999'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span>" withString:@"</font>"];
      [self.bidLabel setText:string];
    }
  }
}

- (void)setCurOffer:(NSString *)curOffer
{
  if (![curOffer isEqualToString:_curOffer]) {
    id t = [curOffer copy];
    [_curOffer release];
    _curOffer = t;
    
    if (self.curOffer != nil) {
      NSString *string = [NSString stringWithFormat:@"<font face='Verdana' size=16 color='#000066'>%@", self.curOffer];
      string = [string stringByReplacingOccurrencesOfString:@"<span class='dpsBig'>"
                                                 withString:@"</font><font face='Verdana' size=20 color='#000066'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span><span class='dpsSmall'>"
                                                 withString:@"</font><font face='Verdana' size=16 color='#999999'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span>" withString:@"</font>"];
      [self.offerLabel setText:string];
    }
  }
}

- (void)setCurChange:(NSString *)curChange
{
  if (![curChange isEqualToString:_curChange]) {
    id t = [curChange copy];
    [_curChange release];
    _curChange = t;
    
    if (self.curChange != nil) {
      NSString *string = [NSString stringWithFormat:@"<font face='Verdana-Bold' size=16 color='#000066'>△%@</font>", self.curChange];
      [self.changeLabel setText:string];
    }
  }
}

- (void)setCurLow:(NSString *)curLow
{
  if (![curLow isEqualToString:_curLow]) {
    id t = [curLow copy];
    [_curLow release];
    _curLow = t;
    
    if (self.curLow != nil) {
      NSString *string = [NSString stringWithFormat:@"<font face='Verdana' size=16 color='#000066'>L:%@", self.curLow];
      string = [string stringByReplacingOccurrencesOfString:@"<span class='dpsBig'>"
                                                 withString:@"</font><font face='Verdana' size=20 color='#000066'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span><span class='dpsSmall'>"
                                                 withString:@"</font><font face='Verdana' size=16 color='#999999'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span>" withString:@"</font>"];
      [self.lowLabel setText:string];
    }
  }
}

-(void)setCurHigh:(NSString *)curHigh
{
  if (![curHigh isEqualToString:_curHigh]) {
    id t = [curHigh copy];
    [_curHigh release];
    _curHigh = t;
    
    if (self.curHigh != nil) {
      NSString *string = [NSString stringWithFormat:@"<font face='Verdana' size=16 color='#000066'>H:%@", self.curHigh];
      string = [string stringByReplacingOccurrencesOfString:@"<span class='dpsBig'>"
                                                 withString:@"</font><font face='Verdana' size=20 color='#000066'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span><span class='dpsSmall'>"
                                                 withString:@"</font><font face='Verdana' size=16 color='#999999'>"];
      string = [string stringByReplacingOccurrencesOfString:@"</span>" withString:@"</font>"];
      [self.highLabel setText:string];
    }
  }
}
@end
