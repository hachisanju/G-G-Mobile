//
//  shopperCell.m
//  Software Engineering Project
//
//  Created by Daniel Hazy on 10/28/15.
//  Copyright © 2015 Daniel Hazy. All rights reserved.
//

#import "shopperCell.h"

@implementation shopperCell

@synthesize nameLabel = _nameLabel;
@synthesize priceLabel = _priceLabel;
@synthesize thumbnailImageView = _thumbnailImageView;

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
