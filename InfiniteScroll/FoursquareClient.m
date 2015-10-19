//
//  FoursquareClient.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "FoursquareClient.h"
#import "FoursquareResponse.h"

static NSString *const clientId = @"PYYVAY4PWY5NCNB0VPDCD0RMF4AHRVE5NLXLZN5RCFPAZBYQ";
static NSString *const clientSecret = @"IBI03EPTVC2JCQ3TFKZ1OEM5FN2V5THPQCWETQSXLEJO5FDQ";
static NSString *const version = @"20130815";

@implementation FoursquareClient

// singletons cause code coupling (object needs to know about the singleton, etc)
// to be testible, use service locator:
// declare protocol, for example DataRequestService
// create implementation of that somewhere, but only register the protocol in the service locator
// service locator finds the relevant service contract (aka protocol)

+ (FoursquareClient *)sharedInstance {
    static dispatch_once_t p = 0;
    
    __strong static id _sharedInstance = nil;
    
    dispatch_once(&p, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (NSMutableDictionary *)defaultParams {
    return [[NSMutableDictionary alloc] initWithDictionary:@{@"client_id":      clientId,
                                                             @"client_secret":  clientSecret,
                                                             @"v":              version}];
}

- (NSString *)queryStringFromParams:(NSDictionary *)params {
    NSMutableString *queryString = [[NSMutableString alloc] init];
    
    for (NSString *key in params) {
        NSString *value = [params objectForKey:key];
        
        [queryString appendString:[NSString stringWithFormat:@"&%@=%@", key, value]];
    }

    return [queryString substringFromIndex:1];
}

- (NSURLSessionTask *)getVenuesNearLatitude:(float)latitude longitude:(float)longitude limit:(int)limit offset:(int)offset callback:(void (^)(NSArray *, NSError *))callback {
    NSMutableDictionary *params = [self defaultParams];
    [params setObject:[NSString stringWithFormat:@"%f,%f", latitude, longitude] forKey:@"ll"];
    [params setObject:[NSNumber numberWithInt:offset] forKey:@"offset"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/explore?%@", [self queryStringFromParams:params]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    return [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) callback(nil, error);
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSMutableArray *venues = [[NSMutableArray alloc] init];
        
        FoursquareResponse *foursquareResponse = [[FoursquareResponse alloc] initWithSerialization:[json objectForKey:@"response"]];
        for (FoursquareGroup *group in foursquareResponse.groups) {
            for (FoursquareGroupItem *item in group.items) {
                [venues addObject:item.venue];
            }
        }
        
        callback(venues, nil);
    }];
}

@end
