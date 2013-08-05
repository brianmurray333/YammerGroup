//
//  YFGViewController.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YFGViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)logIn:(id)sender;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
