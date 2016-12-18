//
//  GitHubRequest.h
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import <JSONModel/JSONModel.h>

//Auth Constants
extern NSString * _Nonnull const GitHubClientId;
extern NSString * _Nonnull const GitHubClientSecret;

//Paging constants
extern NSInteger const GitDefaultItemsPerPage;

//Endpoints

// @"search/users"
extern NSString * _Nonnull const GitSearchUsersEndPoint;

// @"users/{login}"
extern NSString * _Nonnull const GitGetUserEndPoint;


@interface GitHubRequest : JSONModel
  
@property (nonnull, readonly) NSString * basePath;

@property (strong, nonatomic, nonnull) NSMutableDictionary * parameters;

@property (readonly, nonatomic, nonnull) NSString * urlString;

@property (strong, nonatomic, nonnull) NSString * endPoint;

/**
 Initializes a new request with the provided endpoint.
 
 - Parameters:
 - endPoint: Endpoint of url search
 
 - Returns: `GitHubRequest` instance
 */

- (instancetype _Nonnull)initWithEndPoint:(NSString * _Nonnull)endPoint;

@end
