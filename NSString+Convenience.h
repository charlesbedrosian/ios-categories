//
//  NSString+Convenience.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Convenience)

- (NSDate *)dateFromWebServiceString;
- (NSDate *)dateFromWebServiceStringUsingDefault:(NSDate *)defaultDate;
- (BOOL)isValidUrl;
- (NSString *)wordAtPoint:(NSUInteger)position;
- (NSRange)rangeOfWordAtPoint:(NSUInteger)position;
- (NSDate *)dateFromWebServiceStringIgnoringTimezone;
- (NSString *)removeRepeatingSlashes;
- (BOOL)isValidDate;
- (BOOL)containsSubstring:(NSString *)substring;
- (NSString *)stringByRemovingNonDigits;

@end
