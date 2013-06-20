//
//  URLData.h
//  readystclair
//
//  Created by james whetsell on 2/26/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKMLParser.h"


@interface URLData : NSObject {

        NSString *labelName;
        BOOL displayed;
        NSURL *url;
        NSString *imageName;
        
        JKMLParser *kml;
        
    }
    @property (nonatomic, retain) JKMLParser *kml;
    @property (nonatomic, retain) NSString *labelName;
    @property (nonatomic, retain) NSString *imageName;
    @property (nonatomic, retain) NSURL *url;
    @property (nonatomic) BOOL displayed;

@end