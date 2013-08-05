//
//  Me.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/11/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "Me.h"

@implementation Me

@synthesize currentTime, fullName, mugShot;

-(id)initWithCurrentTime:(NSString *)cT andFullName:(NSString *)fN andMugShot:(UIImage *)msImage
{
    self = [super init];
    if(self)
    {
        NSDateFormatter *formatter;
        NSString        *dateString;
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
        
        dateString = [formatter stringFromDate:[NSDate date]];
        
        NSURL *url = [NSURL URLWithString:getCurrentUserData];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:nil];
        
        NSString *myName = [parsedResponse objectForKey:@"full_name"];
        NSString *msURL = [parsedResponse objectForKey:@"mugshot_url"];
        NSURL *mugU = [NSURL URLWithString:msURL];
        NSData *msData = [NSData dataWithContentsOfURL:mugU];
        UIImage *mugShotProfile = [[UIImage alloc] initWithData:msData];
        
        currentTime = dateString;
        fullName = myName;
        mugShot = mugShotProfile;
    }
    return self;

}

@end
