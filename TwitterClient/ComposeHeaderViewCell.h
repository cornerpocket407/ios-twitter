//
//  ComposeHeaderViewCell.h
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

//  TOIMPROVE: This class is not being used right now. Should use/reuse this nib whenever applicable
@interface ComposeHeaderViewCell : UIView
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@end
