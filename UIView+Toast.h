//
//  UIView+Toast.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Toast)

- (void)toastWithMessage:(NSString*)text;
- (void)toastWithMessage:(NSString*)text displayForSeconds:(CGFloat)time;

@end
