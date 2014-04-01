//
//  FooView.m
//  TwitterClient
//
//  Created by Tony Dao on 3/31/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "TweetBarView.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"

@interface TweetBarView()
@property (weak, nonatomic) IBOutlet UIImageView *replyView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetView;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteView;
@end
@implementation TweetBarView

- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"TweetBarView" owner:self options:nil];
    [self addSubview:self.view];
    [self setupFavoriteView];
 
}
- (void)setupFavoriteView {
    [self.favoriteView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *favoriteTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFavorite)];
    [favoriteTap setNumberOfTapsRequired:1];
    [self.favoriteView addGestureRecognizer:favoriteTap];
}

- (void)onReply {
    NSLog(@"pressed reply");
    [self.delegate replyTweet:self.tweet];
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    if (tweet.favorited) {
        [self.favoriteView setImage:[UIImage imageNamed: @"favorite_on"]];
    }
    if (tweet.retweeted) {
        [self.retweetView setImage:[UIImage imageNamed: @"retweet_on"]];
    }
    if (tweet.repliedTweetId == [NSNull null]) {
        [self setupReplyView];
    } else {
        [self.replyView setHidden:YES];
    }
}

- (void)setupReplyView {
    [self.replyView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *replyTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReply)];
    [replyTap setNumberOfTapsRequired:1];
    [self.replyView addGestureRecognizer:replyTap];
}

- (void)onFavorite {
    if (self.tweet.favorited) {
        [[TwitterClient instance] unFavorites:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.tweet.favorited = FALSE;
            [self.favoriteView setImage:[UIImage imageNamed: @"favorite"]];
        }];
    } else {
        [[TwitterClient instance] favorites:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.tweet.favorited = TRUE;
            [self.favoriteView setImage:[UIImage imageNamed: @"favorite_on"]];
        }];
    }
}
@end
