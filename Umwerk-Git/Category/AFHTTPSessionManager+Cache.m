//
//  AFHTTPSessionManager+Cache.m
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import "AFHTTPSessionManager+Cache.h"

@implementation AFHTTPSessionManager (Cache)

- (void)forceCacheResponse:(NSInteger)duration {
  [self setDataTaskWillCacheResponseBlock:^NSCachedURLResponse * _Nonnull(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSCachedURLResponse * _Nonnull proposedResponse) {
    if ([proposedResponse.response isKindOfClass:[NSHTTPURLResponse class]]) {
      NSHTTPURLResponse *resp = (NSHTTPURLResponse*)proposedResponse.response;
      NSMutableDictionary * headers = [[resp allHeaderFields] mutableCopy];

      headers[@"Cache-Control"] = [NSString stringWithFormat:@"max-age=%ld", (long)duration];
      
      NSHTTPURLResponse * modifiedResponse = [[NSHTTPURLResponse alloc] initWithURL:resp.URL statusCode:resp.statusCode HTTPVersion:@"1.1" headerFields:headers];
      
      if (modifiedResponse) {
        NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:modifiedResponse
                                                                                        data:[proposedResponse data]
                                                                                    userInfo:[proposedResponse userInfo]
                                                                               storagePolicy:NSURLCacheStorageAllowed];
        return cachedResponse;
      }
    }
    
    return proposedResponse;
  }];
}

@end
