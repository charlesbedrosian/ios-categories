//
//  NSDictionary+Accessors.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "NSDictionary+Accessors.h"
#import "NSString+Convenience.h"
#import <UIKit/UIKit.h>

@implementation NSDictionary (Accessors)

static NSNumberFormatter *_doubleFormatter;
+ (NSNumberFormatter *)doubleFormatter {
    if (!_doubleFormatter) {
        _doubleFormatter = [[NSNumberFormatter alloc] init];
        _doubleFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return _doubleFormatter;
}

- (BOOL)containsKey:(NSString *)key {
    if (!self[key]) {
        //        DDLogDebug(@"Key %@ not found in dictionary %@", key, self);
        return NO;
    }
    if ([self[key] isKindOfClass:[NSNull class]]) {
        //        DDLogDebug(@"Key %@ not found in dictionary %@", key, self);
        return NO;
    }
    return YES;
}

- (NSString *)keyIfExists:(NSString *)key {
    NSArray *matchingKeys = [self.allKeys filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF like[cd] %@", key]];
    if (matchingKeys.count == 1)
    {
        return matchingKeys[0];
    }
    return nil;
}


- (NSString *)stringForKeys:(NSArray *)keys {
    return [self stringForKeys:keys defaultValue:@""];
}
- (NSString *)stringForKeys:(NSArray *)keys defaultValue:(NSString *)value {
    for(NSString *key in keys) {
        NSString *realKey = [self keyIfExists:key];
        if (realKey) {
            return [self stringForKey:realKey defaultValue:value];
        }
    }
    return value;
}
- (NSString *)stringForKey:(NSString *)key {
    return [self stringForKey:key defaultValue:@""];
}
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    if ([self[key] isKindOfClass:[NSString class]]) {
        if ([[self[key] lowercaseString] isEqualToString:@"null"])
            return value;
        return (NSString *)self[key];
    }
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", self[key]];
    }
    return value;
}

- (BOOL)boolForKeys:(NSArray *)keys {
    return [self boolForKeys:keys defaultValue:FALSE];
}
- (BOOL)boolForKeys:(NSArray *)keys defaultValue:(BOOL)value {
    for(NSString *key in keys){
        NSString *realKey = [self keyIfExists:key];
        if (realKey)
            return [self boolForKey:realKey defaultValue:value];
    }
    return value;
}

- (BOOL)boolForKey:(NSString *)key {
    return [self boolForKey:key defaultValue:FALSE];
}
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSString class]]) {
        if ([self[key] isEqualToString:@"1"])  return TRUE;
        if ([self[key] isEqualToString:@"0"])  return FALSE;

        if ([self[key] caseInsensitiveCompare:@"true"])  return TRUE;
        if ([self[key] caseInsensitiveCompare:@"false"]) return FALSE;

        if ([self[key] caseInsensitiveCompare:@"yes"])  return TRUE;
        if ([self[key] caseInsensitiveCompare:@"no"]) return FALSE;
        
        return value;
    }
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] boolValue];
    }
    return value;
}

- (NSNumber *)numberForKey:(NSString *)key {
    return [self numberForKey:key defaultValue:@0];
}
- (NSNumber *)numberForKey:(NSString *)key defaultValue:(NSNumber *)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)self[key]);
    }
    return value;
}

- (NSInteger)integerForKey:(NSString *)key {
    return [self integerForKey:key defaultValue:0];
}
- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] integerValue];
    }
    return value;
}

- (NSUInteger) uintegerForKey:(NSString *)key {
    return [self uintegerForKey:key defaultValue:0];
}
- (NSUInteger) uintegerForKey:(NSString *)key defaultValue:(NSUInteger)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] unsignedIntegerValue];
    }
    return value;
}

- (int)intForKey:(NSString *)key {
    return [self intForKey:key defaultValue:0];
}
- (int)intForKey:(NSString *)key defaultValue:(int)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] intValue];
    }
    return value;
}

