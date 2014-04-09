//
//  User.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUJSONResponseSerializer.h"
#import "NSObject+logProperties.h"

@interface User : MUJSONResponseObject <NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *profileBackgroundImageUrl;
@property (nonatomic, strong) NSNumber *followers;
@property (nonatomic, strong) NSNumber *following;
@property (nonatomic, strong) NSNumber *tweets;
@property (nonatomic, assign) BOOL isAuthenicatedUser;
@end
