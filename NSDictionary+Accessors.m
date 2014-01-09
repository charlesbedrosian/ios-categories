//
//  NSDictionary+Accessors.m
//  ios-categories
//
//  Created by Charles Bedrosian
//  Copyright (c) 2013 Charles Bedrosian. All rights reserved.
//

#import "NSDictionary+Accessors.h"
#import "NSString+Helpers.h"

@implementation NSDictionary (Accessors)

- (BOOL)containsKey:(NSString *)key {
    if (!self[key]) {
//        NSLog(@"Key %@ not found in dictionary %@", key, self);
        return NO;
    }
    if ([self[key] isKindOfClass:[NSNull class]]) {
//        NSLog(@"Key %@ not found in dictionary %@", key, self);
        return NO;
    }
    return YES;
}


- (NSString *)stringForKeys:(NSArray *)keys {
    return [self stringForKeys:keys defaultValue:@""];
}
- (NSString *)stringForKeys:(NSArray *)keys defaultValue:(NSString *)value {
    for(NSString *key in keys) {
        if ([self containsKey:key]) {
            return [self stringForKey:key defaultValue:value];
        }
    }
    return value;
}
- (NSString *)stringForKey:(NSString *)key {
    return [self stringForKey:key defaultValue:@""];
}
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)value {
    if (![self containsKey:key]) return value;
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
        if ([self containsKey:key])
            return [self boolForKey:key defaultValue:value];
    }
    return value;
}

- (BOOL)boolForKey:(NSString *)key {
    return [self boolForKey:key defaultValue:FALSE];
}
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)value {
    if (![self containsKey:key]) return value;
    if ([self[key] isKindOfClass:[NSString class]]) {
        if ([self[key] caseInsensitiveCompare:@"true"])  return TRUE;
        if ([self[key] caseInsensitiveCompare:@"false"]) return FALSE;
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
    if (![self containsKey:key]) return value;
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)self[key]);
    }
    return value;
}

- (NSInteger)integerForKey:(NSString *)key {
    return [self integerForKey:key defaultValue:0];
}
- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)value {
    if (![self containsKey:key]) return value;
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] integerValue];
    }
    return value;
}

- (NSUInteger) uintegerForKey:(NSString *)key {
    return [self uintegerForKey:key defaultValue:0];
}
- (NSUInteger) uintegerForKey:(NSString *)key defaultValue:(NSUInteger)value {
    if (![self containsKey:key]) return value;
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] unsignedIntegerValue];
    }
    return value;
}

- (int)intForKey:(NSString *)key {
    return [self intForKey:key defaultValue:0];   
}
- (int)intForKey:(NSString *)key defaultValue:(int)value {
    if (![self containsKey:key]) return value;
    if ([self[key] isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)self[key] intValue];
    }
    return value;
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
    if (![self containsKey:key]) return @[];
    if ([self[key] isKindOfClass:[NSArray class]]) {
        return (NSArray *) self[key];
    }
    return @[];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    if (![self containsKey:key]) return @{};
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


@end
