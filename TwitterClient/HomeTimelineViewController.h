//
//  HomeTimelineViewController.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComposeViewController.h"
#import "TweetTableViewCell.h"
#import "TweetController.h"
#import "User.h"

enum TWEETS_TYPE
{
    mentions,
    home,
    user
};
@interface HomeTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ComposeFinishReloadTimelineDelegate, TweetBarReplyDelegate, ProfileImageDelegate> {
  enum TWEETS_TYPE tweetsType;
}
- (id)initWithUser:(User *) user;
- (id)initWithTweetType:(enum TWEETS_TYPE)tweetsType;
@end
