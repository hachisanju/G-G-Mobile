//
//  ViewController.m
//  Software Engineering Project
//
//  Created by Thomas Wilson on 10/21/15.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //The URL to the site
    NSString *webLink = @"http://gandgmobile.blogspot.com";
    
    //Process the URL
    NSURL*url=[NSURL URLWithString:webLink];
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    //Make sure to fit contents of the website inside the webview
    self.siteView.scalesPageToFit = YES;
    [self.siteView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

