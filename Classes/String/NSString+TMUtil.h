//
//  NSString+TMUtil.h
//  TMKit
//
//  Created by Teemo on 25/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TMUtil)

//==================Base64======================


/**
 encode the String to base64

 @param string src String
 @return String
 */
+ (nullable NSString*)tm_base64Encoded:(NSString*)string;


//==================UUID========================


/**
 UUID Number

 @return String
 */
+ (NSString*)tm_UUID;

//==================Handle======================


/**
 trim the space  
 e.g   " hello " = >  "hello"

 @return String
 */
- (NSString*)tm_trim;


/**
 Json to Dictionary

 @return NSDictionary
 */
- (nullable NSDictionary*)tm_jsonToDict;


/**
 utf8 encode

 @return String
 */
- (nullable NSString*)tm_UTF8;

@end

NS_ASSUME_NONNULL_END
