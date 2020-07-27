//
//  WebBrowserViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "WebBrowserViewController.h"

@interface WebBrowserViewController ()
{
    WKWebView *webView;
    UITextField *url;
}
@end

@implementation WebBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addControlButtons];
    [self addAddressBar];
    [self addBrowserView];
}

- (void)addBrowserView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self makeWebBrowser];
}

- (void)addAddressBar {
    url = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                        (self.view.bounds.size.height/7 + self.view.bounds.size.height/10),
                                                        self.view.bounds.size.width,
                                                        self.view.bounds.size.height/10)];
    [url setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:url];
}

- (void)addControlButtons {
    UIButton *forward = [[UIButton alloc]initWithFrame:CGRectMake(0,
                                                                  self.view.bounds.size.height/7,
                                                                  self.view.bounds.size.width/5,
                                                                  self.view.bounds.size.height/10)];
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/5,
                                                               self.view.bounds.size.height/7,
                                                               self.view.bounds.size.width/5,
                                                               self.view.bounds.size.height/10)];
    UIButton *refresh = [[UIButton alloc]initWithFrame:CGRectMake(2*(self.view.bounds.size.width/5),
                                                                  self.view.bounds.size.height/7,
                                                                  self.view.bounds.size.width/5,
                                                                  self.view.bounds.size.height/10)];
    UIButton *stop = [[UIButton alloc]initWithFrame:CGRectMake(3*(self.view.bounds.size.width/5),
                                                               self.view.bounds.size.height/7,
                                                               self.view.bounds.size.width/5,
                                                               self.view.bounds.size.height/10)];
    UIButton *go = [[UIButton alloc]initWithFrame:CGRectMake(4*(self.view.bounds.size.width/5),
                                                             self.view.bounds.size.height/7,
                                                             self.view.bounds.size.width/5,
                                                             self.view.bounds.size.height/10)];
    
    [forward setTitle:@"Forward" forState:UIControlStateNormal];
    [back setTitle:@"BACK" forState:UIControlStateNormal];
    [refresh setTitle:@"REFRESH" forState:UIControlStateNormal];
    [stop setTitle:@"STOP" forState:UIControlStateNormal];
    [go setTitle:@"GO" forState:UIControlStateNormal];
    
    [forward setBackgroundColor:[UIColor grayColor]];
    [back setBackgroundColor:[UIColor grayColor]];
    [refresh setBackgroundColor:[UIColor grayColor]];
    [stop setBackgroundColor:[UIColor grayColor]];
    [go setBackgroundColor:[UIColor grayColor]];
    
    [forward addTarget:self action:@selector(forwardAction:) forControlEvents:UIControlEventTouchUpInside];
    [back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [refresh addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    [stop addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
    [go addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:forward];
    [self.view addSubview:back];
    [self.view addSubview:refresh];
    [self.view addSubview:stop];
    [self.view addSubview:go];
}

- (void)makeWebBrowser {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 2*(self.view.bounds.size.height/7+10), self.view.bounds.size.width-20, 800) configuration:config];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]]];
    [self.view addSubview: webView];
}

- (void)forwardAction:(UIButton *)sender {
    [webView goForward];
}

- (void)backAction:(UIButton *)sender {
    [webView goBack];
}

- (void)refreshAction:(UIButton *)sender {
    [webView reload];
}

- (void)stopAction:(UIButton *)sender {
    [webView stopLoading];
}

- (void)goAction:(UIButton *)sender {
    NSLog(@"CLICKED, URL IS: %@", url.text);
    if(![url.text isEqualToString:@""]) {
        if([url.text containsString:@"https://"]){
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url.text]]];
        } else {
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[@"https://" stringByAppendingString:url.text]]]];
        }
    } else {
        NSLog(@"no url present");
    }
}

@end
