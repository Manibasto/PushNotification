//
//  ViewController.swift
//  Pushnofify
//
//  Created by Anil Kumar on 11/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  lazy var tableview = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(reloadNotificationArry), name: NSNotification.Name("Test"), object: nil)
    
    
    let barBtnVar = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadNotificationArry))
    navigationItem.setRightBarButton(barBtnVar, animated: true)
    
    self.title = "Notification"
    view.backgroundColor = .white
    
    view.addSubview(tableview)
    tableview.register(TableViewCell.self, forCellReuseIdentifier: "NotificationCell")
    tableview.delegate   = self
    tableview.dataSource = self
    tableview.tableFooterView = UIView()
    setup()
    
  }

  
  func setup(){
    tableview.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint(item: tableview, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: tableview, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: tableview, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    NSLayoutConstraint(item: tableview, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0).isActive = true
  }
  
  @objc func reloadNotificationArry(){
    tableview.reloadData()
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if NotifyValue.sharedInstance.value.isEmpty {
      tableView.setEmptyMessage("No data available")
      return 0
    }else{
      tableView.setEmptyMessage("")
      return NotifyValue.sharedInstance.value.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: TableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? TableViewCell
    cell?.notificationModel = NotifyValue.sharedInstance.value[indexPath.row]        
    return cell!
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.alpha = 0
    UIView.animate(
      withDuration: 0.5,
      delay: 0.05 * Double(indexPath.row),
      animations: {
        cell.alpha = 1
    })
  }
}
