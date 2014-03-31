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
#import "RetweetStatus.h"

@interface Tweet : MUJSONResponseObject
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) BOOL retweeted;
@property (nonatomic, assign) int retweetCount;
@property (nonatomic, assign) int favoriteCount;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) RetweetStatus *retweetStatus;
@end

