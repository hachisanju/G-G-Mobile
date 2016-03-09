//
//  discountItem.h
//  Software Engineering Project
//
//  Created by Saiprassad Gunasegaran on 11/5/15.
//

#import <Foundation/Foundation.h>

@interface discountItem : NSObject{
    
    int _primaryKey;
    NSString *_discountName;
    NSString *_discountImagePath;
    NSString *_discountDesc;
}

@property (nonatomic, assign) int primaryKey;
@property (nonatomic, copy) NSString *discountName;
@property (nonatomic, copy) NSString *discountImagePath;
@property (nonatomic, copy) NSString *discountDesc;

- (id)initWithUniqueId:(int)primaryKey discountName:(NSString *)discountName
             discountImagePath:(NSString *)discountImagePath discountDesc:(NSString *)discountDesc;

@end
