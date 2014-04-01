//
//  AppDelegate.m
//  TwitterClient
//
//  Created by Tony Dao on 3/28/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeTimelineViewController.h"
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
        HomeTimelineViewController *hc = [[HomeTimelineViewController alloc] init];
        [self.navController pushViewController:hc animated:NO];
    }
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
                                                          HomeTimelineViewController *hc = [[HomeTimelineViewController alloc] init];
                                                          [self.navController pushViewController:hc animated:YES];
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
