//
//  UILabel+AttributedStringHelper.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel.h>

@interface UILabel (AttributedStringHelper)

- (void)applyFont:(UIFont *)font;
- (void)applyFont:(UIFont *)font toSubstring:(NSString *)substring;
- (void)applyColor:(UIColor *)color toSubstring:(NSString *)substring;
- (void)applyColor:(UIColor *)color;
- (void)enableWordWrapping;
- (void)enableWordWrappingWithAlignment:(NSTextAlignment)alignment;
- (void)applyUnderline;
- (void)fixNumbersWithSize:(CGFloat)size;
- (void)fixBoldNumbersWithSize:(CGFloat)size;
- (void)applyFont:(UIFont *)font kerning:(CGFloat)kerning;
- (void) replaceAttributableText: (NSString *) text withTextToReplace: (NSString *) textToReplace;

@end

@interface UITextField (AttributedStringHelper)

- (void)applyPlaceholder:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
- (void)fixNumbersWithSize:(CGFloat)size;

@end

@interface TTTAttributedLabel (AttributedStringHelper)

- (void)makeSubstring:(NSString *)substring linkToAddress:(NSString *)address;
- (void)makeSubstring:(NSString *)substring LinkToPhone:(NSString *)phone;

@end

@interface UIButton (AttributedStringHelper)

- (void)applyFont:(UIFont *)font;
- (void)applyColor:(UIColor *)color;
- (void)enableWordWrapping;

@end

@interface NSAttributedString (AttributedStringHelper)

- (NSAttributedString *)fixNumbersWithSize:(CGFloat)size range:(NSRange)range;
- (NSAttributedString *)fixBoldNumbersWithSize:(CGFloat)size range:(NSRange)range;
- (NSAttributedString *)fixNumbersWithSize:(CGFloat)size;
- (NSAttributedString *)fixBoldNumbersWithSize:(CGFloat)size;
- (NSAttributedString *)enableWordWrapping;
- (NSAttributedString *)enableWordWrappingWithAlignment:(NSTextAlignment)alignment;
- (NSAttributedString *)applyFont:(UIFont *)font;
- (NSAttributedString *)applyFont:(UIFont *)font toSubstring:(NSString *)substring;
- (NSAttributedString *)applyColor:(UIColor *)color toSubstring:(NSString *)substring;
- (NSAttributedString *)applyColor:(UIColor *)color;
- (NSAttributedString *)applyUnderline;
- (NSAttributedString *)applyFont:(UIFont *)font kerning:(CGFloat)kerning;
- (NSAttributedString *)applyFont:(UIFont *)font range:(NSRange)range;

@end