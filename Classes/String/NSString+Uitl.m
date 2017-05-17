//
//  NSString+Uitl.m
//  auction
//
//  Created by Teemo on 15/5/6.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NSString+Uitl.h"
#import "sys/utsname.h"

@implementation NSString (Uitl)

+ (NSString *)getUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString* retStr = (__bridge_transfer NSString *)string;
    return [[retStr stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
}

-(NSDictionary*)stringToJson
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSObject *object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return (NSDictionary*)object;
}
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           attributes:attrs context:nil].size;
}

-(CGSize)sizeWithAttributes:(NSDictionary*)attr maxSize:(CGSize)maxSize
{
 
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                           attributes:attr context:nil].size;
}



- (CGSize)sizeWithMyFont:(UIFont*)font
       constrainedToSize:(CGSize)constrainedSize
           lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize size = CGSizeZero;
    
    if ([self respondsToSelector: @selector(boundingRectWithSize:options:attributes:context:)] == YES) {
        size = [self boundingRectWithSize: constrainedSize
                                  options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                               attributes: @{ NSFontAttributeName: font }
                                  context: nil].size;
        
        if (size.height > constrainedSize.height){
            size.height = constrainedSize.height;
        }
        
        return CGSizeMake(ceilf(size.width), ceilf(size.height));
    } else {
        
        return CGSizeZero;
        
        //        size = [self sizeWithFont:font
        //                constrainedToSize:constrainedSize
        //                    lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return size;
}

+ (iPhoneDeviceVersion)deviceVersion
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if([deviceString isEqualToString:@"iPhone7,1"]){
        return iPhoneDeviceVersionSixPlus;
    }
    
    if ([deviceString isEqualToString:@"iPhone7,2"]) {
        return iPhoneDeviceVersionSix;
    }
    
    return iPhoneDeviceVersionFive;
}


+ (BOOL)hasChines:(NSString*)srcString{
    for (NSInteger i = 0; i< [srcString length]; i++) {
//        char commitChar = [srcString characterAtIndex:i];
        NSString *tmp = [srcString substringWithRange:NSMakeRange(i, 1)];
        const char *utf8Tmp = [tmp UTF8String];
        if (utf8Tmp&&strlen(utf8Tmp) == 3) {
            return YES;
        }
    }
    return NO;
}


+ (NSString*)stringWithTimeInterval:(uint64_t)timeInterval{
    return [self stringWithTimeInterval:timeInterval withFormatter:@"yyyy-MM-dd"];
}

+ (NSString*)stringWithTimeInterval:(uint64_t)timeInterval withFormatter:(NSString*)formatter {
    //@"yyyy-MM-dd HH:mm:ss"
    NSDateFormatter * dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = formatter;
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString * dateStr = [dataFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([deviceString isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([deviceString isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([deviceString isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([deviceString isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([deviceString isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([deviceString isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([deviceString isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([deviceString isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([deviceString isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([deviceString isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([deviceString isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([deviceString isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([deviceString isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([deviceString isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([deviceString isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([deviceString isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([deviceString isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([deviceString isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([deviceString isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([deviceString isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([deviceString isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([deviceString isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([deviceString isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([deviceString isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

- (NSString*)lastChar{
    if(self.length <= 0)return nil;
    
    return [self substringWithRange:NSMakeRange(self.length - 1 , 1)];
}

- (NSString*)getUTF8{
    if (!self.length) {
        return nil;
    }
    
//    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
// 
//        
//#ifdef __IPHONE_9_0
//        return  [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//#else
//        return self;
//        
//#endif
//    }
//    else{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
}

- (BOOL)containsString_iOS7:(NSString *)str{
    NSRange range = [self rangeOfString:str];
    return range.location != NSNotFound;
}

@end


BOOL NSStringIsValidEmail(NSString *checkString)
{
    BOOL sticterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = sticterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
//  判断手机号码是否正确，只是判断11是数字并且1开头
BOOL NSStringIsValidPhone(NSString *checkString)
{
    NSString *regex = @"^1\\d{10}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}
//  使用正则表达式判断手机号码是否正确
BOOL NSStringIsValidMobile(NSString *checkString)
{
    /**
     * 手机号码
     * 移动：134,135,136,137,138,139,150,151,152,157,158,159,182,187,188
     * 联通：130,131,132,155,156,185,186
     * 电信：133,153,180,189
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    
//    if (([regextestmobile evaluateWithObject:checkString] == YES))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    return NSStringIsValidPhone(checkString);
}

BOOL NSStringIsValidChinese(NSString *checkString)
{
    NSString* regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}

BOOL NSStringISValidEnglish(NSString* checkString)
{
    NSString* regex = @"[[A-Za-z]]+";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}

BOOL NSStringISValidAccount(NSString *checkString){
    NSString* regex = @"[0-9a-zA-Z]{6,10}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}

BOOL NSStringISValidPassword(NSString *checkString){
    NSString* regex = @"^[0-9a-zA-Z_]{6,12}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}

BOOL NSStringISValidLwtAccount(NSString *checkString){
    NSString* regex = @"[0-9a-zA-Z]{5,12}";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:checkString];
}

BOOL NSStringISValidEmail(NSString *email){
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}


