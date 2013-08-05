//
//  GroupMessages.m
//  FocusGroupOne
//
//  Created by Brian Murray on 7/6/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "GroupMessages.h"

@implementation GroupMessages
@synthesize messageBody, postedTime, posterName, threadID, userImage;

-(id) initWithMessageBody:(NSString *)mB andPostedTime:(NSString *)pT andPosterName:(NSString *) fN andThreadID: (NSString *) tID andUserImage:(UIImage *)mugShot
{
    self = [super init];
    if(self)
    {
        messageBody = mB;
        postedTime = pT;
        posterName = fN;
        threadID = tID;
        userImage = mugShot;
        
    }
    return self;
}
@end
