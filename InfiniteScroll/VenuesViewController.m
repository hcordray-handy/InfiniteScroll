//
//  VenuesViewController.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "VenuesViewController.h"
#import "FoursquareClient.h"

@interface VenuesViewController () {
    VenuesView *_venuesView;
    FoursquareClient *_client;
    
    int _offset;
    int _limit;
    
    NSMutableArray *_venues;
    BOOL _loading;
    BOOL _done;
}
@end

@implementation VenuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _client = [FoursquareClient sharedInstance];
    _venues = [[NSMutableArray alloc] init];
    _offset = 0;
    _limit = 20;
    
    [self loadVenues];
}

- (void)loadView {
    _venuesView = [[VenuesView alloc] init];
    _venuesView.venuesViewDelegate = self;
    self.view = _venuesView;
}

- (void)loadVenues {
    if (!(_loading || _done)) {
        _loading = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_client getVenuesNearLatitude:40.7 longitude:-74 limit:_limit offset:_offset callback:^(NSArray *results, NSError *error) {
                if (error) {
                    _done = YES;
                } else if (results.count) {
                    [_venues addObjectsFromArray:results];
                    _offset += results.count;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_venuesView refresh];
                    });
                } else {
                    _done = YES;
                }
                
                _loading = NO;
            }];
        });
    }
}

- (NSArray *)venues {
    return _venues;
}

- (BOOL)loading {
    return _loading;
}

- (BOOL)done {
    return _done;
}

@end
