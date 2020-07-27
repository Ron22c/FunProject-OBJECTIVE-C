//
//  DownloaderViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "DownloaderViewController.h"

@interface DownloaderViewController ()
{
    UITextField *url;
    UILabel *progress;
    UIProgressView *progressBar;
    UIButton *download;
}

@end

@implementation DownloaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
}

- (void) viewDidLayoutSubviews {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addDownloadButton];
    [self addDownloadProgressBar];
    [self addDownloadProgressStatus];
    [self addDownloadUrlField];
}

- (void)addDownloadUrlField {
    url = [[UITextField alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/7, self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [url setTextAlignment:NSTextAlignmentCenter];
    [url setBackgroundColor:[UIColor whiteColor]];
    [url setTextColor:[UIColor blackColor]];
    [self.view addSubview:url];
}

- (void)addDownloadButton {
    NSLog(@"Total Height %f", self.view.bounds.size.height);
    download = [[UIButton alloc]initWithFrame:CGRectMake(0, 2*(self.view.bounds.size.height/7+10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [download setBackgroundColor:[UIColor blackColor]];
    [download setTitle:@"Forward" forState:UIControlStateNormal];
    [download addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:download];
}

- (void)addDownloadProgressBar {
    progressBar = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 3*(self.view.bounds.size.height/7+10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [progressBar setProgress:1];
    [self.view addSubview:progressBar];
}

- (void)addDownloadProgressStatus {
    progress = [[UILabel alloc]initWithFrame:CGRectMake(0, 4*(self.view.bounds.size.height/7+10), self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [progress setTextAlignment:NSTextAlignmentCenter];
    [progress setText:@"**--ProgressStatus--**"];
    [self.view addSubview:progress];
}

- (void)downloadAction:(UIButton *)sender {
    NSURLSessionConfiguration *config = NSURLSessionConfiguration.defaultSessionConfiguration;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    url.text = @"https://d2h452d9fuy6ob.cloudfront.net/1586245293.mp4";
    NSURL *requestUrl = [NSURL URLWithString:url.text];
    NSURLSessionTask *downloadTask = [session downloadTaskWithURL:requestUrl];
    [downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSURL *url = [NSURL URLWithString:[path stringByAppendingPathComponent:@"video.mp4"]];
    NSFileManager *manager = NSFileManager.defaultManager;
    if([manager fileExistsAtPath:path]) {
        [manager replaceItemAtURL:url withItemAtURL:location backupItemName:nil
                          options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:nil];
    }
    UISaveVideoAtPathToSavedPhotosAlbum([url path], nil, nil, nil);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                           didWriteData:(int64_t)bytesWritten
                                      totalBytesWritten:(int64_t)totalBytesWritten
                              totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    [progress setText:[NSString stringWithFormat:@" %lld / %lld ", totalBytesWritten, totalBytesExpectedToWrite]];
    [progressBar setProgress:(totalBytesWritten/totalBytesExpectedToWrite)];
}

@end
