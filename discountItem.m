//
//  discountItem.m
//  Software Engineering Project
//
//  Created by Saiprassad Gunasegaran on 11/5/15.
//

#import "discountItem.h"

@implementation discountItem

@synthesize discountDesc = _discountDesc;
@synthesize discountImagePath = _discountImagePath;
@synthesize discountName = _discountName;
@synthesize primaryKey = _primaryKey;

- (id)initWithUniqueId:(int)primaryKey discountName:(NSString *)discountName
     discountImagePath:(NSString *)discountImagePath discountDesc:(NSString *)discountDesc{
    if ((self = [super init])) {
        self.primaryKey = primaryKey;
        self.discountName = discountName;
        self.discountImagePath = discountImagePath;
        self.discountDesc = discountDesc;
    }
    return self;
}

- (void) dealloc {
    self.discountDesc = nil;
    self.discountImagePath = nil;
    self.discountName= nil;
}

@end
