//
//  FoursquareGroup.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoursquareGroupItem.h"

@interface FoursquareGroup : NSObject

@property (nonatomic, readonly, strong) NSString *foursquareType;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSArray *items;

- (instancetype)initWithSerialization:(NSDictionary *)serialization;

@end
