//
//  YFGAppDelegate.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>
#define getGroupMessages @"https://www.yammer.com/api/v1/messages/in_group/2216505"
#define getUserInfo @"https://www.yammer.com/api/v1/users/"
#define MSFTNetworkToken @".json?access_token=6MEMKCmK2NVnFPQNfsO3Q"
#define FourLeafToken @".json?access_token=vJ4XqiVbbomfI0JtEKCmDw"
#define getCurrentUserData @"https://www.yammer.com/api/v1/users/current"


@interface YFGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



@end
