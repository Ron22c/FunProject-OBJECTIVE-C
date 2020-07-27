//
//  PokktAdsViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 16/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "PokktAdsViewController.h"
#import "Constants.h"

@interface PokktAdsViewController ()
{
    UIImageView *backgroundImage;
    UIButton *showVideoAd;
    UIButton *cacheVideoAd;
    UIButton *showBannerAd;
    UIButton *distroyBannerAd;
    UIScrollView *scrollView;
    UIView *nativeAdView;
    UIView *bannerAd;
    BannerDelegate *delegate;
}
typedef void(^hello)(void);
@end

@implementation PokktAdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self orientationObserver];
    [self addButtons];
    delegate = [[BannerDelegate alloc]init];
    
    [PokktAds setPokktConfigWithAppId:APPID securityKey:SECKEY];
    [PokktDebugger setDebug:YES];
    [PokktAds requestNativeAd:SCREENIDVIDEO withDelegate:self];
}

- (void)orientationObserver {
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(observeOrientation:)
                                                name:UIDeviceOrientationDidChangeNotification
                                              object:[UIDevice currentDevice]];
}

- (void)observeOrientation:(NSNotification *)nortification {
    [self addFramesToTheUIElements];
}

- (void)testConcurrency {
    hello hi;
    hi = ^(){
        NSString *hi = APPID;
        NSLog(@"%@",hi);
    };
    dispatch_queue_t queue = dispatch_queue_create("queue", nil);
    dispatch_async(queue, hi);
}

- (void)addFramesToTheUIElements {
    [backgroundImage setFrame:CGRectMake(0, self.view.bounds.size.height/10,
                                         self.view.bounds.size.width,
                                         backgroundImage.bounds.size.height)];

    [showVideoAd setFrame:CGRectMake(0, self.view.bounds.size.height/10,
                                     self.view.bounds.size.width,
                                     self.view.bounds.size.height/12)];
    [showBannerAd setFrame:CGRectMake(0, 3*(5+self.view.bounds.size.height/10),
                                      self.view.bounds.size.width,
                                      self.view.bounds.size.height/12)];
    [cacheVideoAd setFrame:CGRectMake(0, 2*(5+self.view.bounds.size.height/10),
                                      self.view.bounds.size.width,
                                      self.view.bounds.size.height/12)];
    [distroyBannerAd setFrame:CGRectMake(0, 4*(5+self.view.bounds.size.height/10),
                                         self.view.bounds.size.width,
                                         self.view.bounds.size.height/12)];
    [bannerAd setFrame:CGRectMake(10, self.view.bounds.size.height-80,
                                  self.view.bounds.size.width-20, 50)];
    [scrollView setFrame:CGRectMake(0, 5*(5+self.view.bounds.size.height/10),
                                    self.view.bounds.size.width,
                                    self.view.bounds.size.height/3)];
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width,
                                          self.view.bounds.size.height)];
    [nativeAdView setFrame:CGRectMake(2, (self.view.bounds.size.height/2),
                                      scrollView.bounds.size.width-4,
                                      self.view.bounds.size.height/3)];
}

- (void)addButtons {
    backgroundImage= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    showVideoAd = [[UIButton alloc] init];
    [showVideoAd.layer setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5].CGColor];
    [showVideoAd setTitle:@"SHOW VIDEO AD" forState:UIControlStateNormal];
    [showVideoAd addTarget:self action:@selector(showAd:) forControlEvents:UIControlEventTouchUpInside];
    
    cacheVideoAd = [[UIButton alloc] init];
    [cacheVideoAd.layer setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5].CGColor];
    [cacheVideoAd setTitle:@"CACHE VIDEO AD" forState:UIControlStateNormal];
    [cacheVideoAd addTarget:self action:@selector(cacheAd:) forControlEvents:UIControlEventTouchUpInside];
    
    showBannerAd = [[UIButton alloc] init];
    [showBannerAd.layer setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5].CGColor];
    [showBannerAd setTitle:@"SHOW BANNER AD" forState:UIControlStateNormal];
    [showBannerAd addTarget:self action:@selector(showBannerAd:) forControlEvents:UIControlEventTouchUpInside];
    
    distroyBannerAd = [[UIButton alloc] init];
    [distroyBannerAd.layer setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.5].CGColor];
    [distroyBannerAd setTitle:@"DISTROY BANNER AD" forState:UIControlStateNormal];
    [distroyBannerAd addTarget:self action:@selector(distroyBannerAd:) forControlEvents:UIControlEventTouchUpInside];
    
    bannerAd = [[UIView alloc] init];
    [bannerAd setBackgroundColor:[UIColor greenColor]];
    
    scrollView = [[UIScrollView alloc] init];
    [scrollView setBackgroundColor:[UIColor lightGrayColor]];
    
    nativeAdView = [[UIView alloc] init];
    [nativeAdView setBackgroundColor:[UIColor blackColor]];
    
    [self addFramesToTheUIElements];
    
    [self.view addSubview:cacheVideoAd];
    [self.view addSubview:showVideoAd];
    [self.view addSubview:showBannerAd];
    [self.view addSubview:distroyBannerAd];
    [self.view addSubview:scrollView];
    [scrollView addSubview:nativeAdView];
}

