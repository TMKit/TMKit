//
//  TMVersionUtil.h
//  TMKit
//
//  Created by Teemo on 19/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

extern  NSString* _Nullable  tm_BundleVersion(void);

extern  NSString* _Nullable  tm_BundleShortVersion(void);


@interface TMVersionUtil : NSObject

/**
 Get Bundle Version

 @return nsstring
 */
+ (nullable NSString*)getBundleVersion;

/**
  Get Short Bundle Version

 @return nsstring
 */
+ (nullable NSString*)getShortBundleVersion;

@end

NS_ASSUME_NONNULL_END
