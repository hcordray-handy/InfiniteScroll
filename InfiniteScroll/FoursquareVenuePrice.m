//
//  FoursquareVenuePrice.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareVenuePrice.h"

@implementation FoursquareVenuePrice

- (instancetype)initWithSerialization:(NSDictionary *)serialization {
    self = [super init];
    
    if (!self) return nil;
    
    _tier = [(NSNumber *)[serialization objectForKey:@"tier"] intValue];
    _tierMessage = [serialization objectForKey:@"message"];
    
    return self;
}

@end
