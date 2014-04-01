//
//  FooView.m
//  TwitterClient
//
//  Created by Tony Dao on 3/31/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "TweetBarView.h"
#import "TwitterClient.h"

@interface TweetBarView()
@property (weak, nonatomic) IBOutlet UIImageView *replyView;
@property (weak, nonatomic) IBOutlet UIImageView *retweetView;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteView;
@end
@implementation TweetBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
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
    
    [self.replyView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *replyTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onReply)];
    [replyTap setNumberOfTapsRequired:1];
    [self.replyView addGestureRecognizer:replyTap];
    
    [self.favoriteView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *favoriteTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onFavorite)];
    [favoriteTap setNumberOfTapsRequired:1];
    [self.favoriteView addGestureRecognizer:favoriteTap];
//            NSLog(@"inside favorite view %@", self.tweet.text);

}

-(void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    if (self.tweet.favorited) {
        [self.favoriteView setImage:[UIImage imageNamed: @"favorite_on"]];
    }
    if (self.tweet.retweeted) {
        [self.retweetView setImage:[UIImage imageNamed: @"retweet_on"]];
    }
}

- (void)onFavorite {
    if (!self.tweet.favorited) {
        [[TwitterClient instance] favorites:self.tweet.tweetId success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Favorite succeeded");
            [self.favoriteView setImage:[UIImage imageNamed: @"favorite_on"]];
        }];
    }
}
@end
