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
#import "User.h"

static int const MENU_BEGIN_X = -320;
static int const MENU_END_X = -20;

@interface MainViewController ()
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) HomeTimelineViewController *hc;
@property (nonatomic, strong) MenuViewController *mc;
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
        self.user = user;
        self.hc = [[HomeTimelineViewController alloc] initWithUser:self.user];
        self.mc = [[MenuViewController alloc] init];
        [self addChildViewController:self.hc];
        [self addChildViewController:self.mc];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHomeTimelineNavBar];
    [self didMoveToParentViewController:self.hc];
    
    [self.view addSubview:self.hc.view];
    UIView *mcv = self.mc.view;
    [self.view addSubview:mcv];
    CGRect frame = mcv.frame;
    frame.origin.x = MENU_BEGIN_X;
    self.mc.view.frame = frame;
    [self.view bringSubviewToFront:self.hc.view];
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

- (void)setMenuOriginX:(int)x{
    CGRect frame = self.mc.view.frame;
    frame.origin.x = x;
    self.mc.view.frame = frame;
}

- (void)onPan:(UIPanGestureRecognizer *)panGesRec {
        UIView *mcv = self.mc.view;
        CGRect frame = mcv.frame;
////    if (self.menuExpanded) {


////    } else {
//        frame.origin.x = -320;
//        self.mc.view.frame = frame;
//        [self.view bringSubviewToFront:self.mc.view];
//        frame.origin.x = -20;
////    }
//    [UIView animateWithDuration:2 animations:^{
//            NSLog(@"pannnn");
//        self.mc.view.frame = frame;
//    } completion:^(BOOL finished) {
//        self.menuExpanded = YES;
//        NSLog(@"complete!");
//    }];
    if (panGesRec.state == UIGestureRecognizerStateBegan) {
                NSLog(@"began!");
        [self.view bringSubviewToFront:mcv];
        if (frame.origin.x == MENU_BEGIN_X) {
            [self setMenuOriginX:MENU_BEGIN_X + 10];
        }
    } else if (panGesRec.state == UIGestureRecognizerStateChanged) {
        NSLog(@"state changed origin.x: %f", frame.origin.x);
        CGPoint translation = [panGesRec translationInView:self.view];
        NSLog(@"translation: %f %f", translation.x, translation.y);
        
        if (frame.origin.x >= 85 && translation.x > 0) {
            
        } else
        
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
            [self.view bringSubviewToFront:self.hc.view];
        }
        NSLog(@"ended!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
