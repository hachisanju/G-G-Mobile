//
//  ShopperDetailViewController.h
//  Software Engineering Project
//
//  Created by Daniel Hazy on 11/30/15.
//

#import <UIKit/UIKit.h>

@interface ShopperDetailViewController : UIViewController

//Array which holds the data brought over from the selected Item in the tableView
@property (strong, nonatomic) NSArray *detailArray;

//The visual aspect of the detail view 
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UITextField *detailPrice;
@property (weak, nonatomic) IBOutlet UITextView *detailDesc;
@property (weak, nonatomic) IBOutlet UITextView *detailName;



@end
