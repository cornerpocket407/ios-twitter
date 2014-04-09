//
//  UserProfileHeaderView.h
//  TwitterClient
//
//  Created by Tony Dao on 4/9/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface UserProfileHeaderView : UIView
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) User *user;
@end
