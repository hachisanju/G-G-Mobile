//
//  FirstViewController.h
//  Software Engineering Project
//
//  Created by Daniel Hazy , Thomas Wilson, and Sudhanshu Rath on 10/22/15.
/*
 This class controls the primary tab: the shopping viewer tab
 */

//Standard Imports of libraries
#import <UIKit/UIKit.h>
#import <sqlite3.h>

//Imports of custom class header files
#import "shopperCell.h"                     //Class for the cells in the shop tab (controls what the cells can have in them)
#import "ShopperDetailViewController.h"     //Describes the detail view (when an item is tapped on the tableView)
#import "GGDatabaseInfo.h"                  //Custom Class, each instantiation is an item grabbed from the DB
                                                //Such objects are then stored in arrays to be displayed

//Standard interface declaration for a ViewController with a TableView
@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {

    //This is the connection to the database, in this prototype build we use the SQLite Database type
    sqlite3 *_dbconnect;
    IBOutlet UITextField *searchStuff;
    
}
//Declare properties
@property (nonatomic, retain) IBOutlet UITextField *searchStuff;    //Search TextField label in the UI
@property (strong, nonatomic) IBOutlet UITableView *tableView;      //Standard TableView declaration, linked to FirstViewController story board
@property (nonatomic, strong) NSMutableArray *shopItemsArray;       //Array that holds all grabbed items, fed into TableView

@end

