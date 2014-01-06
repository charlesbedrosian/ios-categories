//
//  UIView+Resize.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Resize)

- (void)setWidth:(CGFloat)newWidth;
- (void)setHeight:(CGFloat)newHeight;
- (void)setX:(CGFloat)newX;
- (void)setX:(CGFloat)newX setY:(CGFloat)newY;
- (void)setY:(CGFloat)newY;
- (void)setWidth:(CGFloat)newWidth setHeight:(CGFloat)newHeight;
- (void)addHeight:(CGFloat)additionalHeight;
- (void)subtractHeight:(CGFloat)subtractHeight;
- (void)moveDown:(CGFloat)distance;
- (void)moveLeft:(CGFloat)left andDown:(CGFloat)down;
- (void)centerInRect:(CGRect)frame;

- (CGRect)fillFrame;

- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)left;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;

- (void)setRight:(CGFloat)right;
- (void)setTop:(CGFloat)top;
- (void)setLeft:(CGFloat)left;
- (void)setBottom:(CGFloat)bottom;

+ (CGFloat)calcContentHeightForView:(UIView *)view;
+ (CGPoint)pointFromViewRight:(UIView *)view;
+ (void)centerHorizontallyViewSeries:(NSArray *)views inRect:(CGRect)rect;

@end

CG_INLINE CGRect
CGRectFromSize(CGSize size)
{
    return CGRectMake(0.0f, 0.0f, size.width, size.height);
}

CG_INLINE CGSize
CGMaxSize(CGSize a, CGSize b)
{
    return CGSizeMake(MAX(a.width, b.width), MAX(a.height, b.height));
}

CG_INLINE CGSize
CGMinSize(CGSize a, CGSize b)
{
    return CGSizeMake(MIN(a.width, b.width), MIN(a.height, b.height));
}

CG_INLINE CGSize
CGSquare(CGFloat a)
{
    return CGSizeMake(a,a);
}