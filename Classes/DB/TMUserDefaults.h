//
//  TMUserDefaults.h
//  TMKit
//
//  Created by Teemo on 20/06/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMUserDefaults : NSObject


/**
 store the value

 @param key key
 @param value value
 */
+ (void)setObject:(NSString*)value key:(id)key;


/**
 remove the value with key

 @param key key
 */
+ (void)removeObjectWithKey:(NSString *)key;


/**
 get the value with key

 @param key key
 @return value 
 */
+ (nullable id)objectWithKey:(NSString *)key;


/**
 synchronize all the value
 */
+ (void)synchronize;

@end

NS_ASSUME_NONNULL_END
