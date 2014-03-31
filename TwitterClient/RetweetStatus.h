//
//  RetweetStatus.h
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUJSONResponseSerializer.h"
#import "User.h"

@interface RetweetStatus : MUJSONResponseObject
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *createdAt;
@end
