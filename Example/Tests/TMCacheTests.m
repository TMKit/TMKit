//
//  TMCacheTests.m
//  TMKit_Tests
//
//  Created by Teemo on 16/10/2017.
//  Copyright © 2017 Teemo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TMKit/TMKit.h>

@interface TMCacheTests : XCTestCase

@end

@implementation TMCacheTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAsyncDiskInitialization
{
    NSString * const cacheName = @"testAsyncDiskInitialization";
    TMDiskCache *testCache = [[TMDiskCache alloc] initWithName:cacheName];
    NSURL *testCacheURL = testCache.cacheURL;
    NSError *error = nil;
    
    //Make sure the cache URL does not exist.
    if ([[NSFileManager defaultManager] fileExistsAtPath:[testCacheURL path]]) {
        [[NSFileManager defaultManager] removeItemAtURL:testCacheURL error:&error];
        XCTAssertNil(error);
    }
    
    testCache = [[TMDiskCache alloc] initWithName:cacheName];
    //This should not return until *after* disk cache directory has been created
    [testCache setObject:@"some bogus object" forKey:@"some bogus key"];
    XCTAssertTrue([[NSFileManager defaultManager] fileExistsAtPath:[testCacheURL path]]);
}

- (void)testDiskCacheSet
{
    TMDiskCache *testCache = [[TMDiskCache alloc] initWithName:@"testDiskCacheSet"];
    const NSUInteger objectCount = 100;
    [self measureBlock:^{
        for (NSUInteger idx = 0; idx < objectCount; idx++) {
            [testCache setObject:[@(idx) stringValue] forKey:[@(idx) stringValue]];
        }
    }];
}

- (void)testDiskCacheHit
{
    TMDiskCache *testCache = [[TMDiskCache alloc] initWithName:@"textDiskCacheHit"];
    const NSUInteger objectCount = 100;
    for (NSUInteger idx = 0; idx < objectCount; idx++) {
        [testCache setObject:[@(idx) stringValue] forKey:[@(idx) stringValue]];
    }
    [self measureBlock:^{
        for (NSUInteger idx = 0; idx < objectCount; idx++) {
            [testCache objectForKey:[@(idx) stringValue]];
        }
    }];
}

- (void)testDiskCacheMiss
{
    TMDiskCache *testCache = [[TMDiskCache alloc] initWithName:@"testDiskCacheMiss"];
    const NSUInteger objectCount = 100;
    [self measureBlock:^{
        for (NSUInteger idx = 0; idx < objectCount; idx++) {
            [testCache objectForKey:[@(idx) stringValue]];
        }
    }];
}


@end
