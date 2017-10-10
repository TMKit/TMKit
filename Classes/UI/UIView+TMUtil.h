//
//  UIView+TMUtil.h
//  TMKit
//
//  Created by Teemo on 18/09/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <UIKit/UIKit.h>


/**
 Get screen max width
 
 @return width
 */
FOUNDATION_EXPORT  CGFloat tm_ScreenWidth(void);

/**
 Get screen max width

 @return height
 */
FOUNDATION_EXPORT  CGFloat tm_ScreenHeight(void);


/**
 Get screen max scale

 @return scale
 */
FOUNDATION_EXPORT  CGFloat tm_ScreenScale(void);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TMUtil)

@end

NS_ASSUME_NONNULL_END
