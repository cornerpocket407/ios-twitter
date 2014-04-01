//
//  Tweets.m
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "Tweet.h"
#import "NSObject+logProperties.h"

@implementation Tweet
- (instancetype)init
{
    if(self = [super init])
    {
        // There is no need to map all properties, only those which you want to have diffrent names;
        self.propertyMap = @{@"created_at": @"createdAt",
                             @"retweet_count": @"retweetCount",
                             @"retweeted_status": @"retweetStatus",
                             @"favorite_count": @"favoriteCount",
                             @"media_url":  @"mediaUrl",
                             @"id":  @"tweetId"};
    }
    return self;
}
@end
