//
//  ViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "ViewController.h"
#import "WebBrowserViewController.h"
#import "DownloaderViewController.h"
#import "LocationMapViewController.h"
#import "ScrollDataViewController.h"
#import "CommunicationViewController.h"
#import "PokktAdsViewController.h"
#import "ShowWebViewViewController.h"

@interface ViewController ()
{
    UIButton *webBrowser;
    UIButton *downLoader;
    UIButton *locationMap;
    UIButton *ScrollVC;
    UIButton *communication;
    UIButton *pokktAds;
    UIButton *showWebView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self listenNortification];
    [self addButtons];
}

- (void)listenNortification {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:[UIDevice currentDevice]];
}

- (void)orientationChanged:(NSNotification *)notification {
    [webBrowser setFrame:CGRectMake(0, self.view.bounds.size.height/10, self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [downLoader setFrame:CGRectMake(0, 2*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [locationMap setFrame:CGRectMake(0, 3*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [ScrollVC setFrame:CGRectMake(0, 4*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [pokktAds setFrame:CGRectMake(0, 6*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [communication setFrame:CGRectMake(0, 5*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [showWebView setFrame:CGRectMake(0, 7*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)];

}

- (void)addButtons {
    [self.view.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    webBrowser = [UIKitViewProducers getBrowser:@selector(webbrowserAction:)
                                           withController:self
                                                 position:CGRectMake(0, self.view.bounds.size.height/10, self.view.bounds.size.width, self.view.bounds.size.height/10)
                                                     name:@"WebBrowser"];
    
    downLoader = [UIKitViewProducers getBrowser:@selector(downloaderAction:)
                                           withController:self
                                                 position:CGRectMake(0, 2*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)
                                                     name:@"Downloader"];
    
    locationMap = [UIKitViewProducers getBrowser:@selector(locationAction:)
                                           withController:self
                                                 position:CGRectMake(0, 3*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)
                                                     name:@"Location Map"];
    
    ScrollVC = [UIKitViewProducers getBrowser:@selector(scrollVCACtion:)
                                           withController:self
                                                 position:CGRectMake(0, 4*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)
                                                     name:@"ScrollVC"];
    
    communication = [UIKitViewProducers getBrowser:@selector(communicationAction:)
                                    withController:self
                                          position:CGRectMake(0, 5*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)
                                              name:@"Communucation"];
    
    pokktAds = [UIKitViewProducers getBrowser:@selector(pokktAction:)
                               withController:self
                                     position:CGRectMake(0, 6*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)
                                         name:@"POKKT ADS"];
    
    showWebView = [UIKitViewProducers getBrowser:@selector(showWebViewAction:)
                                  withController:self
                                        position:CGRectMake(0, 7*(5+self.view.bounds.size.height/10), self.view.bounds.size.width, self.view.bounds.size.height/10)
                                            name:@"SHOW WEB VIEW"];
    
    [self.view addSubview:webBrowser];
    [self.view addSubview:downLoader];
    [self.view addSubview:locationMap];
    [self.view addSubview:ScrollVC];
    [self.view addSubview:communication];
    [self.view addSubview:pokktAds];
    [self.view addSubview:showWebView];

}

- (void)webbrowserAction:(UIButton *)sender {
    NSLog(@"WebBrowser button");
    WebBrowserViewController *web = [[WebBrowserViewController alloc] init];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)showWebViewAction:(UIButton *)sender {
    NSLog(@"showWebViewAction button");
    ShowWebViewViewController *view = [[ShowWebViewViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)downloaderAction:(UIButton *)sender {
    NSLog(@"Downloader button");
    DownloaderViewController *download = [[DownloaderViewController alloc] init];
    [self presentViewController:download animated:YES completion:nil];
}

- (void)locationAction:(UIButton *)sender {
    NSLog(@"LocationMap button");
    LocationMapViewController *map = [[LocationMapViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}

- (void)scrollVCACtion:(UIButton *)sender {
    NSLog(@"LocationMap button");
    ScrollDataViewController *scrollVC = [[ScrollDataViewController alloc] init];
    [self.navigationController pushViewController:scrollVC animated:YES];
}

- (void)communicationAction:(UIButton *)sender {
    NSLog(@"Communication Button");
    CommunicationViewController *communicationVC = [[CommunicationViewController alloc]init];
    [self.navigationController pushViewController:communicationVC animated:YES];
}

- (void)pokktAction:(UIButton *)sender {
    NSLog(@"PokktAds button");
    PokktAdsViewController *pokktAds = [[PokktAdsViewController alloc]init];
//    [self presentViewController:pokktAds animated:YES completion:nil];
    [self.navigationController pushViewController:pokktAds animated:YES];
}

@end
