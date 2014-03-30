//
//  HomeTimelineResult.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUJSONResponseSerializer.h"
#import "Tweet.h"

@interface HomeTimelineResult : MUJSONResponseObject
@property (nonatomic, strong) NSArray *tweets;
@end
