//
//  DiscountDetailViewController.m
//  Software Engineering Project
//
//  Created by Saiprassad Gunasegaran on 11/30/15.
//

#import "DiscountDetailViewController.h"

@implementation DiscountDetailViewController

@synthesize detailArray;
@synthesize detailViewItemDesc;
@synthesize detailViewItemImage;
@synthesize detailViewItemName;

- (void)viewDidLoad {
    [super viewDidLoad];

    //Set up to show the passed data
    self.detailViewItemName.text = detailArray[0];
    self.detailViewItemImage.image = [UIImage imageWithContentsOfFile:detailArray[1]];
    self.detailViewItemDesc.text = detailArray[2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
