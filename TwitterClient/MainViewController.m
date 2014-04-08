//
//  MainViewController.m
//  TwitterClient
//
//  Created by Tony Dao on 4/7/14.
//  Copyright (c) 2014 Tony Dao. All rights reserved.
//

#import "MainViewController.h"
#import "HomeTimelineViewController.h"
#import "MenuViewController.h"
#import "UserProfileViewController.h"
#import "TwitterClient.h"

static int const MENU_BEGIN_X = -320;
static int const MENU_END_X = -20;

@interface MainViewController ()
@property (nonatomic, strong) UIViewController *mainVC;
@property (nonatomic, strong) MenuViewController *menuVC;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithUser:(User *)user {
    self = [super init];
    if (self) {
        self.mainVC = [[UserProfileViewController alloc] initWithUser:user];
        self.menuVC = [[MenuViewController alloc] init];
        self.menuVC.menuViewDelegate = self;
        [self addChildViewController:self.mainVC];
        [self addChildViewController:self.menuVC];
    }
    return self;
    
}

- (id)initWithTweetType:(enum TWEETS_TYPE)type {
    self = [super init];
    if (self) {
        self.mainVC = [[HomeTimelineViewController alloc] initWithTweetType:type];
        self.menuVC = [[MenuViewController alloc] init];
        self.menuVC.menuViewDelegate = self;
        [self addChildViewController:self.mainVC];
        [self addChildViewController:self.menuVC];
    }
    return self;
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHomeTimelineNavBar];
    [self didMoveToParentViewController:self.mainVC];
    
    [self.view addSubview:self.mainVC.view];
    UIView *mcv = self.menuVC.view;
    [self.view addSubview:mcv];
    CGRect frame = mcv.frame;
    frame.origin.x = MENU_BEGIN_X;
    self.menuVC.view.frame = frame;
    [self.view bringSubviewToFront:self.mainVC.view];
    UIPanGestureRecognizer *panGesRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self.view addGestureRecognizer:panGesRec];
}

- (void)setupHomeTimelineNavBar {
    UIBarButtonItem *newBtn = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action: @selector(onCompose)];
    newBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = newBtn;
    
    UIBarButtonItem *signOutBtn = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:self action: @selector(onSignOut)];
    signOutBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = signOutBtn;
}

- (void)onCompose {
    ComposeViewController *cc = [[ComposeViewController alloc] initWithTweetToReply:nil];
    cc.delegate = self.mainVC;
    [self.navigationController pushViewController:cc animated:YES];
}

- (void)onSignOut {
    [[TwitterClient instance] signOut];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)setMenuOriginX:(int)x{
    CGRect frame = self.menuVC.view.frame;
    frame.origin.x = x;
    self.menuVC.view.frame = frame;
}

- (void)onPan:(UIPanGestureRecognizer *)panGesRec {
        UIView *mcv = self.menuVC.view;
        CGRect frame = mcv.frame;
    if (panGesRec.state == UIGestureRecognizerStateBegan) {
        [self.view bringSubviewToFront:mcv];
        if (frame.origin.x == MENU_BEGIN_X) {
            [self setMenuOriginX:MENU_BEGIN_X + 10];
        }
    } else if (panGesRec.state == UIGestureRecognizerStateChanged) {
        NSLog(@"state changed origin.x: %f", frame.origin.x);
        CGPoint translation = [panGesRec translationInView:self.view];
        NSLog(@"translation: %f %f", translation.x, translation.y);
        if ((frame.origin.x <= -25 && translation.x > 0) || (frame.origin.x >= -320 && translation.x < 0)) {
            frame.origin.x = frame.origin.x + translation.x;
            mcv.frame = frame;
            [panGesRec setTranslation:CGPointZero inView:self.view];
        }
    } else if (panGesRec.state == UIGestureRecognizerStateEnded) {
        if (frame.origin.x >= MENU_BEGIN_X/2) {
            [self setMenuOriginX:MENU_END_X];
        } else {
            [self setMenuOriginX:MENU_BEGIN_X];
            [self.view bringSubviewToFront:self.mainVC.view];
        }
        NSLog(@"ended!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma MenuViewDelegate
- (void)onMenuClickForType:(enum TWEETS_TYPE)type {
    NSLog(@"menuview delegate received");
    if (type == user) {
        TwitterClient *client = [TwitterClient instance];
        MainViewController *mc = [[MainViewController alloc] initWithUser:client.currentUser];
        [self.navigationController pushViewController:mc animated:YES];
    } else {
        MainViewController *mc = [[MainViewController alloc] initWithTweetType:type];
        [self.navigationController pushViewController:mc animated:YES];
    }
}
@end
