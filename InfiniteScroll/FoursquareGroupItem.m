//
//  FoursquareGroupItem.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareGroupItem.h"

@implementation FoursquareGroupItem

- (instancetype)initWithSerialization:(NSDictionary *)serialization {
    self = [super init];
    
    if (!self) return nil;
    
    _venue = [[FoursquareVenue alloc] initWithSerialization:[serialization objectForKey:@"venue"]];
    
    return self;
}

@end
