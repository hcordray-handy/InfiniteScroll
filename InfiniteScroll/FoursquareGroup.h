//
//  FoursquareGroup.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoursquareGroup : NSObject

@property (nonatomic, strong) NSString *foursquareType;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSArray *items;

@end
