//
//  UWKMobileClient.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

import Foundation
import UIKit

class UWKMobileClient : NSObject {
  
  /**
   * Retrieves a shared instance of this class.
   *
   * @return shared instance.
   */

  static let shared: UWKMobileClient = {
    let instance = UWKMobileClient()
    return instance
  }()
  
  /**
   * Configures third-party services, theme styles, from application delegate with options.
   *
   * @param application instance from application delegate.
   * @param launchOptions from application delegate.
   */
  
  func didFinishLaunching(_ application:UIApplication, withOptions options: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    UIView.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).backgroundColor = UIColor.uwk_backgroundColor()
    UITableView.appearance().backgroundColor = UIColor.uwk_backgroundColor()
    UIBarButtonItem.appearance().tintColor = UIColor.uwk_backgroundColor()
    
    
    return true
  }  
}
