//
//  NSString+TMEncrypt.h
//  Pods
//
//  Created by Teemo on 24/05/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSString (TMEncrypt)


/**
 Encrypt string by MD5

 @return nsstring
 */
-(NSString *) tm_MD5;


/**
  Encrypt string by sha1

 @return nsstring
 */
-(NSString *) tm_SHA1;


/**
 Encrypt string by sha1

 @return nsstring
 */
-(NSString *) tm_SHA224;


/**
 Encrypt string by sha256
 
 @return nsstring
 */
-(NSString *) tm_SHA256;


/**
 Encrypt string by sha384
 
 @return nsstring
 */
-(NSString *) tm_SHA384;


/**
 Encrypt string by sha512

 @return nsstring
 */
-(NSString *) tm_SHA512;

//=================================add salt============================



/**
  Encrypt string by MD5

 @param salt random string
 @return nsstring
 */
-(NSString *) tm_MD5WithSalt:(NSString *)salt;


/**
 Encrypt string by sha1

 @param salt  random string
 @return nsstring
 */
-(NSString *) tm_SHA1WithSalt:(NSString *)salt;


/**
 Encrypt string by sha224

 @param salt random string
 @return nsstring
 */
-(NSString *) tm_SHA224WithSalt:(NSString *)salt;


/**
 Encrypt string by sha256

 @param salt random string
 @return nsstring
 */
-(NSString *) tm_SHA256WithSalt:(NSString *)salt;


/**
 Encrypt string by sha386

 @param salt random string
 @return nsstring
 */
-(NSString *) tm_SHA384WithSalt:(NSString *)salt;


/**
  Encrypt string by sha512

 @param salt random string
 @return nsstring
 */
-(NSString *) tm_SHA512WithSalt:(NSString *)salt;

@end
