//
//  GitHubSearchResponse.h
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "GitHubUser.h"

@interface GitHubSearchResponse : JSONModel

@property (strong, nonatomic, nullable) NSArray <GitHubUser *> <Optional> * items;

@end
