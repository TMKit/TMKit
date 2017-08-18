//
//  NSObject+TMDataValid.h
//  TMKit
//
//  Created by Teemo on 10/04/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TMDataValid)


/**
 safely to get String

 @return NSString or nil
 */
- (nullable NSString*)tm_String;


/**
 safely to get NSNumber

 @return NSNumber or nil
 */
- (nullable NSNumber*)tm_Number;


/**
 safely to get NSDictionary

 @return NSDictionary or nil
 */
- (nullable NSDictionary*)tm_Dictionary;



/**
 safely to get NSArray
 
 @return NSArray or nil
 */
- (nullable NSArray*)tm_Array;


/**
 judge data if data is null

 @return YES or NO
 */
- (BOOL)tm_isNull;

@end

NS_ASSUME_NONNULL_END
