//
//  NSString+RegEx.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "NSString+RegEx.h"

@implementation NSString (RegEx)

-(NSArray *)findMatchesWithPattern:(NSString *)pattern {
    return [self findMatchesWithPattern:pattern options:NSRegularExpressionCaseInsensitive];
}

-(NSArray *)findMatchesWithPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    NSError *error = NULL;
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:&error];
    if (error) {
        DDLogError(@"Error creating regular expression with pattern %@ and options provided", pattern);
        return nil;
    }
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in [exp matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0,self.length)]) {
        [strings addObject:[self substringWithRange:match.range]];
    }
    return strings;
}

-(NSArray *)findMatchesOnGroupsWithPattern:(NSString *)pattern {
    return [self findMatchesOnGroupsWithPattern:pattern options:NSRegularExpressionCaseInsensitive];
}

-(NSArray *)findMatchesOnGroupsWithPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options {
    NSError *error = NULL;
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:&error];
    if (error) {
        DDLogError(@"Error creating regular expression with pattern %@ and options provided", pattern);
        return nil;
    }
    NSMutableArray *results = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in [exp matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0,self.length)]) {
        NSMutableArray *groups = [[NSMutableArray alloc] initWithCapacity:match.numberOfRanges];
        for(NSUInteger i=1;i<match.numberOfRanges;i++) {
            [groups addObject:[self substringWithRange:[match rangeAtIndex:i]]];
        }
        [results addObjectsFromArray:groups];
    }
    return results;
}

@end
