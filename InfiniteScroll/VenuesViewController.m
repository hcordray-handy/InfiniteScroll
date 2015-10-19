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

@interface VenuesViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FoursquareClient *client;
    
@property (nonatomic) int offset;
@property (nonatomic) int limit;
    
@property (nonatomic, strong) NSMutableArray *venues;
@property (nonatomic, strong) NSURLSessionTask *task;
@property (nonatomic) BOOL done;

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
    if (self.task || self.done) return;
    
    __weak typeof (self) weakSelf = self;
    self.task = [_client getVenuesNearLatitude:40.7 longitude:-74 limit:_limit offset:_offset callback:^(NSArray *results, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            weakSelf.done = YES;
        } else if (results.count) {
            [weakSelf.venues addObjectsFromArray:results];
            weakSelf.offset += (int)results.count;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf refresh];
            });
        } else {
            weakSelf.done = YES;
        }
        
       weakSelf.task = nil;
    }];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [weakSelf.task resume];
}

- (void)setupSubviews {
    self.tableView = [[UITableView alloc] initForAutoLayout];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[VenueTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    [self.tableView autoPinEdgesToSuperviewEdges];
}

- (void)refresh {
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.venues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VenueTableViewCell *cell = (VenueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[VenueTableViewCell alloc] init];
    }
    
    [cell setVenue:[self.venues objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= [self.venues count] - 5) {
        [self loadVenues];
    }
}

@end
