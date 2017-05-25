//
//  NSString+TMUtil.h
//  Pods
//
//  Created by Teemo on 25/05/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSString (TMUtil)

//==================Base64======================

+ (NSString *)tm_stringWithBase64EncodedString:(NSString *)string;

- (NSString *)tm_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

- (NSString *)tm_base64EncodedString;

- (NSString *)tm_base64DecodedString;

- (NSData *)tm_base64DecodedData;


@end
