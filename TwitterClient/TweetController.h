//
//  TweetController.h
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetBarView.h"
#import "ComposeViewController.h"

@interface TweetController : UIViewController <TweetBarReplyDelegate, ComposeFinishReloadTimelineDelegate>
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id <ComposeFinishReloadTimelineDelegate> composeFinishDelegate;
- (id)initWithTweet:(Tweet *)tweet;
@end
