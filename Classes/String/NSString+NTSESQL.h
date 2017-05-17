//
//  NSString+SQL.h
//  auction
//
//  Created by Teemo on 7/13/16.
//  Copyright © 2016 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kNTSESQLTypeText  @"TEXT"
#define kNTSESQLTypeNULL  @"NULL"
#define kNTSESQLTypeReal  @"REAL"
#define kNTSESQLTypeInteger  @"INTEGER"
#define kNTSESQLTypeFloat  @"FLOAT"

@interface NSString (NTSESQL)

+ (NSString*)NTSE_SQLCreateTable:(NSString*)tableName params:(NSDictionary*)params;
+ (NSString*)NTSE_SQLAddColumn:(NSString*)tableName params:(NSDictionary*)params;
@end
