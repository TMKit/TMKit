//
//  TMMacroDefine.h
//  TMKit
//
//  Created by Teemo on 20/06/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#ifndef TMMacroDefine_h
#define TMMacroDefine_h

#define TM_EXECUTEBLOCK(A,...)            if(A != NULL) {A(__VA_ARGS__);}

#ifndef TM_SUBCLASSING_RESTRICTED
#if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#define TM_SUBCLASSING_RESTRICTED __attribute__((objc_subclassing_restricted))
#else
#define TM_SUBCLASSING_RESTRICTED
#endif
#endif

#ifndef TM_NOESCAPE
#if defined(__has_attribute) && __has_attribute(noescape)
#define TM_NOESCAPE __attribute__((noescape))
#else
#define TM_NOESCAPE
#endif
#endif

#endif /* TMMacroDefine_h */
