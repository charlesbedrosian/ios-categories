//
//  NSString+Convenience.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "NSString+Convenience.h"

@implementation NSString (Convenience)

- (NSDate *)dateFromWebServiceStringIgnoringTimezone {
    NSDate *date = [self dateFromWebServiceString];
    
    NSTimeInterval timeZoneOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSTimeInterval gmtTimeInterval = [date timeIntervalSinceReferenceDate] - timeZoneOffset;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:gmtTimeInterval];
}

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
    int dateLength = (int)dateEndRange.location - (int)dateRange.location - 8;
    if ( dateLength < 0 ) {
        return defaultDate;
    }
    NSString *timestampString = [self substringWithRange:NSMakeRange(dateRange.location + 5, dateEndRange.location - dateRange.location - 5 - 3)];
    // DDLogDebug(@"stringDate = %@, TimestampString = %@", stringDate, timestampString);
    NSDate *result = [NSDate dateWithTimeIntervalSince1970:[timestampString doubleValue]];
    
    // DDLogDebug(@"Date = %@", result);
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

- (NSString *)removeRepeatingSlashes {
    NSError *error = nil;
    static NSRegularExpression *regex = nil;
    if (!regex) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"/+" options:NSRegularExpressionCaseInsensitive error:&error];
    }

    NSString *temp = self;
    NSString *protocol = @"";
    NSRange protocolRange = [temp rangeOfString:@"://"];
    if (protocolRange.location != NSNotFound) {
        NSInteger start = protocolRange.location + protocolRange.length;
        protocol = [temp substringWithRange:NSMakeRange(0,start)];
        temp = [temp substringWithRange:NSMakeRange(start,[temp length]-start)];
    }
    NSString *result =[regex stringByReplacingMatchesInString:temp options:0 range:NSMakeRange(0, [temp length]) withTemplate:@"/"];
    result = [NSString stringWithFormat:@"%@%@", protocol, result];
    return result;
}

- (BOOL)isValidDate {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *date = [dateFormatter dateFromString:self];
    if (date) {
        return YES;
    }
    return NO;
}

- (BOOL)containsSubstring:(NSString *)substring {
    if ([self respondsToSelector:@selector(containsString:)]) {
        return [self containsString:substring];
    } else {
        return ([self rangeOfString:substring].location != NSNotFound);
    }
}

- (NSString *)stringByRemovingNonDigits {
    return [[self componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
}

@end
