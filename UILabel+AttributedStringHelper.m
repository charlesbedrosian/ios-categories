//
//  UILabel+AttributedStringHelper.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "UILabel+AttributedStringHelper.h"

@implementation UILabel (AttributedStringHelper)

-(NSAttributedString *)loadAttributedString {
    if (!self.attributedText) return nil;
    NSAttributedString *astring = self.attributedText;
    if (!astring) {
        astring = [[NSAttributedString alloc] initWithString:self.text];
    }
    return astring;
}

- (void)applyFont:(UIFont *)font {
    self.attributedText = [[self loadAttributedString] applyFont:font];
}

- (void)applyFont:(UIFont *)font kerning:(CGFloat)kerning {
    self.attributedText = [[self loadAttributedString] applyFont:font kerning:kerning];
}

- (void)applyFont:(UIFont *)font toSubstring:(NSString *)substring {
    self.attributedText = [[self loadAttributedString] applyFont:font toSubstring:substring];
}

- (void)applyColor:(UIColor *)color toSubstring:(NSString *)substring {
    self.attributedText = [[self loadAttributedString] applyColor:color toSubstring:substring];
}

- (void)applyColor:(UIColor *)color{
    self.attributedText = [[self loadAttributedString] applyColor:color];
}

- (void)applyUnderline {
    self.attributedText = [[self loadAttributedString] applyUnderline];
}

- (void)enableWordWrapping {
    self.numberOfLines = 0;
    [self sizeToFit];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    [self setAttributedText:[[self loadAttributedString] enableWordWrapping]];
}

- (void)enableWordWrappingWithAlignment:(NSTextAlignment)alignment {
    self.numberOfLines = 0;
    [self sizeToFit];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    [self setAttributedText:[[self loadAttributedString] enableWordWrappingWithAlignment:alignment]];
}

- (void)fixNumbersWithSize:(CGFloat)size {
    [self setAttributedText:[[self loadAttributedString] fixNumbersWithSize:size]];
}

- (void)fixBoldNumbersWithSize:(CGFloat)size {
    [self setAttributedText:[[self loadAttributedString] fixBoldNumbersWithSize:size]];
}

- (void) replaceAttributableText: (NSString *) text withTextToReplace: (NSString *) textToReplace {
    
    NSMutableAttributedString *newText = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [[newText mutableString] replaceOccurrencesOfString:text withString:textToReplace options:NSCaseInsensitiveSearch range:NSMakeRange(0, newText.length)];
    self.attributedText = newText;
}

@end

@implementation UIButton (AttributedStringHelper)

-(NSAttributedString *)loadAttributedString {
    NSAttributedString *astring = self.titleLabel.attributedText;
    if (!astring) {
        astring = [[NSAttributedString alloc] initWithString:self.titleLabel.text];
    }
    return astring;
}

- (void)applyFont:(UIFont *)font {
    NSAttributedString *astring = [[self loadAttributedString] applyFont:font];
    [self setAttributedTitle:astring forState:UIControlStateNormal];
}

- (void)applyColor:(UIColor *)color{
    NSAttributedString *astring = [[self loadAttributedString] applyColor:color];
    [self setAttributedTitle:astring forState:UIControlStateNormal];
}

- (void)enableWordWrapping {
    NSAttributedString *astring = [[self loadAttributedString] enableWordWrapping];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self setAttributedTitle:astring forState:UIControlStateNormal];
}

@end

@implementation NSAttributedString (AttributedStringHelper)

- (NSAttributedString *)fixNumbersWithSize:(CGFloat)size {
    return [self fixNumbersWithSize:size range:NSMakeRange(0,self.string.length)];
}

- (NSAttributedString *)fixNumbersWithSize:(CGFloat)size range:(NSRange)range {
    NSError *error = nil;
    NSMutableAttributedString *astring = [[self applyFont:[UIFont couponFontOfSize:size] range:range] mutableCopy];
    NSString *string = astring.string;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\\d+" options:0 error:&error];
    [astring beginEditing];
    NSArray *matches = [regex matchesInString:string options:0 range:range];
    for (NSTextCheckingResult *match in matches)
    {
        [astring addAttribute:NSFontAttributeName value:[UIFont couponNumberFontOfSize:size] range:match.range];
    }
    [astring endEditing];
    return astring;
}


- (NSAttributedString *)fixBoldNumbersWithSize:(CGFloat)size {
    return [self fixBoldNumbersWithSize:size range:NSMakeRange(0,self.string.length)];
}