- (void)showAd:(UIButton *)sender {
    NSLog(@"show clicked");
    [PokktAds showAd:SCREENIDVIDEO withDelegate:self presentingVC:self];
}

- (void)cacheAd:(UIButton *)sender {
    NSLog(@"cache clicked");
    [PokktAds cacheAd:SCREENIDVIDEO withDelegate:self];
}

- (void)showBannerAd:(UIButton *)sender {
    NSLog(@"show banner clicked");
    [self.view addSubview:bannerAd];
    [PokktAds showAd:SCREENIDBANNER withDelegate:delegate inContainer:bannerAd];
}

- (void)distroyBannerAd:(UIButton *)sender {
    NSLog(@"distroy banner clicked");
    [PokktAds dismissAd:SCREENIDBANNER];
    [bannerAd removeFromSuperview];
}

- (void)adCachingResult:(NSString *)screenId isSuccess:(BOOL)success withReward:(double)reward errorMessage:(NSString *)errorMessage {
    if(success) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"SUCCESS"
                                                                       message:@"ad cached successfully"
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        NSLog(@"FAILED: %@", errorMessage);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"FAILED"
                                                                       message:@"ad cache FAILED"
                                                                preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark Pokkt Delegates:

- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage {
    if(success) {
        [PokktDebugger showToast:@"SUCCESS" viewController:self];
    } else {
        NSString *msg = [NSString stringWithFormat:@"FAILED: %@", errorMessage];
        [PokktDebugger showToast:msg viewController:self];
    }
}

- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted {
    NSLog(@"adClosed");
    [PokktDebugger showToast:@"CLOSED" viewController:self];
    [PokktAds dismissAd:SCREENIDVIDEO];
}

- (void)adClicked:(NSString *)screenId {
    [PokktDebugger showToast:@"CLICKED" viewController:self];
}

- (void)adGratified:(NSString *)screenId withReward:(double)reward {
    [PokktDebugger showToast:@"GRATIFIED" viewController:self];
}

#pragma mark Pokkt native ad delegates:

- (void)adReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd {
    [PokktDebugger showToast:@"LOADED NATIVE AD" viewController:self];
    UIView *nativeAd = [pokktNativeAd getMediaView];
    if(nativeAd) {
        NSLog(@"native ad loaded");
        [nativeAdView addSubview:nativeAd];
    } else {
        NSLog(@"failed to load native ad");
    }
}

- (void)adFailed:(NSString *)screenId error:(NSString *)errorMessage {
    [PokktDebugger showToast:@"UNABLE TO LOAD NATIVE AD" viewController:self];
}

@end

@interface BannerDelegate()
{
    UIViewController *viewController;
}

@end

@implementation BannerDelegate

- (instancetype)initWithViewCOntroller:(UIViewController *)controller {
    self = [super init];
    if (self) {
        viewController = controller;
    }
    return self;
}

- (void)adDisplayResult:(NSString *)screenId isSuccess:(BOOL)success errorMessage:(NSString *)errorMessage {
    if(success) {
        [PokktDebugger showToast:@"SUCCESS" viewController:viewController];
    } else {
        NSString *msg = [NSString stringWithFormat:@"FAILED: %@", errorMessage];
        [PokktDebugger showToast:msg viewController:viewController];
    }
}

- (void)adClosed:(NSString *)screenId adCompleted:(BOOL)adCompleted {
    NSLog(@"adClosed");
    [PokktDebugger showToast:@"CLOSED" viewController:viewController];
}

- (void)adClicked:(NSString *)screenId {
    [PokktDebugger showToast:@"CLICKED" viewController:viewController];
}

- (void)adGratified:(NSString *)screenId withReward:(double)reward {
    [PokktDebugger showToast:@"GRATIFIED" viewController:viewController];
}

- (void)adReady:(NSString *)screenId withNativeAd:(PokktNativeAd *)pokktNativeAd {
    [PokktDebugger showToast:@"LOADED NATIVE AD" viewController:viewController];
}

- (void)adFailed:(NSString *)screenId error:(NSString *)errorMessage {
    [PokktDebugger showToast:@"UNABLE TO LOAD NATIVE AD" viewController:viewController];
}

@end
