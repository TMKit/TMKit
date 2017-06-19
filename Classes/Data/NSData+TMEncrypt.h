//
//  NSData+TMEncrypt.h
//  TMKit
//
//  Created by Teemo on 27/05/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSData (TMEncrypt)

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_MD2String;


/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_MD2Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_MD4String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_MD4Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_MD5String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_MD5Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_SHA1String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_SHA1Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_SHA224String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_SHA224Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_SHA256String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_SHA256Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_SHA384String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_SHA384Data;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSString *)tm_SHA512String;

/**
 Encrypt string by MD5
 
 @return NSString
 */
- (NSData *)tm_SHA512Data;

@end
