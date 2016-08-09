//
//  UIView+Convenience.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Convenience)

- (UIViewController *)parentViewController;
- (void)addDropShadowRight:(CGFloat)right bottom:(CGFloat)bottom opacity:(CGFloat)opacity;

@end
