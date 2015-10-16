//
//  FoursquareGroup.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareGroup.h"

@implementation FoursquareGroup

- (instancetype)initWithSerialization:(NSDictionary *)serialization {
    self = [super init];
    
    if (!self) return nil;
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *item in [serialization objectForKey:@"items"]) {
        [items addObject:[[FoursquareGroupItem alloc] initWithSerialization:item]];
    }
    
    _name = [serialization objectForKey:@"name"];
    _foursquareType = [serialization objectForKey:@"type"];
    
    _items = items;
    
    return self;
}

@end
