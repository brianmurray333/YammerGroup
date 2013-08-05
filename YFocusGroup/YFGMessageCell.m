//
//  YFGMessageCell.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/8/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "YFGMessageCell.h"

@implementation YFGMessageCell
@synthesize posterNameText, messageBodyText, postedTimeText, mugShotImage;


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
