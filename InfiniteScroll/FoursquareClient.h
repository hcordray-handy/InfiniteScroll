//
//  FoursquareClient.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoursquareClient : NSObject

+ (FoursquareClient *)sharedInstance;

- (NSURLSessionTask *)getVenuesNearLatitude:(float)latitude longitude:(float)longitude limit:(int)limit offset:(int)offset callback:(void (^)(NSArray *, NSError *))callback;

@end
