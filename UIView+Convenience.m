//
//  UIView+Convenience.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "UIView+Convenience.h"

@implementation UIView (Convenience)

- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    if ([responder isKindOfClass:[UIViewController class]])
        return (UIViewController *)responder;
    return nil;
}

- (void)addDropShadowRight:(CGFloat)right bottom:(CGFloat)bottom opacity:(CGFloat)opacity {
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(right,bottom);
    self.layer.shadowOpacity = opacity;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
}

@end
