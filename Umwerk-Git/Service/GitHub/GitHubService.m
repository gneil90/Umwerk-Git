//
//  GitHubService.m
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import "GitHubService.h"
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionManager+Cache.h"


@implementation GitHubService

- (void)executeRequest:(GitHubRequest * _Nonnull)request completion:(void (^ _Nonnull)(id _Nullable response, NSError * _Nullable error))completion {
  AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
  
  //uncomment if you want to
  //cache response for 300 seconds
  //[manager forceCacheResponse:300];
  
  [manager GET:request.urlString parameters:request.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    completion(responseObject, nil);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    completion(nil, error);
  }];
}

#pragma mark- User Search

- (void)searchUserWithLogin:(NSString * _Nonnull)login completion:(void (^ _Nonnull)(GitHubUser * _Nullable searchResponse, NSError * _Nullable error))completion {
  GitHubRequest * request = [[GitHubRequest alloc] initWithEndPoint:[NSString stringWithFormat: GitGetUserEndPoint, login]];
  
  [self executeRequest:request completion:^(id  _Nullable response, NSError * _Nullable error) {
    if (response && !error) {
      NSError * serializationError;
      GitHubUser * user = [[GitHubUser alloc] initWithDictionary:response error:&serializationError];
      completion(user, error);
    } else {
      completion(nil, error);
    }
  }];
}

- (void)searchUsersWithLanguage:(NSString * _Nonnull)language page:(NSInteger)page completion:(void (^ _Nonnull)(GitHubSearchResponse * _Nullable searchResponse, NSError * _Nullable error))completion {
  GitHubRequest * request = [[GitHubRequest alloc] initWithEndPoint:GitSearchUsersEndPoint];
    
  request.parameters[@"q"] = [NSString stringWithFormat:@"language:%@", language];
  request.parameters[@"page"] = @(page);
  request.parameters[@"per_page"] = @(GitDefaultItemsPerPage);
  
  [self executeRequest:request completion:^(id response, NSError * error) {
    if (response && !error) {
      NSError * serializationError;
      GitHubSearchResponse * searchResponse = [[GitHubSearchResponse alloc] initWithDictionary:response error:&serializationError];
      completion(searchResponse, error);
    } else {
      completion(nil, error);
    }
  }];
}


@end
