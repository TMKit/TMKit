//
//  NSString+TMUtil.m
//  TMKit
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

- (NSString* )tm_trimWhitespace{
    return [self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)tm_UUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString* retStr = (__bridge_transfer NSString *)string;
    return [[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

-(NSDictionary*)tm_toJson{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return (NSDictionary*)object;
}

- (NSString*)tm_UTF8{
    if (!self.length) {
        return nil;
    }
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
#ifdef __IPHONE_9_0
        return  [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
#else
        return self;
#endif
    }
    else{
        return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

@end
