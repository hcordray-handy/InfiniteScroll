//
//  MappingManager.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

#import "FoursquareResponse.h"
#import "FoursquareGroup.h"
#import "FoursquareGroupItem.h"
#import "FoursquareVenue.h"
#import "FoursquareVenuePrice.h"

@interface MappingManager : NSObject

+ (MappingManager *)sharedInstance;

- (RKObjectMapping *)foursquareResponseMapping;
- (RKObjectMapping *)foursquareGroupMapping;
- (RKObjectMapping *)foursquareGroupItemMapping;
- (RKObjectMapping *)foursquareVenueMapping;
- (RKObjectMapping *)foursquareVenuePriceMapping;

@end
