//
//  ShopperDetailViewController.m
//  Software Engineering Project
//
//  Created by Daniel Hazy on 11/30/15.
//

#import "ShopperDetailViewController.h"

@implementation ShopperDetailViewController

//Synthesize all properties
@synthesize detailArray;
@synthesize detailDesc;
@synthesize detailImage;
@synthesize detailPrice;
@synthesize detailName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Pull information about the item into the view itself 
    self.detailName.text = detailArray[0];
    self.detailPrice.text = detailArray[1];
    self.detailImage.image = [UIImage imageWithContentsOfFile:detailArray[2]];
    self.detailDesc.text = detailArray[3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
