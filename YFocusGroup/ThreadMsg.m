//
//  ThreadMsg.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/8/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "ThreadMsg.h"

@implementation ThreadMsg
@synthesize messageBody, postedTime, posterName, repliedTo, messageID, posterMug;

-(id) initWithMessageBody: (NSString *) mB andPostedTime: (NSString *) pT andPosterName: (NSString *) fN andRepliedTo: (NSString *) rT andMessageID:  (NSString *) mID andPosterMug: (UIImage *) mugShot
{
        self = [super init];
        if(self)
        {
            messageBody = mB;
            postedTime = pT;
            posterName = fN;
            repliedTo = rT;
            messageID = mID;
            posterMug = mugShot;
            
        }
        return self;
}

@end
