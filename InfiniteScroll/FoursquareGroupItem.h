//
//  FoursquareGroupItem.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoursquareVenue.h"

@interface FoursquareGroupItem : NSObject

@property (nonatomic, readonly, strong) FoursquareVenue *venue;

- (instancetype)initWithSerialization:(NSDictionary *)serialization;

@end
