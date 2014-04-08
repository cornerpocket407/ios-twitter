//
//  MainViewController.h
//  TwitterClient
//
//  Created by Tony Dao on 4/7/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "MenuViewController.h"
#import "TweetsType.h"

@interface MainViewController : UIViewController <MenuViewDelegate>
- (id)initWithUser:(User *)user;
- (id)initWithTweetType:(enum TWEETS_TYPE)tweetsType;
- (void)onMenuClickForType:(enum TWEETS_TYPE)type;
@end
