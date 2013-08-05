//
//  YFGGroupMessagesController.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define getChosenGroupMessages @"https://www.yammer.com/api/v1/messages/in_group/"
#define getSpecificGroup @"https://www.yammer.com/api/v1/messages/in_group/1007601.json?access_token=6MEMKCmK2NVnFPQNfsO3Q"
#define getUserInfo @"https://www.yammer.com/api/v1/users/"
#define MSFTNetworkToken @".json?access_token=6MEMKCmK2NVnFPQNfsO3Q"
#define FourLeafToken @".json?access_token=vJ4XqiVbbomfI0JtEKCmDw"

//#define getCurrentUserData @"https://www.yammer.com/api/v1/users/current"

@interface YFGGroupMessagesController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *groupMessagesArray;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSDictionary *groupNamesIDs;
@property (strong, nonatomic) NSString *selectedGroupName;
@property (strong, nonatomic) NSString *selectedGroupID;
@property (strong, nonatomic) UIAlertView *waitAlert;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIWindow *window;

#pragma Methods

-(void) retrieveGroupMessages;

//- (IBAction)chooseGroup:(id)sender;

@end
