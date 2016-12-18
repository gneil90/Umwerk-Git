//
//  String+UWKMethod.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/18/16.
//  Copyright © 2016 readore. All rights reserved.
//

import Foundation

extension String {
  func localized() -> String {
    return NSLocalizedString(self, comment: "")
  }
}
