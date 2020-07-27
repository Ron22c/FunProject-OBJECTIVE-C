//
//  CommunicationViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 15/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "CommunicationViewController.h"

@interface CommunicationViewController ()
{
    UIScrollView *scrollView;
    UITableView *tableView;
    NSArray *elements;
    MFMailComposeViewController *mailComposer;
    MFMessageComposeViewController *messageComposer;
    UILabel *error;
}
@end

@implementation CommunicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [self orientationNortifier];
    [self addScrollView];
    [self addTableView];
    [self addlabel];

    elements = @[@"EMAIL", @"MESSAGE"];
}

- (void)orientationNortifier {
    [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(changeOrientation:)
                                                name:UIDeviceOrientationDidChangeNotification
                                              object:[UIDevice currentDevice]];
}

- (void)changeOrientation:(NSNotification *)notification {
    [self setViewConstrains:scrollView withParentView:self.view];
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, 1000)];
    [tableView setFrame:CGRectMake(0, 0, self.view.bounds.size.width-100, scrollView.contentSize.height/3)];
    [error setFrame:CGRectMake(0, scrollView.contentSize.height/2, self.view.bounds.size.width-100, 100)];
}

- (void)addScrollView {
    scrollView = [[UIScrollView alloc]init];
    [scrollView setBackgroundColor:[UIColor redColor]];
    [self setViewConstrains:scrollView withParentView:self.view];
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width, 1000)];
}

- (void)addTableView {
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width-100, scrollView.contentSize.height/3)];
    [tableView setBackgroundColor:[UIColor grayColor]];
    tableView.delegate=self;
    tableView.dataSource=self;
    [scrollView addSubview:tableView];
}

- (void)addlabel {
    error = [[UILabel alloc]initWithFrame:CGRectMake(0, scrollView.contentSize.height/2, self.view.bounds.size.width-100, 100)];
    [error setBackgroundColor:[UIColor whiteColor]];
    [error setTextColor:[UIColor blackColor]];
    [error setTextAlignment:NSTextAlignmentCenter];
    [error setNumberOfLines:0];
    [scrollView addSubview:error];
}

- (void)setViewConstrains:(UIScrollView *)childView withParentView:(UIView *)parentView {

    [childView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:scrollView];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:childView
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0f
                                                            constant:100];

    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:childView
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.view
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0f
                                                             constant:50];

    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:childView
                                                             attribute:NSLayoutAttributeRight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:1.0f
                                                              constant:-50];

    NSLayoutConstraint *buttom = [NSLayoutConstraint constraintWithItem:childView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0f
                                                               constant:-50];

    [parentView addConstraints:@[top, left, right, buttom]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected %@", elements[indexPath.row]);
    if ([elements[indexPath.row] isEqualToString:@"EMAIL"]) {
        [self showMailComposer];
    } else if ([elements[indexPath.row] isEqualToString:@"MESSAGE"]) {
        [self showMessageComposer];
    } else {
        NSLog(@"INVALID ROW");
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    [cell setBackgroundColor:[UIColor greenColor]];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, tableView.bounds.size.width, 20)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, view.bounds.size.width/2, view.bounds.size.height)];
    label.text = elements[indexPath.row];
    [label setBackgroundColor:[UIColor yellowColor]];
    
    UILabel *labelClick = [[UILabel alloc]initWithFrame:CGRectMake(view.bounds.size.width/2, 0, view.bounds.size.width/2-10, view.bounds.size.height)];
    labelClick.text = @"click here";
    [labelClick setBackgroundColor:[UIColor brownColor]];
    
    [view addSubview:label];
    [view addSubview:labelClick];
    [cell addSubview:view];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return elements.count;
}

- (void)showMailComposer {
    if([MFMailComposeViewController canSendMail]) {
        mailComposer = [[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setSubject:@"TEST EMAIL"];
        [mailComposer setMessageBody:@"This is a test!!Please ignore" isHTML:NO];
        [mailComposer setToRecipients:@[@"rjc22aug@gmial.com"]];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        NSLog(@"Send alert unable to send email/ Please use real device");
        error.text=@"Send alert unable to send email/ Please use real device";
    }
}

- (void)showMessageComposer {
    if([MFMessageComposeViewController canSendText]) {
        messageComposer = [[MFMessageComposeViewController alloc]init];
        messageComposer.messageComposeDelegate=self;
        [messageComposer setSubject:@"TEST MESSAGE"];
        [messageComposer setBody:@"This is a test message!! please ignore"];
        [messageComposer setRecipients:@[@"1234567890"]];
        [self presentViewController:messageComposer animated:YES completion:nil];
    } else {
        NSLog(@"Send alert unable to send message/ Please use real device");
        error.text=@"Send alert unable to send message/ Please use real device";
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(nullable NSError *)error {
    if(!error){
        NSLog(@"mail send successfully with result: %ld", (long)result);
    } else {
        NSLog(@"Error! %@", error);
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"REsulr it %ld", (long)result);
}

@end
