//
//  UserProfileViewController.h
//  TwitterClient
//
//  Created by Tony Dao on 4/8/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "TweetTableViewCell.h"
#import "TweetController.h"
#import "User.h"
#import "TweetsType.h"

@interface UserProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ComposeFinishReloadTimelineDelegate, TweetBarReplyDelegate, ProfileImageDelegate>
- (id)initWithUser:(User *) user;
@end
