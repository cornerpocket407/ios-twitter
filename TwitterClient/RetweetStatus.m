//
//  RetweetStatus.m
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "RetweetStatus.h"

@implementation RetweetStatus
- (instancetype)init
{
    if(self = [super init])
    {
        // There is no need to map all properties, only those which you want to have diffrent names;
        self.propertyMap = @{@"created_at": @"createdAt"};
    }
    return self;
}
@end
