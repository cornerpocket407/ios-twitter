//
//  HomeTimelineResult.m
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "HomeTimelineResult.h"

@implementation HomeTimelineResult
- (Class)classForElementsInArrayProperty:(NSString *)propertyName
{
    return [Tweet class];
}

@end
