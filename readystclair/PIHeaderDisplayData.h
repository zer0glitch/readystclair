//
//  PIHeaderDisplayData.h
//  readystclair
//
//  Created by james whetsell on 4/4/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIHeaderDisplayData  : NSObject {
    NSInteger groupKey;
    NSInteger dataKey;
    NSString *fieldName;
    NSString *value;
}

@property (nonatomic) NSInteger groupKey;
@property (nonatomic) NSInteger dataKey;
@property (nonatomic, retain) NSString *fieldName;
@property (nonatomic, retain) NSString *value;

@end
