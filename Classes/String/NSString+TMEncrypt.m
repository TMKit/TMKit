//
//  NSString+TMEncrypt.m
//  Pods
//
//  Created by Teemo on 24/05/2017.
//
//

#import "NSString+TMEncrypt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (TMEncrypt)

-(NSString *) tm_MD5{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr,(CC_LONG) strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

-(NSString *) tm_SHA1{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG) data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(NSString *) tm_SHA224{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(NSString *) tm_SHA256{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes,(CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(NSString *) tm_SHA384{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

-(NSString *) tm_SHA512{
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}


-(NSString *) tm_MD5WithSalt:(NSString *)salt{
    if (!salt) {
        return nil;
    }
    NSString *newString = [self stringByAppendingString:salt];
    return [newString tm_MD5];
}


-(NSString *) tm_SHA1WithSalt:(NSString *)salt{
    if (!salt) {
        return nil;
    }
    NSString *newString = [self stringByAppendingString:salt];
    return [newString tm_SHA1];
}

-(NSString *) tm_SHA224WithSalt:(NSString *)salt{
    if (!salt) {
        return nil;
    }
    NSString *newString = [self stringByAppendingString:salt];
    return [newString tm_SHA224];
}

-(NSString *) tm_SHA256WithSalt:(NSString *)salt{
    if (!salt) {
        return nil;
    }
    NSString *newString = [self stringByAppendingString:salt];
    return [newString tm_SHA256];
}

-(NSString *) tm_SHA384WithSalt:(NSString *)salt{
    if (!salt) {
        return nil;
    }
    NSString *newString = [self stringByAppendingString:salt];
    return [newString tm_SHA384];
}

-(NSString *) tm_SHA512WithSalt:(NSString *)salt{
    if (!salt) {
        return nil;
    }
    NSString *newString = [self stringByAppendingString:salt];
    return [newString tm_SHA512];
}


@end
