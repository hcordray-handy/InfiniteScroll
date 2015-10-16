//
//  FoursquareResponse.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareResponse.h"

@implementation FoursquareResponse

- (instancetype)initWithSerialization:(NSDictionary *)serialization {
    self = [super init];
    
    if (!self) return nil;
    
    NSMutableArray *groups = [[NSMutableArray alloc] init];
    for (NSDictionary *group in [serialization objectForKey:@"groups"]) {
        [groups addObject:[[FoursquareGroup alloc] initWithSerialization:group]];
    }
    
    _groups = groups;
    
    return self;
}

@end

