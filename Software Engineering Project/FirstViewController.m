//
//  FirstViewController.m
//  Software Engineering Project
//
//  Created by Daniel Hazy, Thomas Wilson, and Sudhanshu Rath on 10/22/15.
//

//Import Libraries
#import <sqlite3.h>             //For SQLite methods

//Customer Class header files
#import "FirstViewController.h"
#import "shopperCell.h"
#import "GGDatabaseInfo.h"

@implementation FirstViewController

//Standard synthesize of properties (gives them setter and getter methods)
@synthesize shopItemsArray;
@synthesize searchStuff;
@synthesize tableView = _tableView;

//As soon as First View Controller loads, this code runs
- (void)viewDidLoad {
    //Just overrides the default viewDidLoad with what we want to do here
    [super viewDidLoad];
    
    //Get rid of the grey translucent portion that covers the top of the screen
    self.navigationController.navigationBar.translucent = NO;
    
    //Make sure the search works properly 
    [searchStuff setDelegate:self];
    
    //Array to hold all products
    shopItemsArray = [[NSMutableArray alloc] init];
    
    //For now, we are able to locally include the database, and this tells the app where that file is (in the mainBundle)
    //In this application prototype, we are using an SQLite database
    //Depending on how the real database is setup and how we will connect to it, this WILL change in the future
    //Will most likely have to export the normal SQL file that Garnet and Gold have into the sqlite type, then connect to it remotely
    NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"testRathDB" ofType:@"sqlite"];
    
    //Open & test the connection to the database
    //This will stay the same, as long as we set up sqLiteDB to be correct for the real database
    if (sqlite3_open([sqLiteDb UTF8String], &_dbconnect) != SQLITE_OK)
    {
        //Print error message to log
        NSLog(@"Failed to open database. Check sqLiteDB path is correct to the Database file. Also check that _dbconnect exists in memory");
    }
    
    //Initial call to search the database and print the results into the tableView
    //This initializes the tableView to display ALL data from the database.
    [self searchDB:searchStuff.text];
}

//Method which grabs the text the user has typed into the textField, makes a query upon the DB
//Depending on the text entered will return specific items
- (void) textFieldShouldReturn:(UITextField * )textField{
    //Get rid of the keyboard after pressing search
    [textField resignFirstResponder];
    
    //Make query upon DB with the text
    [self searchDB:searchStuff.text];
}

