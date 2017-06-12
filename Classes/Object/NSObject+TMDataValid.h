//
//  NSObject+TMDataValid.h
//  TMKit
//
//  Created by Teemo on 10/04/2017.
//  Copyright © 2017 TMKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TMDataValid)


/**
 safely to get String

 @return NSString or nil
 */
- (NSString*)tm_String;


/**
 safely to get NSNumber

 @return NSNumber or nil
 */
- (NSNumber*)tm_Number;


/**
 safely to get NSDictionary

 @return NSDictionary or nil
 */
- (NSDictionary*)tm_Dictionary;



/**
 safely to get NSArray
 
 @return NSArray or nil
 */
- (NSArray*)tm_Array;


/**
 judge data if data is null

 @return YES or NO
 */
- (BOOL)tm_isNull;




@end
