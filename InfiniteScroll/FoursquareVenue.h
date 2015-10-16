//
//  FoursquareVenue.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoursquareVenuePrice.h"

@interface FoursquareVenue : NSObject

@property (nonatomic, readonly) NSInteger foursquareId;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly) BOOL verified;
@property (nonatomic, readonly, strong) NSString *url;
@property (nonatomic, readonly) NSInteger rating;
@property (nonatomic, readonly, strong) NSString *foursquareDescription;
@property (nonatomic, readonly, strong) FoursquareVenuePrice *price;

- (instancetype)initWithSerialization:(NSDictionary *)serialization;

@end
