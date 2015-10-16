//
//  FoursquareVenuePrice.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoursquareVenuePrice : NSObject

@property (nonatomic, readonly) int tier;
@property (nonatomic, readonly, strong) NSString *tierMessage;

- (instancetype)initWithSerialization:(NSDictionary *)serialization;

@end
