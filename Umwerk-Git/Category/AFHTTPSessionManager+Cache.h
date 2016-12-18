//
//  AFHTTPSessionManager+Cache.h
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (Cache)

/**
 Overrides response cache policy and forces to store the response for `duration` seconds.
 
 - Parameter duration: Time to store the response on disk in seconds.
 */

- (void)forceCacheResponse:(NSInteger)duration;

@end
