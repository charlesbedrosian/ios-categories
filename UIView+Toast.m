//
//  UIView+Toast.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "UIView+Toast.h"
#import "MBProgressHUD.h"

@implementation UIView (Toast)

- (void)toastWithMessage:(NSString*)text {
    [self toastWithMessage:text displayForSeconds:3.0f];
}

- (void)toastWithMessage:(NSString*)text displayForSeconds:(CGFloat)time {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [self addSubview:hud];
    [hud show:NO];
    [hud hide:NO afterDelay:time];
}

@end
