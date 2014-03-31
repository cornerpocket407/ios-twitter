//
//  TweetController.h
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetController : UIViewController
@property (nonatomic, strong) Tweet *tweet;
- (id)initWithTweet:(Tweet *)tweet;
@end
