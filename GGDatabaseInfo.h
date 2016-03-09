//
//  GGDatabaseInfo.h
//  Software Engineering Project
//
//  Created by Daniel Hazy and Sudhanshu Rath on 10/22/15.
//

#import <Foundation/Foundation.h>

@interface GGDatabaseInfo : NSObject {
    //All of the information a shopper item from the database should contain
    int _uniqueId;
    NSString *_name;
    NSString *_desc;
    NSString *_imagepath;
    NSString *_price;
}

//Properties of the same items for ease of access
@property (nonatomic, assign) int uniqueId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *imagepath;
@property (nonatomic, copy) NSString *price; 

//Method which links the properties and class member variables 
- (id)initWithUniqueId:(int)uniqueId name:(NSString *)name
             imagepath:(NSString *)imagepath price:(NSString *)price desc:(NSString *)desc;

@end
