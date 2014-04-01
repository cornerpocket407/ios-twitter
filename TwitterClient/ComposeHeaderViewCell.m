//
//  ComposeHeaderViewCell.m
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "ComposeHeaderViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

//TOIMPROVE: This class is not being used right now. Should use/reuse this nib whenever applicable
@interface ComposeHeaderViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end
@implementation ComposeHeaderViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setUser:(User *)user {
    self.nameLabel.text = self.name;
    self.screenNameLabel.text = self.screenName;
    [self.profileImage setImageWithURL:[NSURL URLWithString:self.profileImageUrl]];
}
@end
