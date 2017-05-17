//
//  NSString+Uitl.h
//  auction
//
//  Created by Teemo on 15/5/6.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, iPhoneDeviceVersion)
{
    iPhoneDeviceVersionSix = 1,
    iPhoneDeviceVersionSixPlus = 2,
    iPhoneDeviceVersionFive = 3
};


@interface NSString (Uitl)

//+ (NSString *)getCurrentDeviceModel;
+ (iPhoneDeviceVersion)deviceVersion;

+ (NSString*)deviceString;

+ (NSString *)getUUID;

+ (BOOL)hasChines:(NSString*)srcString;


/**
   返回 "yyyy-MM-dd" 格式的String

 @param timeInterval 时间戳
 @return String
 */
+ (NSString*)stringWithTimeInterval:(uint64_t)timeInterval;

+ (NSString*)stringWithTimeInterval:(uint64_t)timeInterval withFormatter:(NSString*)formatter;

- (BOOL)containsString_iOS7:(NSString *)str;


-(NSDictionary*)stringToJson;



-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)sizeWithMyFont:(UIFont*)font
       constrainedToSize:(CGSize)constrainedSize
           lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithAttributes:(NSDictionary*)attr maxSize:(CGSize)maxSize;

- (NSString*)lastChar;

- (NSString*)getUTF8;

@end


extern BOOL NSStringIsValidEmail(NSString *checkString);
extern BOOL NSStringIsValidPhone(NSString *checkString);    //  判断手机号码是否正确，只是判断是否是数字
extern BOOL NSStringIsValidMobile(NSString *checkString);  //  使用正则表达式判断手机号码是否正确
extern BOOL NSStringIsValidChinese(NSString *checkString);
extern BOOL NSStringISValidEnglish(NSString *checkString);
extern BOOL NSStringISValidAccount(NSString *checkString);//6~10 的英文字母和数字
extern BOOL NSStringISValidPassword(NSString *checkString);//6~12 的英文字母和数字
extern BOOL NSStringISValidLwtAccount(NSString *checkString);//5~12 的英文字母和数字
extern BOOL NSStringISValidEmail(NSString *email); // 判断邮箱是否合法
