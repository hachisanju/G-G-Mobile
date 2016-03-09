//
//  SecondViewController.h
//  Software Engineering Project
//
//  Created by Thomas Wilson on 11/2/15.
//

//Standard Imports 
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "discountItem.h"
#import "DiscountDetailViewController.h"
#import "discountCell.h"

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    sqlite3 *_dbconnect;
}

@property (nonatomic, strong) NSMutableArray *discountItemsArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

