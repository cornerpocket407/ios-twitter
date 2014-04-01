//
//  TweetTableViewCell.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetBarView.h"
@class TweetTableViewCell;
@protocol TweetTableViewReplyDelegate <NSObject>
- (void)replyTweet:(Tweet *)tweet;
@end

@interface TweetTableViewCell : UITableViewCell <TweetBarViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, strong) id<TweetTableViewReplyDelegate> delegate;
@end
