//
//  LocaleUtils.h
//  three20test
//
//  Created by qqn_pipi on 10-3-20.
//  Copyright 2010 QQN-PIPI.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLS(x)			NSLocalizedString(x, nil)

@interface LocaleUtils : NSObject {

}

+ (NSString *)getCountryCode;
+ (NSString *)getLanguageCode;
+ (BOOL)isChinese;
+ (BOOL)isEnglish;

+ (BOOL)isChina;
+ (BOOL)isOtherChina;
+ (BOOL)isTraditionalChinese;

+ (BOOL)supportChinese;

+ (NSArray*)getZodiacArray;
+ (NSString*)getZodiacWithIndex:(int)index;

@end
