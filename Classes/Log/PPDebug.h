//
//  PPDebug.h
//  FootballScore
//
//  Created by qqn_pipi on 11-10-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//


#import "LogUtil.h"



#define PPCGPathRelease(x) CGPathRelease(x); x = NULL

#define PPCGContextRelease(x) if (NULL != x) {CGContextRelease(x); x = NULL;}

#define PPFree(x) if(NULL != x){free(x);}

#if __has_feature(objc_arc)

#define PPRelease(x) (x = nil)

//#define RETAIN self
//#define AUTORELEASE self
//#define RELEASE self
//#define DEALLOC self

#else

#define PPRelease(x) [x release]; x = nil

//#define RETAIN retain
//#define AUTORELEASE autorelease
//#define RELEASE release
//#define DEALLOC dealloc

#endif

#define RELEASE_BLOCK(__x)              if (__x != NULL) Block_release(__x); __x = NULL
#define COPY_BLOCK(__dest, __src)       if (__src != NULL && __dest != __src) __dest = Block_copy(__src)
#define EXECUTE_BLOCK(A,...)            if(A != NULL) {A(__VA_ARGS__);}
