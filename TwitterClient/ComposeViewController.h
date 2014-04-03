//
//  ComposeViewController.h
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol ComposeFinishReloadTimelineDelegate <NSObject>
- (void)refreshHomeTimeline;
@end
@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id <ComposeFinishReloadTimelineDelegate> delegate;
- (id)initWithTweetToReply:(Tweet *)tweet;
@end