//Method which takes the search field and makes a query upon the database
- (void) searchDB: (NSString *)searchText{
    
    [shopItemsArray removeAllObjects];
    
    //[self.tableView reloadData];
    //Check if the searchField text is the default (like the view just opened)
    if ([searchText isEqualToString:@""]){
        //If so, SELECT statement will get the entire table
        NSString *query = @"SELECT * FROM Mugs UNION ALL SELECT * FROM Tshirts UNION ALL SELECT * FROM Watches UNION ALL SELECT * FROM Hats";
        sqlite3_stmt *statement;
        
        //Make sure the query is passed properly, connection to DB is valid, etc. Returns int  (0 for OK)
        if(sqlite3_prepare_v2(_dbconnect, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            //While loops through for as long as there is a row in the table
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Grab data from the table at whatever column the integer is in the function call
                int uniqueId = sqlite3_column_int(statement, 0);
                char *nametxt = (char *) sqlite3_column_text(statement, 1);
                char *pricetxt = (char *) sqlite3_column_text(statement, 2);
                char *imgpath = (char *) sqlite3_column_text(statement, 3);
                char *desctxt = (char *) sqlite3_column_text(statement, 4);
                
                //Convert the characters retrieved into an actual string
                NSString *name = [[NSString alloc] initWithUTF8String:nametxt];
                NSString *price = [[NSString alloc] initWithUTF8String:pricetxt];
                NSString *imagepath = [[NSString alloc] initWithUTF8String:imgpath];
                NSString *desc = [[NSString alloc] initWithUTF8String:desctxt];
                
                //One item is retrieved from the database with each iteration, and stored as a GGDatabaseInfo object into the shopItemsArray
                GGDatabaseInfo *info = [[GGDatabaseInfo alloc] initWithUniqueId:uniqueId name:name imagepath:imagepath price:price desc:desc];
                
                //Add the actual object into the shopItemsArray
                [shopItemsArray addObject:info];
            }
            
            //Release resources statement takes up
            sqlite3_finalize(statement);
        }
    }
    
    else {
        NSLog(@"Variable passed was:%@.",searchText);
        
        /*NSString *query = [NSString stringWithFormat: @"SELECT * FROM Tshirts WHERE itemname LIKE '%%%@%%'", searchText];*/
        sqlite3_stmt *statement;
        NSString *aString =searchText;
        NSArray *array = [aString componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        
        array = [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF !=''"]];
        
        NSString *query = @"";
        for (NSString* s in array)
        {
            query = [query stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM Mugs WHERE itemname LIKE '%%%@%%' UNION ALL SELECT * FROM Tshirts WHERE itemname LIKE '%%%@%%' UNION ALL SELECT * FROM Watches WHERE itemname LIKE '%%%@%%' UNION ALL SELECT * FROM Hats WHERE itemname LIKE '%%%@%%' ", s, s, s, s]];
            if (s!= [array lastObject])
                query = [query stringByAppendingString: [NSString stringWithFormat:@"UNION ALL "]];
        }
        
        //query = [query stringByAppendingString: [NSString stringWithFormat: @"NULL"]];
        
        //Make sure the query is passed properly, connection to DB is valid, etc. Returns int  (0 for OK)
        if(sqlite3_prepare_v2(_dbconnect, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            //While loops through for as long as there is a row in the table
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Grab data from the table at whatever column the integer is in the function call
                int uniqueId = sqlite3_column_int(statement, 0);
                char *nametxt = (char *) sqlite3_column_text(statement, 1);
                char *pricetxt = (char *) sqlite3_column_text(statement, 2);
                char *imgpath = (char *) sqlite3_column_text(statement, 3);
                char *desctxt = (char *) sqlite3_column_text(statement, 4);
                
                //Convert the characters retrieved into an actual string
                NSString *name = [[NSString alloc] initWithUTF8String:nametxt];
                NSString *price = [[NSString alloc] initWithUTF8String:pricetxt];
                NSString *imagepath = [[NSString alloc] initWithUTF8String:imgpath];
                NSString *desc = [[NSString alloc] initWithUTF8String:desctxt];
                
                //One item is retrieved from the database with each iteration, and stored as a GGDatabaseInfo object into the shopItemsArray
                GGDatabaseInfo *info = [[GGDatabaseInfo alloc] initWithUniqueId:uniqueId name:name imagepath:imagepath price:price desc:desc];
                
                //Add the actual object into the shopItemsArray
                [shopItemsArray addObject:info];
            }
            
            //Release resources statement takes up
            sqlite3_finalize(statement);
        }
    }
    [self.tableView reloadData];
    if ([shopItemsArray count] == 0) {
        NSLog(@"HEY!!!!!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search Results:"
                                                        message:@"None Found."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        // do something here...
    }
}




//When an item is tapped on, this method runs to present details about the item tapped on
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Even though there is only one segue, good to check by identifier that it's the right one
    if ([[segue identifier] isEqualToString:@"showItemDetails"]){
        ShopperDetailViewController *detailView = [segue destinationViewController];
        
        //This is the actual item that was selected in the table
        NSIndexPath *selectedItem = [self.tableView indexPathForSelectedRow];

        //Make a temp item to pull all the data from the array at this row
        GGDatabaseInfo *item = [shopItemsArray objectAtIndex:selectedItem.row];
        
        //In the destination detail view, set the detailArray to hold the selected item's info
        detailView.detailArray = @[item.name,item.price,item.imagepath, item.desc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Make sure to close connection to the database
- (void)dealloc {
    sqlite3_close(_dbconnect);
    NSLog(@"Closed database!");
}

//Know how many items are in the array of items, so the TableView knows how large it should be
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [shopItemsArray count];
}

//Retrieves the items in the array, puts them into a respective cell in the TableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"table";
    
    //We are using the custom cells, detailed in the shopperCell class interface and implementation files
    shopperCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    //TableViews load cells incrementally (as they need to be displayed) not all at once
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"shopperCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //Allocate resources for an item of the GGDatabaseInfo type, set it equal to the object we'll be displaying
    GGDatabaseInfo *item = [shopItemsArray objectAtIndex:indexPath.row];
    
    //Set the cell up to display name, price, image of the item
    cell.nameLabel.text = item.name;
    cell.thumbnailImageView.image = [UIImage imageWithContentsOfFile: item.imagepath];
    cell.priceLabel.text = item.price;
    
    return cell;
}

//This method runs when a table cell is tapped on, to segue into a detail view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //Build a segue string based on the selected cell
    NSString *segueString = @"showItemDetails";
    
    //Perform a segue.
    [self performSegueWithIdentifier:segueString sender: self];
}

//Makes sure a segue is performed ONLY when an item is selected
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Makes sure that the table knows each cell is going to be 100 now (custom cell)
    return 100;
}
@end


