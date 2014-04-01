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

@interface HomeTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, TweetTableViewReplyDelegate, TweetControllerRefreshTimelineDelegate>

@end
