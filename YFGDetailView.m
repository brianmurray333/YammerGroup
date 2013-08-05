//
//  YFGDetailView.m
//  YFocusGroup
//
//  Created by Brian Murray on 7/8/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import "YFGDetailView.h"
#import "ThreadMsg.h"
#import "YFGMessageCell.h"
#define kCustomRowCount 7

@interface YFGDetailView ()

@end

@implementation YFGDetailView
@synthesize threadMessagesArray, myTableView, threadID, responseMessage, footerLabel, footerButton, publisherView, textFieldText;

static NSString *CellTableIdentifier = @"CellTableIdentifier";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITableView *tableView = (id)[self.view viewWithTag:1];
    self.title = @"Conversation";
    tableView.rowHeight = 120;
    [tableView registerClass:[YFGMessageCell class] forCellReuseIdentifier:CellTableIdentifier];
    self.threadMessagesArray = [[NSMutableArray alloc] init];
    [self retrieveThreadMessages];
    
    if(responseMessage)
    {
        [self.tableView reloadData];
    }
    
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height -     self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillAppear:animated];
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

    NSUInteger count = [self.threadMessagesArray count];

    return count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    
    YFGMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[YFGMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
    }
    
    // Configure the cell...
    
    if ([threadMessagesArray count]) {
    NSArray *orderedArray = [[threadMessagesArray reverseObjectEnumerator] allObjects];
    ThreadMsg *currentMessage = [orderedArray objectAtIndex:indexPath.row];
    
    
    cell.posterNameText.text = currentMessage.posterName;
    cell.postedTimeText.text = currentMessage.postedTime;
    cell.messageBodyText.text = currentMessage.messageBody;
    cell.mugShotImage.image = currentMessage.posterMug;
    }
    return cell;
    
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 60;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    return publisherView;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (IBAction)responseText:(id)sender {
}

-(void) retrieveThreadMessages
{
    //dispatch_queue_t fetchQ = dispatch_queue_create("Yammer fetch", NULL);
      //  dispatch_async(fetchQ, ^{

        NSString *midURL = [getThreadMessages stringByAppendingString:threadID];
        NSString *fullURL = [midURL stringByAppendingString:FourLeafToken];
        NSURL *url = [NSURL URLWithString:fullURL];
        NSData *data = [NSData dataWithContentsOfURL:url];

        NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:nil];
        // Get the messages section first from the overall response

    NSArray *parsedMessagesSection = [parsedResponse objectForKey:@"messages"];
        
        // Then loop through the messages, get the appropriate fields and create messages
        // to be displayed in this app.
        
        threadMessagesArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < parsedMessagesSection.count;i++) {
            //get body
            NSDictionary *mB = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"body"];
            NSString *plainBody = [mB objectForKey:@"plain"];
            //get time
            NSString *firstTime = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"created_at"];
            NSString *timeOne = [firstTime substringToIndex:[firstTime length] - 6];
            NSString *timeDATE = [timeOne substringToIndex:10];
            NSString *timeTIME = [timeOne substringFromIndex:10];
            NSString *spaceT = [timeTIME stringByAppendingString:@" - "];
            NSString *pT = [spaceT stringByAppendingString:timeDATE];
            
            //get senderID
            NSNumber *senderID = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"sender_id"];
            NSString *pX = [senderID stringValue];
            
            NSString *rT = @"1";
            
            //get message ID
            NSNumber *messageID = [[parsedMessagesSection  objectAtIndex:i] objectForKey:@"id"];
            NSString *mID = [messageID stringValue];
            
            //API call for user info
            NSString *incompleteUserURL = [getUserInfo stringByAppendingString:pX];
            NSString *uURL = [incompleteUserURL stringByAppendingString:FourLeafToken];
            NSURL *currentuserURL = [NSURL URLWithString:uURL];
            NSData *currentuserData = [NSData dataWithContentsOfURL:currentuserURL];
            
            NSDictionary *newJSON = [NSJSONSerialization JSONObjectWithData:currentuserData
                                                                    options:kNilOptions
                                                                      error:nil];
            //get full name
            NSString *fN = [newJSON objectForKey:@"full_name"];
            
            //get mugShot
            NSString *mugURL = [newJSON objectForKey:@"mugshot_url"];
            NSURL *url = [NSURL URLWithString:mugURL];
            NSData *userMugShotData = [NSData dataWithContentsOfURL:url];
            UIImage *mugShot = [[UIImage alloc] initWithData:userMugShotData];
            
            //Add thread message object to ThreadMessages Array
            ThreadMsg *myThreadMessage = [[ThreadMsg alloc] initWithMessageBody:plainBody andPostedTime:pT andPosterName:fN andRepliedTo:rT andMessageID:mID andPosterMug:mugShot];
            
            [threadMessagesArray addObject:myThreadMessage];
    }
        [self.myTableView reloadData];

}

- (IBAction)postResponse:(id)sender {
    
    responseMessage = textFieldText.text;
    NSURL *posterURL = [NSURL URLWithString:postURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:posterURL];
    NSString *bodyOnly = [bodyPart stringByAppendingString:responseMessage];

    NSString *replyOnly = [replyPart stringByAppendingString:threadID];

    NSString *fullRequest = [bodyOnly stringByAppendingString:replyOnly];
    
    NSData *postData = [fullRequest dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: postData];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    textFieldText.text = @"";
    [textFieldText resignFirstResponder];
    
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    NSURL *url = [NSURL URLWithString:getCurrentUserData];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *parsedResponse = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:nil];
    
    NSString *myName = [parsedResponse objectForKey:@"full_name"];
    NSString *msURL = [parsedResponse objectForKey:@"mugshot_url"];
    NSURL *mugU = [NSURL URLWithString:msURL];
    NSData *msData = [NSData dataWithContentsOfURL:mugU];
    UIImage *mugShotProfile = [[UIImage alloc] initWithData:msData];
    
    ThreadMsg *newPostMessage = [[ThreadMsg alloc] initWithMessageBody:responseMessage andPostedTime:dateString andPosterName:myName andRepliedTo:threadID andMessageID:@"123456" andPosterMug: mugShotProfile];
    
    [threadMessagesArray insertObject:newPostMessage atIndex:1];
    [myTableView reloadData];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 90; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSString *responsePost = textField.text;
//    responseMessage = responsePost;
//}

@end
