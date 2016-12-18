//
//  GitHubDateFormatter.h
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/18/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GitHubDateFormatter : NSObject

+ (instancetype _Nonnull)sharedFormatter;

/**
 Converts "yyyy-MM-dd'T'HH:mm:ssZZZ" `date`  string to `format`.
 
 - Parameter date:   The date to conver.
 - Parameter format: The desired format of date
 - Returns: Date string with needed format
 */

- (NSString * _Nullable)convertUTCDate:(NSString * _Nonnull)date toFormat:(NSString * _Nonnull)format;

@end
