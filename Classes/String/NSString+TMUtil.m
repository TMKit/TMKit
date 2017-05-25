//
//  NSString+TMUtil.m
//  Pods
//
//  Created by Teemo on 25/05/2017.
//
//

#import "NSString+TMUtil.h"
#import "NSData+TMUtil.h"

@implementation NSString (TMUtil)


+ (NSString *)tm_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData tm_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)tm_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data tm_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)tm_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data tm_base64EncodedString];
}

- (NSString *)tm_base64DecodedString
{
    return [NSString tm_stringWithBase64EncodedString:self];
}

- (NSData *)tm_base64DecodedData
{
    return [NSData tm_dataWithBase64EncodedString:self];
}


@end
