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
    self.nameLabel.text = tweet.user.name;
    self.tweetLabel.text = tweet.text;
    [self.profileImage  setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
}
@end
