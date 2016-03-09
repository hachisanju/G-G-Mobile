//
//  shopperCell.h
//  Software Engineering Project
//
//  Created by Daniel Hazy on 10/28/15.
//  This class is used for the custom cell that I made

#import <UIKit/UIKit.h>

@interface shopperCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;


@end
