//
//  UnitTestingTests.m
//  UnitTestingTests
//
//  Created by Kuan-Wei Lin on 12/11/16.
//  Copyright © 2016 cracktheterm. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

static NSString * const gourmetSushiUrl = @"http://search.olp.yahooapis.jp/OpenLocalPlatform/V1/localSearch?appid=dj0zaiZpPUhhdVJPbm9hMnVUMSZzPWNvbnN1bWVyc2VjcmV0Jng9ZmE-&device=mobile&group=gid&sort=score&output=json&gc=01&query=%E5%AF%BF%E5%8F%B8";

@interface UnitTestingTests : XCTestCase

@property (nonatomic, strong) ViewController *vc;

@end

@implementation UnitTestingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.vc = [[ViewController alloc] init];
}

- (void)testMethod
{
    int result = [self.vc divideTwo:10 num2:20];
    XCTAssert(result == 15);
}

- (void)testAPIQuery
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    
    [self.vc blockCallbackDemo:@"hello" complete:^(NSArray *arr) {
        
        NSLog(@"Feature = %@", arr[0]);
        
        XCTAssert(arr != nil);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)testDataTask
{
    XCTestExpectation *expectation = [self expectationWithDescription:@"asynchronous request"];
    
    NSURL *url = [NSURL URLWithString:gourmetSushiUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
//        XCTAssertNil(error, @"dataTaskWithURL error %@", error);
//        
//        if ([response isKindOfClass:[NSHTTPURLResponse class]])
//        {
//            NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
//            XCTAssertEqual(statusCode, 200, @"status code was not 200; was %ld", (long)statusCode);
//        }
//        
//        XCTAssert(data, @"data nil");
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *arr = json[@"Feature"];
        NSLog(@"Feature = %@", arr[0]);

        
        XCTAssert(arr != nil);
        
        // do additional tests on the contents of the `data` object here, if you want
        
        // when all done, Fulfill the expectation
        
        [expectation fulfill];
    }];
    [task resume];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
