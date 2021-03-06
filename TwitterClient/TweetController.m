//
//  TweetController.m
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "TweetController.h"
#import "TweetBarView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ComposeViewController.h"
#import "MHPrettyDate.h"

@interface TweetController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
@property (weak, nonatomic) IBOutlet TweetBarView *tweetBarView;
@end

@implementation TweetController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithTweet:(Tweet *)tweet {
    self = [super init];
    if (self) {
        self.tweet = tweet.retweetStatus ? tweet.retweetStatus : tweet;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Tweet *tweet = self.tweet;
    User *user = tweet.user;
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = user.screenName;
    self.tweetLabel.text = tweet.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *date = [dateFormatter dateFromString:tweet.createdAt];
    self.timestampLabel.text = [MHPrettyDate prettyDateFromDate:date withFormat:MHPrettyDateFormatWithTime];
    self.tweet.text = tweet.text;
    self.retweetLabel.text = [NSString stringWithFormat:@"%d RETWEETS", tweet.retweetCount];
    self.favoritesLabel.text = [NSString stringWithFormat:@"%d FAVORITES", tweet.favoriteCount];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.tweetBarView.tweet = tweet;
    self.tweetBarView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma TweetBarViewDelegate
- (void)replyTweet:(Tweet *)tweet {
    ComposeViewController *cc = [[ComposeViewController alloc] initWithTweetToReply:self.tweet];
    cc.delegate = self.composeFinishDelegate;
    [self.navigationController pushViewController:cc animated:YES];
}

@end
