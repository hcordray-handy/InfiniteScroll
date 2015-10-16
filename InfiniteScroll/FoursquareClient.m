//
//  FoursquareClient.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareClient.h"
#import <RestKit/RestKit.h>
#import "MappingManager.h"

@interface FoursquareClient () {
    MappingManager *_mappingManager;
    RKObjectManager *_manager;
    
    NSString *_client_id;
    NSString *_client_secret;
    NSString *_version;
}
@end

@implementation FoursquareClient

+ (FoursquareClient *)sharedInstance {
    static dispatch_once_t p = 0;
    
    __strong static id _sharedInstance = nil;
    
    dispatch_once(&p, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _mappingManager = [MappingManager sharedInstance];
        [self configureManager];
        
        _client_id = @"PYYVAY4PWY5NCNB0VPDCD0RMF4AHRVE5NLXLZN5RCFPAZBYQ";
        _client_secret = @"IBI03EPTVC2JCQ3TFKZ1OEM5FN2V5THPQCWETQSXLEJO5FDQ";
        _version = @"20130815";
    }
    
    return self;
}

- (void)configureManager {
    _manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"https://api.foursquare.com"]];
    
    NSIndexSet *successCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[_mappingManager foursquareResponseMapping]
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"response"
                                                                                       statusCodes:successCodes];
    [_manager addResponseDescriptor:responseDescriptor];
}

- (NSMutableDictionary *)defaultParams {
    return [[NSMutableDictionary alloc] initWithDictionary:@{@"client_id":      _client_id,
                                                             @"client_secret":  _client_secret,
                                                             @"v":        _version}];
}

- (void)getVenuesNearLatitude:(float)latitude longitude:(float)longitude limit:(int)limit offset:(int)offset callback:(void (^)(NSArray *, NSError *))callback {
    NSMutableDictionary *params = [self defaultParams];
    [params setObject:[NSString stringWithFormat:@"%f,%f", latitude, longitude] forKey:@"ll"];
    [params setObject:[NSNumber numberWithInt:offset] forKey:@"offset"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    [_manager getObjectsAtPath:@"v2/venues/explore" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSMutableArray *venues = [[NSMutableArray alloc] init];
        FoursquareResponse *response = (FoursquareResponse *)mappingResult.firstObject;
        
        for (FoursquareGroup *group in response.groups) {
            for (FoursquareGroupItem *groupItem in group.items) {
                [venues addObject:groupItem.venue];
            }
        }
        
        callback(venues, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        callback(nil, error);
    }];
}

@end
