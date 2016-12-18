//
//  GitHubService.h
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GitHubRequest.h"
#import "GitHubSearchResponse.h"

@interface GitHubService : NSObject

/**
 Fetch a list `language` developers.
 
 - Parameter language:   The target language to search.
 - Parameter page: The page number of search. Use it for pagination
 
 - Parameter completion: A completion block with deserialized "GitHubSearchResponse" response.
 */

- (void)searchUsersWithLanguage:(NSString * _Nonnull)language page:(NSInteger)page completion:(void (^ _Nonnull)(GitHubSearchResponse * _Nullable response, NSError * _Nullable error))completion;

/**
 Fetch single user with `login`.
 
 - Parameter login: The target user's login to search.
 
 - Parameter completion: A completion block with deserialized "GitHubUser" response.
 */

- (void)searchUserWithLogin:(NSString * _Nonnull)login completion:(void (^ _Nonnull)(GitHubUser * _Nullable searchResponse, NSError * _Nullable error))completion;

@end
