//
//  YFGMessageCell.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/8/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFGMessageCell : UITableViewCell

@property (copy, nonatomic) NSString *posterName;
@property (copy, nonatomic) NSString *messageBody;
@property (copy, nonatomic) NSString *postedTime;
@property (copy, nonatomic) UIImage *mugShot;

@property (strong, nonatomic)IBOutlet UILabel *posterNameText;
@property (strong, nonatomic)IBOutlet UILabel *messageBodyText;
@property (strong, nonatomic)IBOutlet UILabel *postedTimeText;
@property (strong, nonatomic)IBOutlet UIImageView *mugShotImage;

@end
