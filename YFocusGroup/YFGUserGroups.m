//
//  YFGUserGroups.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "YFGUserGroups.h"

@implementation YFGUserGroups

@synthesize groupName;

-(id) initWithGroupName:(NSString *)gN
{
    self = [super init];
    if(self)
    {
        groupName = gN;
    }
    return self;
}
@end
