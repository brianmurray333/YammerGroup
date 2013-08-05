//
//  YFGChooseGroupViewController.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "YFGUserGroups.h"

#define getGroupMessages @"https://www.yammer.com/api/v1/messages/in_group/2216505"
#define getUserInfo @"https://www.yammer.com/api/v1/users/"
#define MSFTNetworkToken @".json?access_token=6MEMKCmK2NVnFPQNfsO3Q"
#define FourLeafToken @".json?access_token=vJ4XqiVbbomfI0JtEKCmDw"
#define getCurrentUserData @"https://www.yammer.com/api/v1/users/current.json?access_token=vJ4XqiVbbomfI0JtEKCmDw"

@interface YFGChooseGroupViewController : UIViewController

<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray *groupArray;
@property (nonatomic, strong) NSMutableArray *groupIDArray;
@property (strong, nonatomic) IBOutlet UILabel *fnLabel;
@property (strong, nonatomic) IBOutlet UILabel *jtLabel;
@property (weak, nonatomic) IBOutlet UIImageView *msImage;
@property (strong, nonatomic) IBOutlet UIPickerView *myPicker;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSDictionary *groupNamesIDs;
@property (strong, nonatomic) UIAlertView *waitAlert;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

#pragma Methods

-(void) retrieveGroupMemberships;

- (IBAction)chooseGroup:(id)sender;
@end
