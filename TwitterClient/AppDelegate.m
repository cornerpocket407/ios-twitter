//
//  AppDelegate.m
//  TwitterClient
//
//  Created by Tony Dao on 3/28/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeTimelineViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "TwitterClient.h"

@implementation NSURL (dictionaryFromQueryString)
-(NSDictionary *) dictionaryFromQueryString{
    
    NSString *query = [self query];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}
@end
@interface AppDelegate()
@property (nonatomic, strong) UINavigationController *navController;
@property (strong, nonatomic) TwitterClient *client;
@end
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TwitterClient *client = [TwitterClient instance];
    LoginViewController *lc = [[LoginViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:lc];
    self.navController.navigationBar.barTintColor = [UIColor colorWithRed:0.46f green:0.71f blue:0.90f alpha:1];
    if ([client isAuthorized]) {
//        HomeTimelineViewController *hc = [[HomeTimelineViewController alloc] initWithUser:client.currentUser];
//        [self.navController pushViewController:hc animated:NO];
        MainViewController *mc = [[MainViewController alloc] initWithUser:client.currentUser];
        [self.navController pushViewController:mc animated:NO];
    }
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"tdaotwitter"])
    {
        if ([url.host isEqualToString:@"oauth"])
        {
            NSDictionary *parameters = [url dictionaryFromQueryString];
            if (parameters[@"oauth_token"] && parameters[@"oauth_verifier"]) {
                TwitterClient *client = [TwitterClient instance];
                [client fetchAccessTokenWithPath:@"/oauth/access_token"
                                                       method:@"POST"
                                                 requestToken:[BDBOAuthToken tokenWithQueryString:url.query]
                                                      success:^(BDBOAuthToken *accessToken) {
                                                          NSLog(@"access token");
                                                          [client.requestSerializer saveAccessToken:accessToken];
                                                          //First get current authenticated user then fetch hometimeline
                                                          [client getAuthenticatedUserWithSuccess:^void(User *user){
                                                              HomeTimelineViewController *hc = [[HomeTimelineViewController alloc] initWithUser:user];
                                                              [self.navController pushViewController:hc animated:YES];
//
//                                                              
//                                                              MainViewController *mc = [[MainViewController alloc] initWithUser:user];
//                                                              [self.navController pushViewController:mc animated:YES];
                                                          }];
                                                        } failure:^(NSError *error) {
                                                          NSLog(@"Error with access_token");
                                                      }];
            }
        }
        return YES;
    }
    return NO;
        
}

@end
