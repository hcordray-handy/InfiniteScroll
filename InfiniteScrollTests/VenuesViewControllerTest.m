//
//  VenuesViewControllerTest.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "VenuesViewController.h"
#import "FoursquareClient.h"

@interface VenuesViewControllerTest : XCTestCase

@end

@implementation VenuesViewControllerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialValues {
    VenuesViewController *vvc = [[VenuesViewController alloc] init];
    
    [vvc viewDidAppear:YES];
    
    XCTAssertEqual([vvc loading], NO);
    XCTAssertEqual([vvc done], NO);
    XCTAssertEqual([[vvc venues] count], 0);
}

- (void)testViewDidAppear {
    VenuesViewController *vvc = [[VenuesViewController alloc] init];

    id mockClient = OCMClassMock([FoursquareClient class]);
    
    OCMStub([[[mockClient stub] ignoringNonObjectArgs] getVenuesNearLatitude:0 longitude:0 limit:0 offset:0 callback:[OCMArg isNotNil]]).andDo(nil);
    OCMStub([mockClient sharedInstance]).andReturn(mockClient);
    
    [vvc viewDidAppear:YES];
    
    OCMVerify([[[mockClient stub] ignoringNonObjectArgs] getVenuesNearLatitude:0 longitude:0 limit:0 offset:0 callback:[OCMArg isNotNil]]);
}

@end
