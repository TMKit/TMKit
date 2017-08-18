//
//  NSData+TMUtil.h
//  TMKit
//
//  Created by Teemo on 25/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (TMUtil)

//===================Base64===============

/**
 convert data to base64 encode

 @param string origin String
 @return base64 NSData
 */
+ (nullable NSData *)tm_dataWithBase64EncodedString:(NSString *)string;



/**
 convert data to base64 encode

 @param wrapWidth  the following to control the maximum line length after which a line ending is inserted.
 @return NSString
 */
- (nullable NSString * )tm_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;


/**
 convert data to base64 encode

 @return NSString
 */
- (nullable NSString *)tm_base64EncodedString;

@end

NS_ASSUME_NONNULL_END
