//
//  PITableViewCell.m
//  readystclair
//
//  Created by james whetsell on 3/9/12.
//  Copyright (c) 2012 src. All rights reserved.
//

#import "PITableViewCell.h"

@implementation PITableViewCell

@synthesize fieldName, type;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
