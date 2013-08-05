//
//  YFGDetailView.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/8/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

#define getThreadMessages @"https://www.yammer.com/api/v1/messages/in_thread/"
#define getSpecific @"https://www.yammer.com/api/v1/messages/in_thread/308053925.json?access_token=6MEMKCmK2NVnFPQNfsO3Q"
#define getUserInfo @"https://www.yammer.com/api/v1/users/"
#define MSFTNetworkToken @".json?access_token=6MEMKCmK2NVnFPQNfsO3Q"
#define FourLeafToken @".json?access_token=vJ4XqiVbbomfI0JtEKCmDw"
#define getCurrentUserData @"https://www.yammer.com/api/v1/users/current.json?access_token=vJ4XqiVbbomfI0JtEKCmDw"
#define postURL @"https://www.yammer.com/api/v1/messages.json?access_token=vJ4XqiVbbomfI0JtEKCmDw"
#define bodyPart @"body="
#define replyPart @"&replied_to_id="

@interface YFGDetailView : UITableViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *threadMessagesArray;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSString *threadID;
@property (strong, nonatomic) UIAlertView *waitAlert;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UILabel *footerLabel;
@property (strong, nonatomic) UIButton *footerButton;

@property (weak, nonatomic) IBOutlet UIView *publisherView;
@property (strong, nonatomic) NSString *responseMessage;
@property (weak, nonatomic) IBOutlet UITextField *textFieldText;


#pragma Methods


-(void) retrieveThreadMessages;
- (IBAction)postResponse:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
