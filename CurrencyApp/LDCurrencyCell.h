//
//  LDCurrencyCell.h
//  CurrencyApp
//
//  Created by Cash on 13-3-5.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTLabel;

@interface LDCurrencyCell : UITableViewCell

@property (nonatomic, copy) NSString *curKey;
@property (nonatomic, copy) NSString *curBid;
@property (nonatomic, copy) NSString *curOffer;
@property (nonatomic, copy) NSString *curChange;
@property (nonatomic, copy) NSString *curLow;
@property (nonatomic, copy) NSString *curHigh;

@property (nonatomic, retain) RTLabel *currencyLabel;
@property (nonatomic, retain) RTLabel *bidLabel;
@property (nonatomic, retain) RTLabel *offerLabel;
@property (nonatomic, retain) RTLabel *changeLabel;
@property (nonatomic, retain) RTLabel *lowLabel;
@property (nonatomic, retain) RTLabel *highLabel;

@end
