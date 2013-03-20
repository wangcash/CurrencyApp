//
//  LDNavigationBar.m
//  CurrencyApp
//
//  Created by Cash on 13-3-20.
//  Copyright (c) 2013年 LYFORD INTERNATIONAL TRADING PORT PTY.LTD. All rights reserved.
//

#import "LDNavigationBar.h"

@implementation LDNavigationBar
@synthesize navigationBarBackgroundImage = _navigationBarBackgroundImage;
@synthesize landscapeBarBackground = _landscapeBarBackground;
@synthesize portraitBarBackground = _portraitBarBackground;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(changeBackgroundImage:)
                                               name:UIDeviceBatteryLevelDidChangeNotification
                                             object:nil];
}

- (void)drawRect:(CGRect)rect
{
  if (self.navigationBarBackgroundImage) {
    [self.navigationBarBackgroundImage.image drawInRect:rect];
  }
  else {
    [super drawRect:rect];
  }
}

- (void)setBackgroundForDeviceOrientation:(UIDeviceOrientation)orientation
{
  self.navigationBarBackgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
  if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
    self.navigationBarBackgroundImage.image = self.landscapeBarBackground;
  }
  else if (orientation == UIDeviceOrientationPortrait) {
    self.navigationBarBackgroundImage.image = self.portraitBarBackground;
  }
  [self setNeedsDisplay];
}

- (void)clearBackground
{
  self.navigationBarBackgroundImage = nil;
  [self setNeedsDisplay];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [super dealloc];
}

- (void)changeBackgroundImage:(NSNotification *)notification
{
  UIDeviceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
  if (currentOrientation == UIDeviceOrientationPortraitUpsideDown) {
    return;
  }
  [self setBackgroundForDeviceOrientation:currentOrientation];
}

@end
