//
//  FoursquareResponse.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoursquareGroup.h"

@interface FoursquareResponse : NSObject

@property (nonatomic, readonly, strong) NSArray *groups;

- (instancetype)initWithSerialization:(NSDictionary *)serialization;

@end
