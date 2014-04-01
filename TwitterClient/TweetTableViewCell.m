//
//  TweetTableViewCell.m
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "TweetTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Tweet.h"
#import "MHPrettyDate.h"
#import "TwitterClient.h"
#import "TweetBarView.h"

@interface TweetTableViewCell()
@property (weak, nonatomic) IBOutlet TweetBarView *tweetBarView;
@property (nonatomic, strong) TwitterClient *client;
@end

@implementation TweetTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    tweet = tweet.retweetStatus ? tweet.retweetStatus : tweet;
    User *user = tweet.user;
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    self.tweetLabel.text = tweet.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *date = [dateFormatter dateFromString:tweet.createdAt];
    self.dateLabel.text = [MHPrettyDate prettyDateFromDate:date withFormat:MHPrettyDateShortRelativeTime];
    [self.profileImage  setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
//    [self.replyView setUserInteractionEnabled:YES];
//    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapping:)];
//    [singleTap setNumberOfTapsRequired:1];
//    [self.replyView addGestureRecognizer:singleTap];
    self.tweetBarView.tweet = tweet;
    self.tweetBarView.delegate = self;
}

- (void)replyTweet:(Tweet *)tweet {
    [self.delegate replyTweet:tweet];
}
@end
