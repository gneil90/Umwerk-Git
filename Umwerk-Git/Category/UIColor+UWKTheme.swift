//
//  UIColor+UWKTheme.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
  class func uwk_backgroundColor() -> UIColor {
// we have custom preprocessor flag defined only for Git-Blue target
#if UWK_BLUE
  return UIColor.uwk_darkBlue()
#else
  return UIColor.black
#endif
  }
  
  class func uwk_darkBlue() -> UIColor {
    return rgb(2, g:34, b:63)
  }

  class func rgb(_ r:Int, g:Int, b:Int) -> UIColor {
    return rgb(r, g: g, b: b, a: 1)
  }
  
  class func rgb(_ r:Int, g:Int, b:Int, a:CGFloat) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
  }
}
