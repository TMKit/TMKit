//
//  NSString+TMUtil.h
//  TMKit
//
//  Created by Teemo on 25/05/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSString (TMUtil)

//==================Base64======================

+ (NSString*)tm_stringWithBase64EncodedString:(NSString*)string;

- (NSString*)tm_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

- (NSString*)tm_base64EncodedString;

- (NSString*)tm_base64DecodedString;

- (NSData*)tm_base64DecodedData;



//==================UUID========================

+ (NSString*)tm_UUID;

//==================Handle======================

- (NSString*)tm_trimWhitespace;

- (NSDictionary*)tm_toJson;

- (NSString*)tm_UTF8;

@end
