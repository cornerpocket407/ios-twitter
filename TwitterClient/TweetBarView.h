//
//  FooView.h
//  TwitterClient
//
//  Created by Tony Dao on 3/31/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
@class TweetBarView;
@protocol TweetBarReplyDelegate <NSObject>
- (void)replyTweet:(Tweet *)tweet;
@end

@interface TweetBarView : UIView
@property (nonatomic, strong) id<TweetBarReplyDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) Tweet *tweet;
@end
