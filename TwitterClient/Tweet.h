//
//  Tweets.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUJSONResponseSerializer.h"
#import "User.h"

@interface Tweet : MUJSONResponseObject
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) int retweetCount;
@property (nonatomic, assign) int favoriteCount;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Tweet *retweetStatus;
@property (nonatomic, strong) NSNumber *tweetId;
//Twitter returns <null> if the tweet is not a reply. And MUJSONResponseSerializer will deserialize that into NSNull
@property (nonatomic, strong) NSNumber *repliedTweetId;

@end

