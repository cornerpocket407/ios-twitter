//
//  UserProfileViewController.m
//  TwitterClient
//
//  Created by Tony Dao on 4/8/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "UserProfileViewController.h"
#import "TwitterClient.h"
#import "NSObject+logProperties.h"
#import "TweetTableViewCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileBackgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *tweets;
@end

@implementation UserProfileViewController
static TweetTableViewCell *cellPrototype;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUser:(User *) user {
    self = [super init];
    if (self) {
        self.user = user;
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *tweetCellNib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:tweetCellNib forCellReuseIdentifier:@"TweetTableViewCell"];
    cellPrototype = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    
    [self loadTimeline];
    
    //sets up refresh control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)loadTimeline {
    void (^ success)(AFHTTPRequestOperation *operation, id responseObject) = ^void(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = responseObject;
        [self.tableView reloadData];
        //            [self setupHomeTimelineNavBar];
        [self.profileBackgroundImage setImageWithURL:[NSURL URLWithString:self.user.profileBackgroundImageUrl]];
        [self.profileImage setImageWithURL:[NSURL URLWithString: self.user.profileImageUrl]];
    };
    void (^ failure)(AFHTTPRequestOperation *operation, NSError *error) = ^void(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetched timeline failed: %@", error);
    };
    [[TwitterClient instance] userTimelineForScreenName:self.user.screenName success:success failure:failure];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadTimeline];
    [refreshControl endRefreshing];
}

- (void)setupHomeTimelineNavBar {
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action: @selector(onCompose)];
    newBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = newBtn;
    
    UIBarButtonItem *signOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:self action: @selector(onSignOut)];
    signOutBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = signOutBtn;
}

- (void)onSignOut {
    [[TwitterClient instance] signOut];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)onCompose {
    [self onComposeTo:nil];
}

- (void)onComposeTo:(Tweet *)replyTo {
    ComposeViewController *cc = [[ComposeViewController alloc] initWithTweetToReply:replyTo];
    cc.delegate = self;
    [self.navigationController pushViewController:cc animated:YES];
}

#pragma TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    cell.tweetBarViewDelegate = self;
    cell.profileImageDelegate = self;
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    CGFloat tweetLabelHeight = [self sizeOfLabel:cellPrototype.tweetLabel font:[UIFont systemFontOfSize:10.0] withText:tweet.text].height;
    float spacing = 10;
    float nameLabelHeight = 15;
    float nameTweetHeight = nameLabelHeight + spacing + tweetLabelHeight;
    float vertPadding = 20;
    float imageHeight = 60;
    float tweetBarHeight = 16;
    return vertPadding + MAX(imageHeight, nameTweetHeight +spacing + tweetBarHeight);
}

- (CGSize)sizeOfLabel:(UILabel *)label font:(UIFont *)font withText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context: nil].size;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    TweetController *tc = [[TweetController alloc] initWithTweet:tweet];
    tc.composeFinishDelegate = self;
    [self.navigationController pushViewController:tc animated:YES];
}

#pragma ComposeViewControllerDelegate
- (void)refreshHomeTimeline {
    [self loadTimeline];
}
#pragma TweetBarViewDelegate
- (void)replyTweet:(Tweet *)tweet {
    [self onComposeTo:tweet];
}
#pragma ProfileImageDelegate
- (void)onProfileClick:(User *)user {
    NSLog(@"delegate received");
    UserProfileViewController *pc = [[UserProfileViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:pc animated:YES];
}
@end