- (NSDate *) dateForKeyWithoutTimezone:(NSString *)key {
    NSString *dateString = [self stringForKey:key defaultValue:nil];
    if (!dateString)
        return nil;
    return [dateString dateFromWebServiceStringIgnoringTimezone];
}

- (NSDate *) dateForKey:(NSString *)key {
    return [self dateForKey:key defaultValue:nil];
}
- (NSDate *) dateForKey:(NSString *)key defaultValue:(NSDate *)value {
    NSString *dateString = [self stringForKey:key defaultValue:nil];
    if (!dateString)
        return value;
    return [dateString dateFromWebServiceStringUsingDefault:value];
}

- (NSArray *)arrayForKey:(NSString *)key {
    key = [self keyIfExists:key];
    if (!key) return @[];
    
    if ([self[key] isKindOfClass:[NSArray class]]) {
        return (NSArray *) self[key];
    }
    return @[];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    key = [self keyIfExists:key];
    if (!key) return @{};
    
    if ([self[key] isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *) self[key];
    }
    return @{};
}

- (NSURL *)urlForKey:(NSString *)key {
    NSString *url = [self stringForKey:key];
    if ([url hasPrefix:@"//"]) {
        //add the protocol
        url = [@"http:" stringByAppendingString:url];
    }
    if ([url isValidUrl]) {
        return [NSURL URLWithString:url];
    }
    return nil;
}

- (NSURL *)urlForKeys:(NSArray *)keys {
    for(NSString *key in keys){
        NSURL *url = [self urlForKey:key];
        if (url)
            return url;
    }
    return nil;
}

- (CGFloat)floatForKey:(NSString *)key {
    return [self floatForKey:key defaultValue:0.0f];
}
- (CGFloat)floatForKey:(NSString *)key defaultValue:(CGFloat)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] floatValue];
    }
    NSNumberFormatter *f = [[self class] doubleFormatter];
    NSNumber *n = [f numberFromString:self[key]];
    if (n) {
        return [n floatValue];
    }
    return value;
}

- (double)doubleForKey:(NSString *)key {
    return [self doubleForKey:key defaultValue:0.0];
}
- (double)doubleForKey:(NSString *)key defaultValue:(double)value {
    key = [self keyIfExists:key];
    if (!key) return value;
    
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] doubleValue];
    }
    
    if ([self[key] isKindOfClass:[NSString class]]) {
        return [self[key] doubleValue];
    }
    
    NSNumberFormatter *f = [[self class] doubleFormatter];
    NSNumber *n = [f numberFromString:self[key]];
    if (n) {
        return [n doubleValue];
    }
    return value;
}

+ (NSDictionary*)loadFromFileInBundle:(NSString*)fileLocation {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileLocation stringByDeletingPathExtension]
                                                         ofType:[fileLocation pathExtension]];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSDictionary*)loadFromFileURL:(NSURL*)fileLocationURL {
    id result = nil;
    NSData* data = [NSData dataWithContentsOfURL:fileLocationURL];
    if (data) {
        __autoreleasing NSError* error = nil;
        result = [NSJSONSerialization JSONObjectWithData:data
                                                    options:kNilOptions error:&error];
        if (error != nil) return nil;
    }
    if (![result isKindOfClass:[NSDictionary class]]) {
        result = nil;
    }
    return result;
}

- (NSString *)stringForPath:(NSString *)path {
    return [self stringForPath:path defaultValue:@""];
}

- (NSString *)stringForPath:(NSString *)path defaultValue:(NSString *)value {
    NSDictionary *section = self;
    NSArray *parts = [path componentsSeparatedByString:@"/"];
    int index = 0;
    while (index < parts.count - 1) {
        NSString *key = parts[index];
        section = [section dictionaryForKey:key];
        if (!section) {
            return value;
        }
        index++;
    }
    return [section stringForKey:[parts lastObject] defaultValue:value];
}

@end

