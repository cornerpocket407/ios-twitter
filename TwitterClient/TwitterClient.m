//
//  TwitterClient.m
//  TwitterClient
//
//  Created by Tony Dao on 3/28/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "TwitterClient.h"
@interface TwitterClient(){

}
@end
@implementation TwitterClient
#pragma public methods
+ (TwitterClient *)instance {
    static TwitterClient *client = nil;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        client = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com"]
                                            consumerKey:@"Zx9HybagRtGyriikuQSrFmdhF"
                                         consumerSecret:@"3IMUstpsCSaDocC5PSqekvzPAiF7pco3xGGe2qPkKwKKGYEciv"];
    });
    return client;
}
- (void)login {
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"POST" callbackURL:[NSURL URLWithString:@"tdaotwitter://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"Got the token!");
        NSString *authURL = [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:authURL]];
    } failure:^(NSError *error) {
        NSLog(@"login failed: %@", error);
    }];
}
- (AFHTTPRequestOperation *) homeTimelineWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure; {
    return [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:success failure:failure];
}
@end
