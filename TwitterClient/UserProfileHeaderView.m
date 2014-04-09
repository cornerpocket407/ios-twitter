//
//  UserProfileHeaderView.m
//  TwitterClient
//
//  Created by Tony Dao on 4/9/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "UserProfileHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserProfileHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@end
@implementation UserProfileHeaderView
- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSBundle mainBundle] loadNibNamed:@"UserProfileHeader" owner:self options:nil];
    [self addSubview:self.view];
}

- (void)setUser:(User *)user {
    _user = user;
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    [self.profileBackgroundImage setImageWithURL:[NSURL URLWithString:user.profileBackgroundImageUrl]];
    [self.profileImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    [self addNum:user.followers text:@"Followers" toLabel:self.followersLabel];
    [self addNum:user.tweets text:@"Tweets" toLabel:self.tweetsLabel];
    [self addNum:user.following text:@"Following" toLabel:self.followingLabel];
}

- (void)addNum:(NSNumber *)num text:(NSString *)text toLabel:(UILabel *)label {
    NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n",num ? num: [NSNumber numberWithInt:0]]];
    NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString: text];
    [vAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:(NSMakeRange(0, text.length))];
    [aAttrString appendAttributedString:vAttrString];
    label.attributedText = aAttrString;
}
@end
