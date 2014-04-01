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

@interface HomeTimelineViewController ()
@property (nonatomic, strong) TwitterClient *client;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *tweets;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *tweetCellNib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tableView registerNib:tweetCellNib forCellReuseIdentifier:@"TweetTableViewCell"];
    cellPrototype = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    [self loadHomeTimeline];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI {
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action: @selector(onCompose)];
    newBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = newBtn;
    
    UIBarButtonItem *signOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:self action: @selector(onSignOut)];
    signOutBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = signOutBtn;
}

- (void)onSignOUt {
    
}

- (void)onCompose {
    [self onComposeTo:nil];
}

- (void)onComposeTo:(Tweet *)replyTo {
    ComposeViewController *cc = [[ComposeViewController alloc] initWithTweetToReply:replyTo];
    cc.delegate = self;
    [self.navigationController pushViewController:cc animated:YES];
}

- (void)loadHomeTimeline {
    [self.client homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        self.tweets = responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"hometimeline failed! error:%@", error);
    }];
}

#pragma TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (void)onReply {
    NSLog(@"Replyyyyyyy");
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
//    return 400.0f;
}

- (CGSize)sizeOfLabel:(UILabel *)label font:(UIFont *)font withText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context: nil].size;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    TweetController *tc = [[TweetController alloc] initWithTweet:tweet];
    tc.delegate = self;
    [self.navigationController pushViewController:tc animated:YES];
}
#pragma ComposeViewControllerDelegate
- (void)refreshHomeTimeline {
    [self loadHomeTimeline];
}
#pragma TweetTableViewReplyDelegate
- (void)replyTweet:(Tweet *)tweet {
    [self onComposeTo:tweet];
}
@end
