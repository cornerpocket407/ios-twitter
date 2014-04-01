//
//  ComposeViewController.m
//  TwitterClient
//
//  Created by Tony Dao on 3/30/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "ComposeHeaderViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetView;
@property (nonatomic, strong) TwitterClient *client;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, strong) Tweet *replyTweet;
@end

@implementation ComposeViewController

- (id)initWithTweetToReply:(Tweet *)tweet {
    self = [self initWithNibName:@"ComposeViewController" bundle:nil];
    if (self) {
        self.replyTweet = tweet;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [TwitterClient instance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.replyTweet) {
        self.tweetView.text = [NSString stringWithFormat:@"Compose Tweet here for @%@", self.replyTweet.user.screenName];
    } else {
        self.tweetView.text = @"Compose Tweet here";
    }
    self.tweetView.textColor = [UIColor lightGrayColor];
    self.tweetView.delegate = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];
    if (!name) {
        [self.client getAuthenticatedUser];
    }
    // Create a view
    ComposeHeaderViewCell *view = [[ComposeHeaderViewCell alloc] init];
    self.nameLabel.text = [defaults objectForKey:@"name"];
    self.screenNameLabel.text = [defaults objectForKey:@"screenName"];
    [self.profileImage setImageWithURL:[NSURL URLWithString:[defaults objectForKey:@"profileImageUrl"]]];
    UIBarButtonItem *tweetBtn = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleBordered target:self action:@selector(onTweet)];
    self.navigationItem.rightBarButtonItem = tweetBtn;
}

- (void)onTweet {
    [self.client tweetWith:self.tweetView.text replyTo:self.replyTweet.tweetId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"tweet succeed %@", operation);
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate refreshHomeTimeline];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"tweet failed. error: %@", error);
    }];

}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.replyTweet) {
        self.tweetView.text = [NSString stringWithFormat:@"@%@ ", self.replyTweet.user.screenName];
    } else {
         self.tweetView.text = @"";
    }
    self.tweetView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.tweetView.text.length == 0){
        self.tweetView.textColor = [UIColor lightGrayColor];
        if (self.replyTweet) {
            self.tweetView.text = [NSString stringWithFormat:@"Compose Tweet here for @%@", self.replyTweet.user.screenName];
        } else {
            self.tweetView.text = @"Compose Tweet here";
        }
        [self.tweetView resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
