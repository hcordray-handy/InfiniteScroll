//
//  FoursquareVenue.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareVenue.h"

@implementation FoursquareVenue

- (instancetype)initWithSerialization:(NSDictionary *)serialization {
    self = [super init];
    
    if (!self) return nil;
    
    _foursquareId = [(NSNumber *)[serialization objectForKey:@"id"] intValue];
    _name = [serialization objectForKey:@"name"];
    _verified = [serialization objectForKey:@"verified"];
    _url = [serialization objectForKey:@"url"];
    _rating = [(NSNumber *)[serialization objectForKey:@"rating"] intValue];
    _foursquareDescription = [serialization objectForKey:@"description"];
    
    _price = [[FoursquareVenuePrice alloc] initWithSerialization:[serialization objectForKey:@"price"]];
    
    return self;
}

@end
