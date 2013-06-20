//
//  PITableViewCell.h
//  readystclair
//
//  Created by james whetsell on 3/9/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PITableViewCell : UITableViewCell {
    NSString *fieldName;
    NSInteger  type;
}

@property (nonatomic, retain) NSString *fieldName;
@property (nonatomic) NSInteger type;


@end
