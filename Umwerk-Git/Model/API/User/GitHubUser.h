//
//  GitHubUser.h
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@import UIKit;

@interface GitHubUser : JSONModel
@property (strong, nonatomic, nullable) NSNumber <Optional> * id;

@property (strong, nonatomic, nullable) NSString <Optional> * login;
@property (strong, nonatomic, nullable) NSString <Optional> * created_at;
@property (strong, nonatomic, nullable) NSString <Optional> * avatar_url;
@property (strong, nonatomic, nullable) NSString <Optional> * name;
@property (strong, nonatomic, nullable) NSString <Optional> * email;
@property (strong, nonatomic, nullable) NSNumber <Optional> * followers;

@property (strong, nonatomic, nullable, getter=getFormattedCreatedAt) NSString <Ignore> * formattedCreatedAt;

@property (strong, nonatomic, nullable) UIImage <Ignore> * thumbnail;
@property (strong, nonatomic, nullable) UIImage <Ignore> * image;

/**
 * Creates github user from json string.
 *
 * @return github user.
 */
- (instancetype _Nullable)initWithString:(NSString * _Nullable)string;


@end
