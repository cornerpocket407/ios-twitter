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

@protocol TweetControllerRefreshTimelineDelegate <NSObject>
- (void)refreshHomeTimeline;
@end

@interface TweetController : UIViewController <TweetBarViewDelegate, ComposeViewControllerDelegate>
@property (nonatomic, strong) Tweet *tweet;
- (id)initWithTweet:(Tweet *)tweet;
@property (nonatomic, weak) id <TweetControllerRefreshTimelineDelegate> delegate;
@end
