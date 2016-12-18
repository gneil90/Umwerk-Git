/*
 
 GitHubService.h
 Umwerk-Git
 
 Created by Yan Saraev on 12/17/16.
 Copyright © 2016 readore. All rights reserved.
 
 Abstract:
 Helper object for managing the downloading of a particular app's icon.
  It uses NSURLSession/NSURLSessionDataTask to download the app's icon in the background if it does not
  yet exist and works in conjunction with the RootViewController to manage which apps need their icon.
 */

@class GitHubUser;

@import Foundation;

@interface IconDownloader : NSObject

@property (nonatomic, strong) GitHubUser * user;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
