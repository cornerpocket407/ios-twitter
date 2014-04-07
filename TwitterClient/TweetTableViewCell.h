//
//  TweetTableViewCell.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"
#import "TweetBarView.h"

@protocol ProfileImageDelegate <NSObject>
- (void)onProfileClick:(User *)user;
@end
@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, strong) id<TweetBarReplyDelegate> tweetBarViewDelegate;
@property (nonatomic, strong) id<ProfileImageDelegate> profileImageDelegate;
@end