//
//  GGDatabaseInfo.m
//  Software Engineering Project
//
//  Created by Daniel Hazy and Sudhanshu Rath on 10/22/15.
//

#import "GGDatabaseInfo.h"

@implementation GGDatabaseInfo

@synthesize uniqueId = _uniqueId;
@synthesize name = _name;
@synthesize desc = _desc;
@synthesize imagepath = _imagepath;
@synthesize price = _price;

- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name
             imagepath:(NSString *)imagepath price:(NSString *)price desc:(NSString *)desc{
    if ((self = [super init])) {
        self.uniqueId = uniqueId;
        self.name = name;
        self.price = price;
        self.desc = desc;
        self.imagepath = imagepath;
    }
    return self;
}

- (void) dealloc {
    self.name = nil;
    self.price = nil;
    self.desc = nil;
    self.imagepath = nil;
}

@end