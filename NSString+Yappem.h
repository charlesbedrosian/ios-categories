//
//  NSString+Helpers.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

- (NSDate *)dateFromWebServiceString;
- (NSDate *)dateFromWebServiceStringUsingDefault:(NSDate *)defaultDate;
- (BOOL)isValidUrl;
- (NSString *)wordAtPoint:(NSUInteger)position;
- (NSRange)rangeOfWordAtPoint:(NSUInteger)position;

@end
