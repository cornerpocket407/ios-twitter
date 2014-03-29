//
//  TwitterClient.h
//  TwitterClient
//
//  Created by Tony Dao on 3/28/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *) instance;
- (void) login;
- (AFHTTPRequestOperation *) homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
