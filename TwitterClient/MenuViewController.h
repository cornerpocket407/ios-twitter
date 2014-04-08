//
//  MenuViewController.h
//  TwitterClient
//
//  Created by Tony Dao on 4/7/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TweetsType.h"

@protocol MenuViewDelegate <NSObject>
- (void)onMenuClickForType:(enum TWEETS_TYPE)type;
@end
@interface MenuViewController : UIViewController
@property (nonatomic, strong) id<MenuViewDelegate> menuViewDelegate;
@end
