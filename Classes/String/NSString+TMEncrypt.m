//
//  NSString+TMEncrypt.m
//  TMKit
//
//  Created by Teemo on 24/05/2017.
//
//

#import "NSString+TMEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+TMEncrypt.h"

@implementation NSString (TMEncrypt)



- (NSString *)tm_MD2String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_MD2String];
}

- (NSData *)tm_MD2Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_MD2Data];
}

- (NSString *)tm_MD4String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_MD4String];
}

- (NSData *)tm_MD4Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_MD4Data];
}

-(NSString *) tm_MD5String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_MD5String];
}

-(NSString *) tm_SHA1String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA1String];
}

-(NSString *) tm_SHA224String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA224String];
}

-(NSString *) tm_SHA256String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA256String];
}

-(NSString *) tm_SHA384String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
   return [data tm_SHA384String];
}

-(NSString *) tm_SHA512String{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA512String];
}


-(NSData *) tm_MD5Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_MD5Data];
}

-(NSData *) tm_SHA1Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA1Data];
}

-(NSData *) tm_SHA224Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA224Data];
}

-(NSData *) tm_SHA256Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA256Data];
}

-(NSData *) tm_SHA384Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA384Data];
}

-(NSData *) tm_SHA512Data{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data tm_SHA512Data];
}



@end
