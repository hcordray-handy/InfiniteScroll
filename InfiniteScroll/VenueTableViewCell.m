//
//  VenueTableViewCell.m
//  InfiniteScroll
//
//  Created by Howard Cordray on 10/15/15.
//  Copyright © 2015 Howard Cordray. All rights reserved.
//

#import "VenueTableViewCell.h"
#import <PureLayout/PureLayout.h>
#import "FoursquareVenue.h"

@interface VenueTableViewCell () {
    FoursquareVenue *_venue;
    
    UILabel *_nameLabel;
    UILabel *_descriptionLabel;
    UILabel *_ratingLabel;
}
@end

@implementation VenueTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupSubviews];
    }
    
    return self;
}

- (void)setupSubviews {
    _nameLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [_nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_nameLabel setNumberOfLines:0];
    
    _ratingLabel = [[UILabel alloc] initForAutoLayout];
    [self.contentView addSubview:_ratingLabel];
    [_ratingLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
    [_ratingLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_ratingLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nameLabel withOffset:15];
    [_ratingLabel autoSetDimension:ALDimensionWidth toSize:25];
    [_ratingLabel setTextColor:[UIColor colorWithCGColor:[UIColor blueColor].CGColor]];
}

- (void)setVenue:(id)venue {
    _venue = (FoursquareVenue *)venue;
    
    _nameLabel.text = _venue.name;
    _ratingLabel.text = [NSString stringWithFormat:@"%i", _venue.price.tier];
}

@end
