//
//  ViewController.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/16/16.
//  Copyright © 2016 readore. All rights reserved.
//

import UIKit
import MessageUI

struct UWKSegue {
  struct FromUserList {
    static let ToUserDetail = "UWKSegueFromListToUser"
  }
}


class UWKViewController: UIViewController, MFMailComposeViewControllerDelegate {
  @IBOutlet weak var activityIndicatorView:UIActivityIndicatorView?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    view.backgroundColor = UIColor.uwk_backgroundColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func dismissPressed(sender:AnyObject) {
    dismiss(animated: true) { 
      
    }
  }
  
  //MARK: - MFMailComposeViewControllerDelegate

  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    dismiss(animated: true, completion: nil)
  }

}

