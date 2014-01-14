//
//  Formatters.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//



@interface NSNumber (Formatters)

- (NSString *)pretty;

@end

@interface NSString (Formatters)

- (NSString *)addS:(int)i;
- (NSNumber *)toNumber;

@end

@interface Formatters : NSObject 

+ (NSString *)prettyInt:(int)i;
+ (NSString *)prettyTimestamp:(NSDate *)timestamp;

@end