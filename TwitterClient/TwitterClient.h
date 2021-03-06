//
//  TwitterClient.h
//  TwitterClient
//
//  Created by Tony Dao on 3/28/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *) instance;
@property (nonatomic, strong) User *currentUser;
- (void) login;
- (void) signOut;
- (BOOL) isAuthorized;
- (AFHTTPRequestOperation *) getAuthenticatedUserWithSuccess:(void (^)(User *))success;
- (AFHTTPRequestOperation *) homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *) mentionsWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *) tweetWith:(NSString *)text success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *) tweetWith:(NSString *)text replyTo:(NSNumber *)tweetId success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
- (AFHTTPRequestOperation *) favorites:(NSNumber *)tweetId success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success ;
- (AFHTTPRequestOperation *) unFavorites:(NSNumber *)tweetId success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success ;
- (AFHTTPRequestOperation *) userTimelineForScreenName:(NSString *)screenName success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
