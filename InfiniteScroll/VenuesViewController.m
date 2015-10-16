//
//  VenuesViewController.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "VenuesViewController.h"
#import "FoursquareClient.h"
#import "VenueTableViewCell.h"
#import <PureLayout/PureLayout.h>

@interface VenuesViewController () {
    UITableView *_tableView;
    FoursquareClient *_client;
    
    int _offset;
    int _limit;
    
    NSMutableArray *_venues;
    NSURLSessionTask *_task;
    BOOL _done;
}
@end

@implementation VenuesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];

    _client = [FoursquareClient sharedInstance];
    _venues = [[NSMutableArray alloc] init];
    _offset = 0;
    _limit = 20;
    
    [self loadVenues];
}

- (void)loadVenues {
    if (_task || _done) return;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __weak typeof (self) weakSelf = self;
    _task = [_client getVenuesNearLatitude:40.7 longitude:-74 limit:_limit offset:_offset callback:^(NSArray *results, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
  
        VenuesViewController *strongSelf = weakSelf;
        if (!strongSelf) return;
        
        if (error) {
            strongSelf->_done = YES;
        } else if (results.count) {
            [strongSelf->_venues addObjectsFromArray:results];
            strongSelf->_offset += results.count;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf refresh];
            });
        } else {
            strongSelf->_done = YES;
        }
        
        strongSelf->_task = nil;
    }];
    
    [_task resume];
}

- (void)setupSubviews {
    _tableView = [[UITableView alloc] initForAutoLayout];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[VenueTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdges];
}

- (void)refresh {
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VenueTableViewCell *cell = (VenueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[VenueTableViewCell alloc] init];
    }
    
    [cell setVenue:[_venues objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= [_venues count] - 5) {
        [self loadVenues];
    }
}

@end
