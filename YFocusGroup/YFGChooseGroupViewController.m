//
//  YFGChooseGroupViewController.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "YFGChooseGroupViewController.h"
#import "YFGGroupMessagesController.h"
#import "YFGUserGroups.h"
#import "Person.h"

@interface YFGChooseGroupViewController ()

@end

@implementation YFGChooseGroupViewController
@synthesize groupArray, groupIDArray, myPicker, groupNamesIDs, waitAlert, activityIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"AppBackground.png"]]];

	// Do any additional setup after loading the view.
    self.title = @"Chose Group";
    
    [self personInfo];
        
    [self retrieveGroupMemberships];
    self.groupNamesIDs = [[NSDictionary alloc] initWithObjects:groupIDArray forKeys:groupArray];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Picker data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Return the number of rows in the section.
    return [self.groupArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(1.0f, 1.0f, [myPicker rowSizeForComponent:0].width, [myPicker rowSizeForComponent:0].height)];
    }
    retval.textAlignment = NSTextAlignmentCenter;
    retval.font = [UIFont systemFontOfSize:18];
    retval.text = [groupArray objectAtIndex:row];
    
    return retval;
}


#pragma mark - Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    NSLog(@"hello world");
    return [groupArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    //[self performSelector:@selector(dismiss:) withObject:waitAlert afterDelay:75.0];
    
}


#pragma Methods


-(void) personInfo
{
    NSURL *url = [NSURL URLWithString:getCurrentUserData];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:nil];
    
    NSString *fN = [parsedResponse objectForKey:@"full_name"];
    NSString *jT = [parsedResponse objectForKey:@"job_title"];
    NSString *msURL = [parsedResponse objectForKey:@"mugshot_url"];
    
    NSRange firstCharRange = NSMakeRange(46, 5);
    NSString *doubleSize = [msURL stringByReplacingCharactersInRange:firstCharRange withString:@"80x80"];
    
    NSURL *mugURL = [NSURL URLWithString:doubleSize];
    NSData *msData = [NSData dataWithContentsOfURL:mugURL];
    UIImage *mugShotProfile = [[UIImage alloc] initWithData:msData];
    
    Person *currentPerson = [[Person alloc] initWithFullName:fN andJobTitle:jT andMugShot:mugShotProfile];
    
    self.fnLabel.text = currentPerson.fullName;
    self.jtLabel.text = currentPerson.jobTitle;
    self.msImage.image = currentPerson.mugShot;
    
}

-(void) retrieveGroupMemberships
{
    
    NSURL *url = [NSURL URLWithString:getCurrentUserData];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:nil];
    // Get the web preferences section first from the overall response
    NSDictionary *parsedWebPrefSection = [parsedResponse objectForKey:@"web_preferences"];
    
    // Get the home tabs section first from the overall response
    NSArray *parsedHomeTabsSection = [parsedWebPrefSection objectForKey:@"home_tabs"];
    
    // Then loop through the messages, get the appropriate fields and create messages
    // to be displayed in this app.
    

    
    groupArray = [[NSMutableArray alloc] init];
    groupIDArray = [[NSMutableArray alloc] init];
    for (int i = 8; i < parsedHomeTabsSection.count;i++) {
        NSNumber *idNumber = [[parsedHomeTabsSection objectAtIndex:i] objectForKey:@"group_id"];
        NSString *groupID = [idNumber stringValue];
        NSString *gN = [[parsedHomeTabsSection objectAtIndex:i] objectForKey:@"name"];
        
        [groupArray addObject:gN];
        [groupIDArray addObject:groupID];
        
        //[groupArray addObject:currentGroup];
        
    }
    
}

- (IBAction)chooseGroup:(id)sender {

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YFGGroupMessagesController *detail2Controller =segue.destinationViewController;
    detail2Controller.groupNamesIDs = groupNamesIDs;
        
    NSInteger row = [self.myPicker selectedRowInComponent:0];
    NSString *rowGroupID = [groupIDArray objectAtIndex:row];
    NSString *rowGroupName = [groupArray objectAtIndex:row];


    detail2Controller.selectedGroupID = rowGroupID;
    detail2Controller.selectedGroupName = rowGroupName;
}

//    [NSThread detachNewThreadSelector:@selector(threadStartAnimating) toTarget:self withObject:nil];

//Your computations

//    waitAlert = [[UIAlertView alloc] initWithTitle:@"Hold Your Horses" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
//
//    [waitAlert show];
//
//    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//
//    // Adjust the indicator so it is up a few pixels from the bottom of the alert
//    activityIndicator.center = CGPointMake(waitAlert.bounds.size.width / 2, waitAlert.bounds.size.height - 50);
//    [activityIndicator startAnimating];
//    [waitAlert addSubview:activityIndicator];

@end
