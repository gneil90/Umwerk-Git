//
//  TodayViewController.swift
//  widget
//
//  Created by Yan Saraev on 12/18/16.
//  Copyright © 2016 readore. All rights reserved.
//

import UIKit
import NotificationCenter
import KFSwiftImageLoader

class TodayViewController: UIViewController, NCWidgetProviding {
  
  @IBOutlet weak var notFoundLabel:UILabel?
  @IBOutlet weak var userContentView:UIView?
  
  @IBOutlet weak var avatarImageView:UIImageView?
  @IBOutlet weak var loginLabel:UILabel?
  
  var lastUpdate:Date?
  
  var currentUser:GitHubUser?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view from its nib.
    
    NotificationCenter.default.addObserver(self, selector: #selector(performWidgetUpdate), name: UserDefaults.didChangeNotification, object: nil)
    
    preferredContentSize = CGSize.init(width: 320, height: 50)
    performWidgetUpdate()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    performWidgetUpdate()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    performWidgetUpdate()
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  func performWidgetUpdate() {
    if lastUpdate != nil {
      //update one time per minute
      if Swift.abs(lastUpdate!.timeIntervalSinceNow) < 60 {
        return
      }
    }
    DispatchQueue.main.async {
      if let user = UWKAppGroupsManager.shared.getRandomUser() {
        self.currentUser = user
      }
      
      if self.currentUser != nil {
        self.notFoundLabel?.isHidden = true
        self.userContentView?.isHidden = false
        
        if self.currentUser!.avatar_url != nil {
          self.avatarImageView?.loadImage(urlString: (self.currentUser!.avatar_url)!, placeholderImage: UWKImageFactory.placeholder())
        } else {
          self.avatarImageView?.image = UWKImageFactory.placeholder()
        }
        
        self.loginLabel?.text = self.currentUser?.login
        self.lastUpdate = Date()
      } else {
        self.notFoundLabel?.isHidden = false
        self.userContentView?.isHidden = true
      }
    }
  }
  
  /*
   *  NCWidgetProviding
   */
  public func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Swift.Void) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
    completionHandler(NCUpdateResult.newData)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
