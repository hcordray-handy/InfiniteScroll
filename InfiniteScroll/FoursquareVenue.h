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

@property (nonatomic) NSInteger foursquareId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) BOOL verified;
@property (nonatomic, strong) NSString *url;
@property (nonatomic) NSInteger rating;
@property (nonatomic, strong) NSString *foursquareDescription;
@property (nonatomic, strong) FoursquareVenuePrice *price;

@end
