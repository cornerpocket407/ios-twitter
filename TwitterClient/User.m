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
- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.name = [decoder decodeObjectForKey:@"name"];
    self.screenName = [decoder decodeObjectForKey:@"screenName"];
    self.profileImageUrl = [decoder decodeObjectForKey:@"profileImageUrl"];
    self.profileBackgroundImageUrl = [decoder decodeObjectForKey:@"profileBackgroundImageUrl"];
    self.isAuthenicatedUser = [decoder decodeBoolForKey:@"isAuthenicatedUser"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.screenName forKey:@"screenName"];
    [encoder encodeObject:self.profileImageUrl forKey:@"profileImageUrl"];
    [encoder encodeObject:self.profileBackgroundImageUrl forKey:@"profileBackgroundImageUrl"];
    [encoder encodeBool:self.isAuthenicatedUser forKey:@"isAuthenicatedUser"];
}
@end