- (NSAttributedString *)fixBoldNumbersWithSize:(CGFloat)size range:(NSRange)range {
    NSError *error = nil;
    NSMutableAttributedString *astring = [[self applyFont:[UIFont boldCouponFontOfSize:size] range:range] mutableCopy];
    NSString *string = astring.string;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"\\d+" options:0 error:&error];
    [astring beginEditing];
    NSArray *matches = [regex matchesInString:string options:0 range:range];
    for (NSTextCheckingResult *match in matches)
    {
        [astring addAttribute:NSFontAttributeName value:[UIFont boldCouponNumberFontOfSize:size] range:match.range];
    }
    [astring endEditing];
    return astring;
}


- (NSAttributedString *)enableWordWrappingWithAlignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = alignment;
    NSMutableAttributedString *astring = [self mutableCopy];
    [astring beginEditing];
    NSRange all = NSMakeRange(0, astring.length);
    [astring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:all];
    [astring endEditing];
    return astring;
}

- (NSAttributedString *)enableWordWrapping {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString *astring = [self mutableCopy];
    [astring beginEditing];
    NSRange all = NSMakeRange(0, astring.length);
    [astring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:all];
    [astring endEditing];
    return astring;
}

- (NSAttributedString *)applyFont:(UIFont *)font {
    NSRange range = NSMakeRange(0, self.length);
    return [self applyFont:font range:range];
}

- (NSAttributedString *)applyFont:(UIFont *)font toSubstring:(NSString *)substring {
    NSRange range = [self.string rangeOfString:substring];
    return [self applyFont:font range:range];
}

- (NSAttributedString *)applyFont:(UIFont *)font range:(NSRange)range {
    NSMutableAttributedString *astring = [self mutableCopy];
    [astring addAttribute:NSFontAttributeName value:font range:range];
    return astring;
}


- (NSAttributedString *)applyColor:(UIColor *)color toSubstring:(NSString *)substring {
    NSMutableAttributedString *astring = [self mutableCopy];
    NSRange range = [self.string rangeOfString:substring];
    [astring addAttribute:NSForegroundColorAttributeName value:color range:range];
    return astring;
}

- (NSAttributedString *)applyColor:(UIColor *)color{
    NSMutableAttributedString *astring = [self mutableCopy];
    NSRange range = NSMakeRange(0,self.string.length);
    [astring addAttribute:NSForegroundColorAttributeName value:color range:range];
    return astring;
}

- (NSAttributedString *)applyUnderline {
    NSMutableAttributedString *astring = [self mutableCopy];
    NSRange range = NSMakeRange(0,self.string.length);
    [astring addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    return astring;
}

- (NSAttributedString *)applyUnderlineToSubstring:(NSString *)substring {
    NSRange range = [self.string rangeOfString:substring];
    NSMutableAttributedString *astring = [self mutableCopy];
    if (range.length > 0 && ![self.string hasPrefix:@" "]) {
        [astring insertAttributedString:[[NSAttributedString alloc] initWithString:@" "] atIndex:0];
    }
    [astring addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    return astring;
}

- (NSAttributedString *)applyFont:(UIFont *)font kerning:(CGFloat)kerning {
    NSMutableAttributedString *astring = [self mutableCopy];
    [astring addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    [astring addAttribute:NSKernAttributeName value:@(kerning) range:NSMakeRange(0, self.length)];
    return astring;
}

@end

@implementation UITextField (AttributedStringHelper)

- (void)applyPlaceholder:(NSString *)text color:(UIColor *)color font:(UIFont *)font {
    NSRange all = NSMakeRange(0, text.length);
    NSMutableAttributedString *astring = [[NSMutableAttributedString alloc] initWithString:text];
    [astring addAttribute:NSForegroundColorAttributeName value:color range:all];
    [astring addAttribute:NSFontAttributeName value:font range:all];
    [self setAttributedPlaceholder:astring];
}

- (void)fixNumbersWithSize:(CGFloat)size {
    [self setAttributedText:[self.attributedText fixNumbersWithSize:size]];
}

- (void)fixBoldNumbersWithSize:(CGFloat)size {
    [self setAttributedText:[self.attributedText fixBoldNumbersWithSize:size]];
}

@end

@implementation TTTAttributedLabel (AttributedStringHelper)

- (void)makeSubstring:(NSString *)substring LinkToPhone:(NSString *)phone {
    NSRange range = [self.text rangeOfString:substring];
    [self addLinkToPhoneNumber:phone withRange:range];
}

- (void)makeSubstring:(NSString *)substring linkToAddress:(NSString *)address {
    
    NSRange range = [self.text rangeOfString:substring];
    [self addLinkToURL:[NSURL URLWithString:address] withRange:range];
    
}

@end
