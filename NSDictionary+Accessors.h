//
//  NSDictionary+Accessors.h
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Accessors)
- (BOOL)containsKey:(NSString *)key;

- (NSString *)stringForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)value;

- (NSString *) stringForKeys:(NSArray *)keys;
- (NSString *) stringForKeys:(NSArray *)keys defaultValue:(NSString *)value;

- (BOOL)boolForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)value;
- (BOOL)boolForKeys:(NSArray *)keys;
- (BOOL)boolForKeys:(NSArray *)keys defaultValue:(BOOL)value;

- (NSNumber *)numberForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key defaultValue:(NSNumber *)value;

- (NSInteger)integerForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)value;

- (int)intForKey:(NSString *)key;
- (int)intForKey:(NSString *)key defaultValue:(int)value;

- (NSUInteger) uintegerForKey:(NSString *)key;
- (NSUInteger) uintegerForKey:(NSString *)key defaultValue:(NSUInteger)value;

- (NSDate *) dateForKey:(NSString *)key;
- (NSDate *) dateForKey:(NSString *)key defaultValue:(NSDate *)value;

- (NSArray *)arrayForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key;

- (NSURL *)urlForKey:(NSString *)key;
- (NSURL *)urlForKeys:(NSArray *)keys;

@end
