//
//  UWKUserViewController.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

import KFSwiftImageLoader
import UIKit

class UWKUserViewController: UWKViewController {
  
  @IBOutlet weak var avatarImageView:UIImageView?
  @IBOutlet weak var loginLabel:UILabel?
  @IBOutlet weak var emailButton:UIButton?
  @IBOutlet weak var followersLabel:UILabel?
  @IBOutlet weak var createdAtLabel:UILabel?

  var user:GitHubUser?
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      if user?.image != nil {
        avatarImageView?.image = user?.image
      } else if user?.image == nil && user?.avatar_url != nil {
        avatarImageView?.loadImage(urlString: (user?.avatar_url)!, placeholderImage: UWKImageFactory.placeholder())
      } else {
        
      }
      
      loginLabel?.text = user?.login?.uppercased()
      
      fetchUserDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func fetchUserDetails() {
    if user?.email == nil || user?.followers == nil {
      if user?.login != nil {
        emailButton?.isSelected = false
        emailButton?.setTitle(nil, for: .normal)
        followersLabel?.text = nil
        self.activityIndicatorView?.isHidden = false
        self.activityIndicatorView?.startAnimating()

        GitHubService().searchUser(withLogin: (user?.login)!, completion: {[weak self] (fetchedUser, error) in
          if fetchedUser == self?.user {
            self?.user?.followers = fetchedUser?.followers
            self?.user?.created_at = fetchedUser?.created_at
            self?.user?.email = fetchedUser?.email
            
            self?.setupFields()
          }
        })
      }
    } else {
      setupFields()
    }
  }
  
  func setupFields() {
    DispatchQueue.main.async {
      if self.user?.email != nil {
        self.emailButton?.setTitle(self.user?.email, for: .normal)
        self.emailButton?.isSelected = false
      } else if self.user?.email == nil {
        self.emailButton?.isSelected = true
      }
      
      self.createdAtLabel?.text = self.user?.formattedCreatedAt
      self.followersLabel?.text = self.user?.followers?.stringValue
      self.emailButton?.isHidden = false
      self.activityIndicatorView?.isHidden = true
      self.activityIndicatorView?.stopAnimating()
    }
  }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  //MARK: IBAction
  
  @IBAction func emailButtonPressed(sender:AnyObject) {
    if let email = user?.email {
      if showMailComposer("", recipients: [email], subject: "iOS dev") == false {
        showAlertController("Umwerk", message: "Email is not supported".localized())
      }
    } else {
      guard let emailButton = emailButton else {
        return
      }
      
      if emailButton.isSelected {
        fetchUserDetails()
      } else {
        showAlertController("Umwerk", message: "Email is not defined".localized())
      }
    }
  }

}
