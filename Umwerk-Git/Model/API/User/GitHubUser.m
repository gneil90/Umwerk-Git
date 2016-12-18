//
//  GitHubUser.m
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import "GitHubUser.h"
#import "GitHubDateFormatter.h"

@implementation GitHubUser

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[GitHubUser class]]) {
    return NO;
  }
  
  GitHubUser * otherUser = (GitHubUser *)object;
  return [self.id isEqual:otherUser.id];
}

#pragma mark- Custom initializers

- (instancetype _Nullable)initWithString:(NSString * _Nullable)string {
  if (string) {
    return [super initWithString:string error:nil];
  }
  
  return nil;
}

#pragma mark- Getters

- (NSString *)getFormattedCreatedAt {
  if (_formattedCreatedAt == nil && _created_at != nil) {
    _formattedCreatedAt = [[GitHubDateFormatter sharedFormatter] convertUTCDate:_created_at toFormat:@"yyyy-MM-dd"];
  }
  
  return  _formattedCreatedAt;
}

@end
