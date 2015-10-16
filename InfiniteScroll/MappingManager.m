//
//  MappingManager.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "MappingManager.h"

@implementation MappingManager

+ (MappingManager *)sharedInstance {
    static dispatch_once_t p = 0;
    
    __strong static id _sharedInstance = nil;
    
    dispatch_once(&p, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (RKObjectMapping *)foursquareResponseMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FoursquareResponse class]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"groups" mapping:[self foursquareGroupMapping]];
    
    return mapping;
}

- (RKObjectMapping *)foursquareGroupMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FoursquareGroup class]];
    [mapping addAttributeMappingsFromDictionary:@{@"type":      @"foursquareType",
                                                  @"name":      @"name"}];
    [mapping addRelationshipMappingWithSourceKeyPath:@"items" mapping:[self foursquareGroupItemMapping]];
 
    return mapping;
}

- (RKObjectMapping *)foursquareGroupItemMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FoursquareGroupItem class]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"venue" mapping:[self foursquareVenueMapping]];
    
    return mapping;
}

- (RKObjectMapping *)foursquareVenueMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FoursquareVenue class]];
    [mapping addAttributeMappingsFromDictionary:@{@"id":            @"foursquareId",
                                                  @"name":          @"name",
                                                  @"verified":      @"verified",
                                                  @"url":           @"url",
                                                  @"rating":        @"rating",
                                                  @"description":   @"foursquareDescription"}];
    [mapping addRelationshipMappingWithSourceKeyPath:@"price" mapping:[self foursquareVenuePriceMapping]];
    
    return mapping;
}

- (RKObjectMapping *)foursquareVenuePriceMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[FoursquareVenuePrice class]];
    [mapping addAttributeMappingsFromDictionary:@{@"tier":      @"tier",
                                                  @"message":   @"tierMessage"}];
    
    return mapping;
}

@end
