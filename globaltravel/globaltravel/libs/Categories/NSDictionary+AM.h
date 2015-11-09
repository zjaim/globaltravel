//
// Created by fallhunter on 5/9/14.
// Copyright (c) 2014 capplay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (AM)

- (NSInteger) integerValueOfKey:(NSString *)key;

- (int) intValueOfKey:(NSString*) key;

- (float) floatValueOfKey:(NSString *) key;

- (double) doubleValueOfKey:(NSString *) key;

- (long long)longlongValueOfKey:(NSString *)key;

- (BOOL)boolValueOfKey:(NSString *)key;

- (NSDate *) timeStampValueOfKey:(NSString *) key;

- (NSString *) timeStampForKey:(NSString *)key;

- (NSString *) timeForKey:(NSString *)key;

- (NSString *) stringValueOfKey:(NSString *) key;

- (NSArray *) arrayOfStringOfKey:(NSString *) key;

- (NSArray *) arrayValueOfKey:(NSString *) key;

- (NSDictionary *) dictValueOfKey:(NSString *) key;

@end