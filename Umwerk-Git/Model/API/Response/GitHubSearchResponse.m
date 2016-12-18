//
//  GitHubSearchResponse.m
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import "GitHubSearchResponse.h"

@implementation GitHubSearchResponse

// Tell our JSON serialization library, that we want serialize items to GitHubUser class

+ (Class)classForCollectionProperty:(NSString *)propertyName {
  if ([propertyName isEqualToString:@"items"]) {
    return [GitHubUser class];
  }
  
  return [super classForCollectionProperty:propertyName];
}

@end
