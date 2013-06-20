//
//  ChecklistData.h
//  readystclair
//
//  Created by james whetsell on 2/20/12.
//  Copyright 2012 src. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistData : NSObject{
    NSInteger clID;
    NSString *desc;
    NSString *name;
    NSInteger checked;
}
@property (nonatomic) NSInteger  clID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic) NSInteger  checked;

@end
