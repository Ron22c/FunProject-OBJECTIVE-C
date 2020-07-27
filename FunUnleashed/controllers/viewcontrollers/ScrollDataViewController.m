//
//  ScrollDataViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 14/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "ScrollDataViewController.h"

@interface ScrollDataViewController ()
{
    UIScrollView *scrollView;
    UIView *view;
    UIView *viewOne;
}
@end

@implementation ScrollDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
    [self listenOrientationNortification];
}

- (void)listenOrientationNortification {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(orientationChanged:)
                                                name:UIDeviceOrientationDidChangeNotification
                                              object:[UIDevice currentDevice]];
}

- (void) orientationChanged:(NSNotification *)note {
    NSLog(@"nortification came");
    [self landscapeViewsResize];
}

- (void)landscapeViewsResize {
    [scrollView setFrame:CGRectMake(0,
                                    self.view.bounds.size.height/8,
                                    self.view.bounds.size.width,
                                    self.view.bounds.size.height/2)];
    [view setFrame:CGRectMake(0, 0, scrollView.bounds.size.width, self.view.bounds.size.height/3)];
    [viewOne setFrame:CGRectMake(0, self.view.bounds.size.height/3, scrollView.bounds.size.width, self.view.bounds.size.height/3)];
}

- (void)createScrollView {
    [self.view setBackgroundColor:[UIColor blueColor]];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                              self.view.bounds.size.height/8,
                                                                              self.view.bounds.size.width,
                                                                              self.view.bounds.size.height/2)];
    [scrollView setBackgroundColor:[UIColor greenColor]];
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:scrollView];
    [self createView];
    [self createViewOne];
}

- (void)createView {
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, self.view.bounds.size.height/3)];
    [view setBackgroundColor:[UIColor redColor]];
    [scrollView addSubview:view];
}

- (void)createViewOne {
    viewOne = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/3, scrollView.bounds.size.width, self.view.bounds.size.height/3)];
    [viewOne setBackgroundColor:[UIColor yellowColor]];
    [scrollView addSubview:viewOne];
}


@end
