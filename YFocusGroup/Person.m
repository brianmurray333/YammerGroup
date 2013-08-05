//
//  Person.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize fullName, jobTitle, mugShot;

-(id) initWithFullName:(NSString *)fN andJobTitle:(NSString *)jT andMugShot:(UIImage *)msImage;
{
    self = [super init];
    if(self)
    {
        fullName = fN;
        jobTitle = jT;
        mugShot = msImage;
    }
    return self;
}

@end
