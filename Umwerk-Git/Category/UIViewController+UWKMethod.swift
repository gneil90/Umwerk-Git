//
//  UIViewController+UWKMethod.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/18/16.
//  Copyright © 2016 readore. All rights reserved.
//

import Foundation
import MessageUI

extension UWKViewController {
  func showMailComposer(_ body:String, recipients:[String], subject:String) -> Bool {
    if MFMailComposeViewController.canSendMail() {
      let composer = MFMailComposeViewController()
      composer.navigationBar.tintColor = UIColor.white
      composer.setSubject(subject)
      composer.setMessageBody(body, isHTML: false)
      composer.setToRecipients(recipients)
      composer.mailComposeDelegate = self
      
      present(composer, animated: true, completion: nil)
      return true
    } else {
      return false
    }
  }
}

extension UIViewController {
  func showAlertController(_ title:String?, message:String?) {
    DispatchQueue.main.async(execute: {
      if self.presentedViewController == nil {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let actionItem = UIAlertAction.init(title: "Ok".localized(), style: .default, handler: nil)
        alertController.addAction(actionItem)
        self.present(alertController, animated: true, completion: nil)
      }
    })
  }
}
