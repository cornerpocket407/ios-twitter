//
//  HomeTimelineViewController.m
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import "TwitterClient.h"
#import "NSObject+logProperties.h"
#import "TweetTableViewCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HomeTimelineViewController ()
@property (nonatomic, strong) TwitterClient *client;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerBackgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UIView *hamburgerMenuView;
@property (nonatomic, strong) User *user;
@end

@implementation HomeTimelineViewController
static TweetTableViewCell *cellPrototype;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.client = [TwitterClient instance];
    }
    return self;
}

- (id)initWithUser:(User *) user {
    self = [super init];
    if (self) {
        self.user = user;
    }
    return self;
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

- (void)onPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    NSLog(@"on pan");
    UIView *sideMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    sideMenu.backgroundColor = [UIColor redColor];
    [self.view addSubview:sideMenu];
}

- (void)loadTimeline {
    void (^ success)(AFHTTPRequestOperation *operation, id responseObject) = ^void(AFHTTPRequestOperation *operation, id responseObject) {
        self.tweets = responseObject;
        [self.tableView reloadData];
        
//        if (self.user.isAuthenicatedUser) {
            [self setupHomeTimelineNavBar];
//        }
        [self.headerBackgroundImage setImageWithURL:[NSURL URLWithString:self.user.profileBackgroundImageUrl]];
        [self.headerImage setImageWithURL:[NSURL URLWithString: self.user.profileImageUrl]];
//        
//        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
//        [self.view addGestureRecognizer:panGestureRecognizer];
    };
    void (^ failure)(AFHTTPRequestOperation *operation, NSError *error) = ^void(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Fetched timeline failed: %@", error);
    };
    if (self.user) {
        [[TwitterClient instance] userTimelineForScreenName:self.user.screenName success:success failure:failure];
    } else {
        [[TwitterClient instance] homeTimelineWithSuccess:success failure:failure];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadTimeline];
    [refreshControl endRefreshing];
}

- (void)setupHomeTimelineNavBar {
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action: @selector(onCompose)];
    newBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = newBtn;
    
//    UIBarButtonItem *signOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:self action: @selector(onSignOut)];
    UIBarButtonItem *signOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStyleBordered target:self action: @selector(onTest)];

    signOutBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = signOutBtn;
}
- (void)onTest {
    NSLog(@"clickced test");
    UIView *sideMenu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    sideMenu.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:sideMenu];
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = sideMenu.frame;
        CGSize size = sideMenu.frame.size;
        CGSize newSize = CGSizeMake(size.width + 100, size.height);
        frame.size = newSize;
        sideMenu.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];    
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
    HomeTimelineViewController *hc = [[HomeTimelineViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:hc animated:YES];
}
@end
