//
//  UWKAppGroupsManager.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/18/16.
//  Copyright © 2016 readore. All rights reserved.
//

import UIKit

struct UWKAppGroup {
  static let `id` = "group.umwerk.widgetSharingDefaults"
}

class UWKAppGroupsManager: NSObject {
  
  let defaults = UserDefaults.init(suiteName: UWKAppGroup.id)
  
  /**
   * Retrieves a shared instance of this class.
   *
   * @return shared instance.
   */
  
  static let shared: UWKAppGroupsManager = {
    let instance = UWKAppGroupsManager()
    return instance
  }()
  
  func saveUsers(users:[GitHubUser]) {
    DispatchQueue.global().async {
      for user in users {
        if user.id != nil {
          self.defaults?.set(user.toJSONString(), forKey: user.id!.stringValue)
        }
      }
      self.defaults?.synchronize()
    }
  }
  
  func getRandomUser() -> GitHubUser? {
    if let dict = self.defaults?.dictionaryRepresentation() {
      if let randomItem = (dict as NSDictionary).allKeys.randomItem as? String {
        if let jsonString = (dict as NSDictionary).value(forKey: randomItem) as? String {
          return GitHubUser.init(string: jsonString)
        }
      }
    }
    
    return nil
  }
}
