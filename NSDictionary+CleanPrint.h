//
//  NSDictionary+CleanPrint.h
//
//  Created by Charles Bedrosian on 4/29/14.
//  Copyright (c) 2014 Charles Bedrosian. All rights reserved.
//

@interface NSDictionary (CleanPrint)

+ (NSString *)cleanPrintTest;

- (NSString *)cleanPrint;
+ (NSString *)translateDictionaryStringToJSON:(NSString *)dictionaryString;

@end
