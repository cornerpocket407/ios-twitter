//
//  TweetController.m
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "TweetController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TweetController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
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
        self.tweet = tweet;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Tweet *tweet = self.tweet.retweetStatus ? self.tweet.retweetStatus : self.tweet;
    User *user = tweet.user;
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = user.screenName;
    self.tweetLabel.text = tweet.text;
    self.timestampLabel.text = tweet.retweetStatus ? tweet.retweetStatus.createdAt : tweet.createdAt;
    self.tweet.text = tweet.text;
    self.retweetLabel.text = [NSString stringWithFormat:@"%d RETWEETS", tweet.retweetCount];
    self.favoritesLabel.text = [NSString stringWithFormat:@"%d FAVORITES", tweet.favoriteCount];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
