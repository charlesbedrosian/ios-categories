//
//  Formatters.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "Formatters.h"

@implementation NSNumber (Formatters)

-(NSString *)pretty {
    static NSNumberFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [NSNumberFormatter new];
        [formatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    }
    return [formatter stringFromNumber:self];
}

@end

@implementation NSString (Formatters)

- (NSString *)addS:(int)i {
    return [NSString stringWithFormat:@"%@%@", self, (i == 1 ? @"" : @"s")];
}

- (NSNumber *)toNumber {
    static NSNumberFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [NSNumberFormatter new];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return [formatter numberFromString:self];
}

@end

@implementation Formatters

+ (NSString *)prettyInt:(int)i {
    if (i <= 9999)
        return [[NSNumber numberWithInteger:i]pretty];

    // http://stackoverflow.com/questions/11993806/convert-int-to-shortened-formatted-string/16801502#16801502
    NSUInteger value = i;
    NSUInteger index = 0;
    double dvalue = (double)value;
    //Updated to use correct SI Symbol ( http://en.wikipedia.org/wiki/SI_prefix )
    NSArray *suffix = @[ @"", @"k", @"M", @"G", @"T", @"P", @"E" ];
    
    while ((value/=1000) && ++index) dvalue /= 1000;
    
    return [NSString stringWithFormat:@"%.*f%@",
                  //Use boolean as 0 or 1 for precision
                  (int)(dvalue < 100.0 && ((unsigned)((dvalue - (unsigned)dvalue) * 10) > 0)),
                  dvalue, [suffix objectAtIndex:index]];
    
}

+ (NSString *)prettyTimestamp:(NSDate *)timestamp {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
    }
    return [formatter stringFromDate:timestamp];
}

@end