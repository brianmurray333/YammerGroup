//
//  ThreadMsg.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/8/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadMsg : NSObject

@property (nonatomic, strong) NSString *messageBody;
@property (nonatomic, strong) NSString *postedTime;
@property (nonatomic, strong) NSString *posterName;
@property (nonatomic, strong) NSString *repliedTo;
@property (nonatomic, strong) NSString *messageID;
@property (nonatomic, strong) UIImage *posterMug;

//Methods
-(id) initWithMessageBody: (NSString *) mB andPostedTime: (NSString *) pT andPosterName: (NSString *) fN andRepliedTo: (NSString *) rT andMessageID:  (NSString *) mID andPosterMug: (UIImage *) mugShot;

@end