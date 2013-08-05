//
//  Person.h
//  YFocusGroup
//
//  Created by Brian Murray on 7/7/13.
//  Copyright (c) 2013 Yammer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *jobTitle;
@property (nonatomic, strong) UIImage *mugShot;

-(id) initWithFullName: (NSString *) fN andJobTitle: (NSString *) jT andMugShot: (UIImage *)msImage;

@end
