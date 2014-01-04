//
//  UIView+Resize.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "UIView+Resize.h"

@implementation UIView (Resize)

- (void)logBoundsAndFrameCourtesyOfBracken {
    DLog(@"%@", NSStringFromClass([self class]));
    DLog(@"    bounds: %@", NSStringFromCGRect(self.bounds));
    DLog(@"     frame: %@", NSStringFromCGRect(self.frame));
}

- (CGRect)fillFrame {
    return CGRectMake(0.0f,0.0f,self.width, self.height);
}

- (void) setWidth:(CGFloat)newWidth {
    CGRect f = [self frame];
    f.size.width = newWidth;
    [self setFrame:f];
}

- (void) setHeight:(CGFloat)newHeight {
    CGRect f = [self frame];
    f.size.height = newHeight;
    [self setFrame:f];
}

- (void) setWidth:(CGFloat)newWidth setHeight:(CGFloat)newHeight
{
    CGRect f = [self frame];
    f.size.width = newWidth;
    f.size.height = newHeight;
    [self setFrame:f];
}

- (void) setX:(CGFloat)newX {
    CGRect f = [self frame];
    f.origin.x = newX;
    [self setFrame:f];
}

- (void) setY:(CGFloat)newY {
    CGRect f = [self frame];
    f.origin.y = newY;
    [self setFrame:f];
}

- (void) setX:(CGFloat)newX setY:(CGFloat)newY{
    CGRect f = [self frame];
    f.origin.x = newX;
    f.origin.y = newY;
    [self setFrame:f];
}

- (void) addHeight:(CGFloat)additionalHeight
{
    CGRect f = [self frame];
    f.size.height += additionalHeight;
    [self setFrame:f];
}

- (void) subtractHeight:(CGFloat)subtractHeight
{
    CGRect f = [self frame];
    f.size.height -= subtractHeight;
    [self setFrame:f];
}

- (void) moveDown:(CGFloat)distance
{
    CGRect f = [self frame];
    f.origin.y += distance;
    [self setFrame:f];
}

+ (CGFloat)calcContentHeightForView:(UIView *)view
{
    CGFloat height = 0;
    for(UIView *subview in view.subviews) {
        height = MAX(height, (subview.frame.origin.y + subview.frame.size.height));
    }
    return height;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    [self setX:(right - self.width)];
}

- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)left {
    [self setX:left];
}

- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)top {
    [self setY:top];
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    [self setY:(bottom - self.height)];
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

+ (CGPoint)pointFromViewRight:(UIView *)view {
    CGPoint p = CGPointMake(view.right, (view.top + view.height)/2);
    return p;
}

- (void)centerInRect:(CGRect)frame {
    self.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);
}

- (void)moveLeft:(CGFloat)left andDown:(CGFloat)down {
    CGRect frame = self.frame;
    frame.origin.x -= left;
    frame.origin.y += down;
    self.frame = frame;
}

+ (void)centerHorizontallyViewSeries:(NSArray *)views inRect:(CGRect)rect {
    CGFloat left, right;
    for(UIView *view in views)
    {
        left  = MIN(left,  view.left);
        right = MAX(right, view.right);
    }
    float delta = left - ((rect.size.width - right - left) / 2);
    for(UIView *view in views)
    {
        [view setX:view.left - delta];
    }
}

@end
