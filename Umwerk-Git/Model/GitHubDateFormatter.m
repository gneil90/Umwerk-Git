//
//  GitHubDateFormatter.m
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/18/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import "GitHubDateFormatter.h"

@interface GitHubDateFormatter ()

@property (strong, nonatomic) NSDateFormatter * df;

@end

@implementation GitHubDateFormatter

+ (instancetype)sharedFormatter {
  static GitHubDateFormatter *sharedFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedFormatter = [[self alloc] init];
  });
  return sharedFormatter;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.df = [[NSDateFormatter alloc] init];
    self.df.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
  }
  return self;
}

- (NSString *)convertUTCDate:(NSString *)date toFormat:(NSString *)format {
  [self.df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];

  NSDate * _date = [self.df dateFromString:date];
  if (_date) {
    [self.df setDateFormat:format];
    return [self.df stringFromDate:_date];
  }
  
  return nil;
}
@end
