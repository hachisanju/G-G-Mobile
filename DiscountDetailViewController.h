//
//  DiscountDetailViewController.h
//  Software Engineering Project
//
//  Created by Saiprassad Gunasegaran on 11/30/15.
//

#import <UIKit/UIKit.h>

@interface DiscountDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *detailViewItemName;
@property (weak, nonatomic) IBOutlet UIImageView *detailViewItemImage;
@property (weak, nonatomic) IBOutlet UITextView *detailViewItemDesc;

@property (strong, nonatomic) NSArray *detailArray;

@end
