//
//  GroupMessages.h
//  FocusGroupOne
//
//  Created by Brian Murray on 7/6/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GroupMessages : NSObject

@property (nonatomic, strong) NSString *messageBody;
@property (nonatomic, strong) NSString *postedTime;
@property (nonatomic, strong) NSString *posterName;
@property (nonatomic, strong) NSString *threadID;
@property (nonatomic, strong) UIImage *userImage;

//Methods
-(id) initWithMessageBody: (NSString *) mB andPostedTime: (NSString *) pT andPosterName: (NSString *) fN andThreadID:  (NSString *) tID andUserImage: (UIImage *) mugShot;

@end
