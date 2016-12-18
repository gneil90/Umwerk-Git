//
//  GitHubRequest.m
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import "GitHubRequest.h"

NSString * _Nonnull const GitScheme = @"https";
NSString * _Nonnull const GitDomain = @"api.github.com";

NSInteger const GitDefaultItemsPerPage = 10;

// Endpoints

NSString * _Nonnull const GitSearchUsersEndPoint = @"search/users";
NSString * _Nonnull const GitGetUserEndPoint = @"users/%@";

// Auth

NSString * _Nonnull const GitHubClientId = @"ed4b2b43fae991826163";
NSString * _Nonnull const GitHubClientSecret = @"f57ab6b2a49488260d46a0d2a6f91885c5085299";

@implementation GitHubRequest

- (instancetype _Nonnull)initWithEndPoint:(NSString * _Nonnull)endPoint {
  self = [super init];
  
  if (self) {
    self.endPoint = endPoint;
    
    // sign our every request to extend query limits per minute
    
    self.parameters = [[NSMutableDictionary alloc] initWithDictionary:@{@"client_id":GitHubClientId, @"client_secret" : GitHubClientSecret}];
  }
  
  return self;
}


#pragma mark- Read-only properties

- (NSString *)basePath {
  return [NSString stringWithFormat:@"%@://%@", GitScheme, GitDomain];
}

- (NSString *)urlString {
  return [self.basePath stringByAppendingPathComponent:self.endPoint];
}


@end
