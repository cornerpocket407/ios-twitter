//
//  MenuViewController.m
//  TwitterClient
//
//  Created by Tony Dao on 4/7/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "MenuViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TwitterClient.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
- (IBAction)onMentionsClick:(id)sender;
- (IBAction)onHomeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    User *currentUser = [[TwitterClient instance] currentUser];
    self.nameLabel.text = currentUser.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", currentUser.screenName];
    [self.profileImage setImageWithURL:[NSURL URLWithString:currentUser.profileImageUrl]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMentionsClick:(id)sender {
    [self.menuViewDelegate onMenuClickForType:mentions];
}

- (IBAction)onHomeClick:(UIButton *)sender {
       [self.menuViewDelegate onMenuClickForType:home];
}
@end
