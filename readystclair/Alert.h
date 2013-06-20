//
//  Alert.h
//  readystclair
//
//  Created by james whetsell on 3/5/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alert : NSObject {    
    NSString *title;
    NSString *summary;
    NSString *area;
    NSString *date;
    NSString *countyCode;
}
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *summary;
@property (nonatomic, retain) NSString  *area;
@property (nonatomic, retain) NSString  *date;
@property (nonatomic, retain) NSString  *countyCode;


@end
