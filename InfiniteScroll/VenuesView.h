//
//  VenuesView.h
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VenuesViewDelegate <NSObject>

- (NSArray *)venues;
- (void)loadVenues;
- (BOOL)loading;
- (BOOL)done;

@end

@interface VenuesView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <VenuesViewDelegate> venuesViewDelegate;

- (void)refresh;

@end
