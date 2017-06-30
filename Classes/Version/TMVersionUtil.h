//
//  TMVersionUtil.h
//  TMKit
//
//  Created by Teemo on 19/05/2017.
//  Copyright © 2017 netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTMBundleVersion [TMVersionUtil getBundleVersion]

#define kTMBundleShortVersion [TMVersionUtil getShortBundleVersion]

@interface TMVersionUtil : NSObject

/**
 Get Bundle Version

 @return nsstring
 */
+ (NSString* _Nonnull )getBundleVersion;

/**
  Get Short Bundle Version

 @return nsstring
 */
+ (NSString* _Nonnull )getShortBundleVersion;

@end
