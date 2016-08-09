//
//  NSString+RegEx.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RegEx)

-(NSArray *)findMatchesWithPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;
-(NSArray *)findMatchesWithPattern:(NSString *)pattern;
-(NSArray *)findMatchesOnGroupsWithPattern:(NSString *)pattern options:(NSRegularExpressionOptions)options;
-(NSArray *)findMatchesOnGroupsWithPattern:(NSString *)pattern;

@end
