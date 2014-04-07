//
//  User.m
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "User.h"

@implementation User
- (instancetype)init
{
    if(self = [super init])
    {
        self.propertyMap = @{@"screen_name": @"screenName",
                             @"profile_image_url": @"profileImageUrl",
                             @"profile_background_image_url": @"profileBackgroundImageUrl",
                             @"name":  @"name"};
    }
    return self;
}
@end
