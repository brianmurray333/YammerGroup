//
//  YFGGroupMessagesController.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "YFGGroupMessagesController.h"
#import "YFGChooseGroupViewController.h"
#import "GroupMessages.h"
#import "YFGDetailView.h"
#define kCustomRowCount 7


@interface YFGGroupMessagesController ()

@end

@implementation YFGGroupMessagesController
@synthesize groupMessagesArray, myTableView, groupNamesIDs, selectedGroupName, selectedGroupID, waitAlert, activityIndicator, window;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:selectedGroupName forKey:@"selectedGroup"];
    [defaults synchronize];
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Back"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(back:)];
    self.navigationItem.backBarButtonItem = backButton;
    
    waitAlert = [[UIAlertView alloc]initWithTitle:@"Wait For It..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [waitAlert show];
    [waitAlert addSubview:activityIndicator];
// Adjust the indicator so it is up a few pixels from the bottom of the alert
    activityIndicator.center = CGPointMake(waitAlert.bounds.size.width / 2, waitAlert.bounds.size.height - 50);
    

    [activityIndicator startAnimating];
    
   // [self performSelector:@selector(dismiss:) withObject:waitAlert afterDelay:30.0];

    
    self.title = selectedGroupName;
    //self.navigationItem.backBarButtonItem.title = @"Choose Group";
    self.groupMessagesArray = [[NSMutableArray alloc] init];

    [self retrieveGroupMessages];
    
    //    detail2Controller.waitAlert = waitAlert;
    //    detail2Controller.activityIndicator = activityIndicator;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
    //new below
    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSUInteger count = [self.groupMessagesArray count];
    
    // if there's no data yet, return enough rows to fill the screen
    if (count == 0)
    {
        return kCustomRowCount;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //retrieve current group message object for this indexpath
    if ([groupMessagesArray count]) {
        GroupMessages *currentMessage = [groupMessagesArray objectAtIndex:indexPath.row];

        cell.imageView.image = currentMessage.userImage;
        cell.textLabel.text = currentMessage.posterName;
        cell.detailTextLabel.text = currentMessage.messageBody;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"Cell1" sender:[self.tableView cellForRowAtIndexPath:indexPath]];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


#pragma Methods
-(void) retrieveGroupMessages
{
    
    dispatch_queue_t fetchQ = dispatch_queue_create("Yammer fetch", NULL);
    dispatch_async(fetchQ, ^{
    
        NSString *pleaseString = [getChosenGroupMessages stringByAppendingString:selectedGroupID];
        NSString *finalURL = [pleaseString stringByAppendingString:FourLeafToken];
        
        NSURL *url = [NSURL URLWithString:finalURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:nil];

        // Get the messages section first from the overall response
        NSArray *parsedMessagesSection = [parsedResponse objectForKey:@"messages"];
        
        // Then loop through the messages, get the appropriate fields and create messages
        // to be displayed in this app.
        
        for (int i = 0; i < parsedMessagesSection.count;i++) {
            NSDictionary *mB = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"body"];
            NSString *plainBody = [mB objectForKey:@"plain"];
            NSString *pT = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"created_at"];
            NSNumber *senderID = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"sender_id"];
            NSString *pX = [senderID stringValue];
            NSNumber *threadID = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"thread_id"];
            NSString *tID = [threadID stringValue];
            NSString *incompleteUserURL = [getUserInfo stringByAppendingString:pX];
            NSString *uURL = [incompleteUserURL stringByAppendingString:FourLeafToken];
            
            NSURL *currentuserURL = [NSURL URLWithString:uURL];
            NSData *currentuserData = [NSData dataWithContentsOfURL:currentuserURL];
            
            NSDictionary *newJSON = [NSJSONSerialization JSONObjectWithData:currentuserData
                                                                    options:kNilOptions
                                                                      error:nil];
            NSString *fN = [newJSON objectForKey:@"full_name"];
            NSString *mugURL = [newJSON objectForKey:@"mugshot_url"];
            
            NSURL *url = [NSURL URLWithString:mugURL];
            NSData *userMugShotData = [NSData dataWithContentsOfURL:url];
            
            UIImage *mugShot = [[UIImage alloc] initWithData:userMugShotData];
            
            //Add myGroupMessage Object to GroupMessages Array
            GroupMessages *myGroupMessage = [[GroupMessages alloc] initWithMessageBody:plainBody andPostedTime:pT andPosterName:fN andThreadID:tID andUserImage: mugShot];
            
            [groupMessagesArray addObject:myGroupMessage];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
            [self.waitAlert dismissWithClickedButtonIndex:-1 animated:YES];
        });
    });

    
}

-(void)dismiss:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)back:(id)sender {
    YFGChooseGroupViewController *startVC = [[YFGChooseGroupViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:startVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    YFGDetailView *detailController =segue.destinationViewController;
    GroupMessages *messageSelected = [self.groupMessagesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    NSString *selectedThread = messageSelected.threadID;
    detailController.threadID = selectedThread;
}

@end
