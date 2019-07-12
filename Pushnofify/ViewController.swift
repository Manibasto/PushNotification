//
//  ViewController.swift
//  Pushnofify
//
//  Created by Anil Kumar on 11/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let tableview = UITableView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Notification"
    
    view.addSubview(tableview)
    
    
    tableview.register(UITableViewCell.self, forCellReuseIdentifier: "NotificationCell")
    
    tableview.dataSource = self
    
    NSLayoutConstraint(item: tableview, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: tableview, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: tableview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: tableview, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    
  }
}


extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    <#code#>
  }
  
  
}
