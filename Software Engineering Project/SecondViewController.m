//
//  SecondViewController.m
//  Software Engineering Project
//
//  Created by Thomas Wilson on 11/2/15.
//

#import "SecondViewController.h"
#import "discountItem.h"
#import "DiscountDetailViewController.h"
#import "discountCell.h"

@implementation SecondViewController

@synthesize discountItemsArray;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Get rid of the grey translucent portion that covers the top of the screen
    self.navigationController.navigationBar.translucent = NO;
    
    //Array to hold all products
    discountItemsArray = [[NSMutableArray alloc] init];
    
    NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"testRathDB" ofType:@"sqlite"];

    if (sqlite3_open([sqLiteDb UTF8String], &_dbconnect) != SQLITE_OK)
    {
        //Print error message to log
        NSLog(@"Failed to open database. Check sqLiteDB path is correct to the Database file. Also check that _dbconnect exists in memory");
    }
    
    NSString *query = @"SELECT * FROM Barcodes";
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
            char *desctxt = (char *) sqlite3_column_text(statement, 2);
            char *imgpath = (char *) sqlite3_column_text(statement, 3);
            
            //Convert the characters retrieved into an actual string
            NSString *name = [[NSString alloc] initWithUTF8String:nametxt];
            NSString *desc = [[NSString alloc] initWithUTF8String:desctxt];
            NSString *imagepath = [[NSString alloc] initWithUTF8String:imgpath];
            
            //One item is retrieved from the database with each iteration, and stored as a GGDatabaseInfo object into the shopItemsArray
            discountItem *info = [[discountItem alloc] initWithUniqueId:uniqueId discountName:name discountImagePath:imagepath discountDesc:desc];
            
            //Add the actual object into the shopItemsArray
            [discountItemsArray addObject:info];
        }
        
        //Release resources statement takes up
        sqlite3_finalize(statement);
    }

}

//When an item is tapped on, this method runs to present details about the item tapped on
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //Even though there is only one segue, good to check by identifier that it's the right one
    if ([[segue identifier] isEqualToString:@"showDiscountDetails"]){
        DiscountDetailViewController *detailView = [segue destinationViewController];
        
        //This is the actual item that was selected in the table
        NSIndexPath *selectedItem = [self.tableView indexPathForSelectedRow];
        
        //Make a temp item to pull all the data from the array at this row
        discountItem *item = [discountItemsArray objectAtIndex:selectedItem.row];
        
        //In the destination detail view, set the detailArray to hold the selected item's info
        detailView.detailArray = @[item.discountName,item.discountImagePath,item.discountDesc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Make sure to close connection to the database, runs when app closes (doesn't actually run in prototype, as app is 'terminated' technically)
- (void)dealloc {
    sqlite3_close(_dbconnect);
    NSLog(@"Closed database!");
}

//Know how many items are in the array of items, so the TableView knows how large it should be
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [discountItemsArray count];
}

//Retrieves the items in the array, puts them into a respective cell in the TableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *tableIdentifier = @"table";
    
    //We are using the custom cells, detailed in the shopperCell class interface and implementation files
    discountCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    //TableViews load cells incrementally (as they need to be displayed) not all at once
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"discountCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //Allocate resources for an item of the GGDatabaseInfo type, set it equal to the object we'll be displaying
    discountItem *item = [discountItemsArray objectAtIndex:indexPath.row];
    
    //Set the cell up to display name, price, image of the item
    cell.barcodeLabel.text = item.discountName;
    
    return cell;
}

//This method runs when a table cell is tapped on, to segue into a detail view
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //Build a segue string based on the selected cell
    NSString *segueString = @"showDiscountDetails";
    
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
    return 90;
}

@end
