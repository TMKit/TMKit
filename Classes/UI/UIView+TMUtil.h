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
extern CGFloat tm_ScreenWidth();

/**
 Get screen max width

 @return height
 */
extern CGFloat tm_ScreenHeight();


/**
 Get screen max scale

 @return scale
 */
extern CGFloat tm_ScreenScale();

@interface UIView (TMUtil)

@end
