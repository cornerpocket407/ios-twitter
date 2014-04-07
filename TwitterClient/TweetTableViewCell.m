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
- (IBAction)onProfileTap:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet TweetBarView *tweetBarView;
@property (nonatomic, strong) TwitterClient *client;
@end

@implementation TweetTableViewCell

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
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
//    UITapGestureRecognizer *profileTapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileTap:)];
//    [profileTapGesture setNumberOfTapsRequired:1];
//    [self.profileImage addGestureRecognizer:profileTapGesture];
    [self setupTweetBarWith:tweet];
}

- (void)onProfileTap {
    NSLog(@"Tapped");
}

- (void)setupTweetBarWith:(Tweet *)tweet {
    self.tweetBarView.tweet = tweet;
    self.tweetBarView.delegate = self.tweetBarViewDelegate;
}
- (IBAction)onProfileTap:(UITapGestureRecognizer *)sender {
    NSLog(@"Tapped");
}
@end
