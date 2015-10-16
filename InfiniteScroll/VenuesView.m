//
//  VenuesView.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "VenuesView.h"
#import <PureLayout/PureLayout.h>
#import "VenueTableViewCell.h"

@interface VenuesView () {
    UITableView *_tableView;
}
@end

@implementation VenuesView

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    _tableView = [[UITableView alloc] initForAutoLayout];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[VenueTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self addSubview:_tableView];
    [_tableView autoPinEdgesToSuperviewEdges];
}

- (void)refresh {
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.venuesViewDelegate venues] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VenueTableViewCell *cell = (VenueTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[VenueTableViewCell alloc] init];
    }
    
    [cell setVenue:[[self.venuesViewDelegate venues] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat height = scrollView.contentSize.height;
    CGFloat fullHeight = [[UIScreen mainScreen] bounds].size.height;
    
    if (fullHeight * 1.5 >= height - offset) {
        [self.venuesViewDelegate loadVenues];
    }
}

@end
