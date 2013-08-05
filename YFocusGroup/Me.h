//
//  Me.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/11/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>
#define getCurrentUserData @"https://www.yammer.com/api/v1/users/current.json?access_token=vJ4XqiVbbomfI0JtEKCmDw"

@interface Me : NSObject

@property (nonatomic, strong) NSString *currentTime;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) UIImage *mugShot;

-(id) initWithCurrentTime: (NSString *) cT andFullName: (NSString *) fN andMugShot: (UIImage *)msImage;


@end
