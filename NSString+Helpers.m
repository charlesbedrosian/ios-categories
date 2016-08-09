//
//  NSString+Helpers.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "NSString+Helpers.h"
#import <Foundation/Foundation.h>

@implementation NSString (Helpers)

- (NSDate *)dateFromWebServiceString {
    return [self dateFromWebServiceStringUsingDefault:[NSDate dateWithTimeIntervalSince1970:0]];
}

- (NSDate *)dateFromWebServiceStringUsingDefault:(NSDate *)defaultDate {
    
    NSRange dateRange = [self rangeOfString:@"Date("];
    if (dateRange.location == NSNotFound) {
        return defaultDate;
    }
    NSRange dateEndRange = [self rangeOfString:@")"];
    if (dateEndRange.location == NSNotFound) {
        return defaultDate;
    }
    int dateLength = dateEndRange.location - dateRange.location - 8;
    if ( dateLength < 0 ) {
        return defaultDate;
    }
    NSString *timestampString = [self substringWithRange:NSMakeRange(dateRange.location + 5, dateEndRange.location - dateRange.location - 5 - 3)];
    // NSLog(@"stringDate = %@, TimestampString = %@", stringDate, timestampString);
    NSDate *result = [NSDate dateWithTimeIntervalSince1970:[timestampString doubleValue]];
    
    // NSLog(@"Date = %@", result);
    return result;
}

- (BOOL)isValidUrl {
    if (!self) {
        return NO;
    }

    NSString *lower = [self lowercaseString];
    return (
        [lower hasPrefix:@"http://"]      ||
        [lower hasPrefix:@"https://"]
    );
}

- (NSString *)wordAtPoint:(NSUInteger)position {
    return [self substringWithRange:[self rangeOfWordAtPoint:position]];
}

- (NSRange)rangeOfWordAtPoint:(NSUInteger)position {
    __block NSRange wordFound = NSMakeRange(0,0);
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByWords
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if (NSRangeContainsRange(substringRange,position)) {
                                  wordFound = substringRange;
                                  //check one character back to pick up the trigger character
                                  if (substringRange.location > 0) {
                                      NSRange rangeWithTrigger = NSMakeRange(substringRange.location - 1, substringRange.length + 1);
                                      NSString *substringWithTrigger = [self substringWithRange:rangeWithTrigger];
                                      if ([substringWithTrigger hasPrefix:@"@"] || [substringWithTrigger hasPrefix:@"#"]) {
                                          wordFound = rangeWithTrigger;
                                      }
                                  }
                                  *stop = YES;
                              }
                          }
     ];
    return wordFound;
}

bool NSRangeContainsRange (NSRange range1, NSUInteger position) {
    return (position >= range1.location && position <= (range1.location + range1.length));
}
@end
