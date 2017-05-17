//
//  NSString+Password.h
//  auction
//
//  Created by Teemo on 15/5/6.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Password)


-(NSString *) MD5;
-(NSString *) sha1;
-(NSString *) sha224;
-(NSString *) sha256;
-(NSString *) sha384;
-(NSString *) sha512;
-(NSString*)md532BitUpper;

@end
