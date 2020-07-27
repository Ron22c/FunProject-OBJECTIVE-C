//
//  ShowWebViewViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 17/07/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "ShowWebViewViewController.h"

@interface ShowWebViewViewController ()
{
    WKWebView *webView;
}

@end

@implementation ShowWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self makeWebBrowser];
}

- (void)makeWebBrowser {
    WKPreferences *pref = [[WKPreferences alloc] init];
    [pref setJavaScriptEnabled:YES];
    
    WKWebViewConfiguration *con = [[WKWebViewConfiguration alloc] init];
    [con setPreferences:pref];
    
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(10, 2*(self.view.bounds.size.height/7+10),
                                                          self.view.bounds.size.width-20, 800)
                                 configuration:con];
    
    webView.navigationDelegate=self;
    [webView setBackgroundColor:[UIColor whiteColor]];
    
    NSString* dataString = [[NSBundle mainBundle] pathForResource:@"Test"
                                                           ofType:@"html"];
    dataString = [NSString stringWithContentsOfFile:dataString
                                           encoding:NSUTF8StringEncoding
                                              error:NULL];
    //NSString *htmlData = @"<html><head><title>TEST</title><script type=\"text/javascript\">var buttonclicked = function() {console.log(\"clicked\")window.location.href=\"webcal://website.mobi/mymeeting.ics\"}</script></head><body><div><button onclick=\"buttonclicked()\">click here</button></div></body></html>";
    [webView loadHTMLString:dataString baseURL:nil];
    [self.view addSubview: webView];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"executed");

    NSURL* url=navigationAction.request.URL;
    //[NSURL URLWithString:@"https://www.google.com"];
    NSString *stringUrl = url.absoluteString;
    

    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        if ([stringUrl localizedCaseInsensitiveContainsString:@".ics"]) {
            [[UIApplication sharedApplication] openURL:url];
            NSLog(@"action %@", url);
            decisionHandler(WKNavigationActionPolicyCancel);
        } else {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
    } else {
        NSLog(@"not a user click");
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"executed end");
    [webView evaluateJavaScript:@"buttonclicked()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"secoond is : %@", error);
        } else {
            NSLog(@"secoond is : %@", result);
        }
    }];
}

@end
