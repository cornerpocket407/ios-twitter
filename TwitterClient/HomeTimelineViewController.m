//
//  HomeTimelineViewController.m
//  TwitterClient
//
//  Created by Tony Dao on 3/29/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "HomeTimelineViewController.h"
#import "TwitterClient.h"
#import "HomeTimelineResult.h"
#import "NSObject+logProperties.h"
#import "TweetTableViewCell.h"
#import "Tweet.h"

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
    self.tableView.rowHeight = 100;
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
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(onFilter)];
    newBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = newBtn;
}

- (void)loadHomeTimeline {
    [self.client homeTimelineWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"hometimeline success! response:%@", responseObject);
        self.tweets = responseObject;
        for (Tweet *result in self.tweets) {
            [result logProperties];
            [result.user logProperties];
        }
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
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = self.tweets[indexPath.row];
    CGFloat tweetLabelHeight = [self sizeOfLabel:cellPrototype.tweetLabel font:[UIFont systemFontOfSize:14.0] withText:tweet.text].height;
    float spacing = 5;
    float nameLabelHeight = 15;
    float nameTweetHeight = nameLabelHeight + spacing + tweetLabelHeight;
    float topPadding = 10;
    float imageHeight = 60;
    float tweetBarHeight = 21;
    return topPadding + MAX(imageHeight, nameTweetHeight) + 10 + tweetBarHeight + spacing;
}
- (CGSize)sizeOfLabel:(UILabel *)label font:(UIFont *)font withText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context: nil].size;
}
@end
