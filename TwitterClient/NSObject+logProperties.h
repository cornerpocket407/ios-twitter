//
//  NSObject+logProperties.h
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <Foundation/Foundation.h>
//  This creates a category for logging properties in a class for logging purposes.
//  Found it here: http://stackoverflow.com/questions/13922581/is-there-a-way-to-log-all-the-property-values-of-an-objective-c-instance#answer-13922682

@interface NSObject (logProperties)
- (void) logProperties;
@end
