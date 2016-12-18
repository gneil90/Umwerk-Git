//
//  UWKUserListViewController.swift
//  Umwerk-Git
//
//  Created by Yan Saraev on 12/17/16.
//  Copyright © 2016 readore. All rights reserved.
//

import UIKit

class UWKUserListViewController: UWKViewController, UITableViewDelegate, UITableViewDataSource {
  var users = [GitHubUser]()
  
  var imageDownloadsInProgress = [IndexPath:IconDownloader]()

  @IBOutlet weak var refreshButton:UIButton?
  
  let pagingSpinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
  
  var pageNumber = 0
  

  var isLoadingNextPage = false {
    didSet {
      showSpinner(isLoadingNextPage)
    }
  }
  
  @IBOutlet weak var tableView:UITableView?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    tableView?.dataSource = self
    
    loadNextPage()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
    terminateAllDownloads()
  }
  

  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    if segue.identifier == UWKSegue.FromUserList.ToUserDetail {
      if let destination = segue.destination as? UWKUserViewController, let user = sender as? GitHubUser {
        destination.user = user
      }
    }
  }
  
  //MARK: - TableView delegate
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if tableView.contentSize.height < tableView.frame.height {
      loadNextPage()
    } else {
      let yOffset = tableView.contentOffset.y;
      let height = tableView.contentSize.height - tableView.frame.height;
      let scrolledPercentage = yOffset / height;
      
      if scrolledPercentage > 0.6 {
        loadNextPage()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let user = users[indexPath.row]
    performSegue(withIdentifier: UWKSegue.FromUserList.ToUserDetail, sender: user)    
  }
  
  
  //MARK: - UITableView Datasource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    let user = users[indexPath.row]
    
    cell?.imageView?.image = UWKImageFactory.placeholder()
    
    if user.thumbnail != nil {
      cell?.imageView?.image = user.thumbnail
    } else {
      // Only load cached images; defer new downloads until scrolling ends
      
      if tableView.isDragging == false && tableView.isDecelerating == false && user.avatar_url != nil {
        startIconDownload(user, forIndexPath: indexPath)
      }
    }
    
    cell?.textLabel?.text = user.login
    cell?.detailTextLabel?.text = user.created_at
    
    return cell!
  }
  
  func insertNewUsers(newUsers: [GitHubUser]) -> [IndexPath] {
    var indexPaths = [IndexPath]()
    
    for (i, _) in newUsers.enumerated() {
      let indexPath = IndexPath.init(row: i + users.count, section: 0)
      indexPaths.append(indexPath)
    }
    
    users.append(contentsOf: newUsers)
    return indexPaths
  }

  
  //MARK: - Pagination
  
  func loadNextPage() {
    if isLoadingNextPage == true {
      return
    }
    
    self.tableView?.isHidden = false
    self.refreshButton?.isHidden = true
    
    isLoadingNextPage = true
    
    GitHubService().searchUsers(withLanguage: "java", page: (pageNumber + 1)) { [weak self](response, error) in
      guard let `self` = self else {
        return
      }
      DispatchQueue.main.async {
        if let items = response?.items {
          // page loaded successfully, increment last loaded page
          self.pageNumber = self.pageNumber + 1
          UWKAppGroupsManager.shared.saveUsers(users: items)
          self.updateTableView(with: items)
        } else {
          if self.pageNumber == 0 {
            self.tableView?.isHidden = true
            self.refreshButton?.isHidden = false
          }
        }
        self.isLoadingNextPage = false
      }
    }
  }
  
  func updateTableView(with items:[GitHubUser]) {
    self.tableView?.beginUpdates()
    let indexPaths = self.insertNewUsers(newUsers: items)
    self.tableView?.insertRows(at: indexPaths, with: .left)
    self.tableView?.endUpdates()
    
    self.isLoadingNextPage = false
    
    if tableView != nil {
      if tableView!.contentSize.height < tableView!.frame.size.height {
        loadNextPage()
      }
    }
  }
  
  func showSpinner(_ show:Bool) {
    DispatchQueue.main.async {[weak self]() in
      if show {
        self?.pagingSpinner.startAnimating()
        self?.tableView?.tableFooterView = self?.pagingSpinner
      } else {
        self?.pagingSpinner.stopAnimating()
        self?.tableView?.tableFooterView = UIView()
      }
    }
  }
  
  //MARK: - Table cell image support
  
  func startIconDownload(_ user:GitHubUser, forIndexPath indexPath:IndexPath) {
    if imageDownloadsInProgress[indexPath] == nil {
      let iconDownloader = IconDownloader()
      iconDownloader.user = user
      iconDownloader.completionHandler = {[weak self]() in
        let cell = self?.tableView?.cellForRow(at: indexPath)
        
        // Display the newly loaded image
        cell?.imageView?.image = user.thumbnail
        
        // Remove the IconDownloader from the in progress list.
        // This will result in it being deallocated.
        let _ = self?.imageDownloadsInProgress.removeValue(forKey: indexPath)
      }
      
      self.imageDownloadsInProgress[indexPath] = iconDownloader
      iconDownloader.startDownload()
    }
  }
  
  // -------------------------------------------------------------------------------
  //	loadImagesForOnscreenRows
  //  This method is used in case the user scrolled into a set of cells that don't
  //  have their app icons yet.
  // -------------------------------------------------------------------------------

  func loadImagesForOnscreenRows() {
    if self.users.count > 0 {
      if let visiblePaths = self.tableView?.indexPathsForVisibleRows {
        for indexPath in visiblePaths {
          let user = users[indexPath.row]
          if user.image == nil {
            startIconDownload(user, forIndexPath: indexPath)
          }
        }
      }
    }
  }
  
  func terminateAllDownloads() {
    for (_, iconDownloader) in imageDownloadsInProgress.values.enumerated() {
      iconDownloader.cancelDownload()
    }
    
    imageDownloadsInProgress.removeAll()
  }

  //MARK: - UIScrollViewDelegate
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if decelerate == false {
      loadImagesForOnscreenRows()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    loadImagesForOnscreenRows()
    loadNextPage()
  }
  
  //MARK: - IBAction
  
  @IBAction func refreshButtonPressed(sender:UIButton) {
    debugPrint("trying to refresh list...")
    loadNextPage()
  }
  
  deinit {
    terminateAllDownloads()
  }
}
