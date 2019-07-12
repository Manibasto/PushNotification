//
//  TableViewCell.swift
//  Pushnofify
//
//  Created by Anil Kumar on 11/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  
  
  var notificationModel:notification? {
    didSet {
      guard let notificationList = notificationModel else {return}
      if let title = notificationList.Titile{
        nameLabel.text = title
      }
      if let message = notificationList.Desc {
        desciptionLabel.text = " \(message) "
      }
//      if let date = notificationList.date {
//        timeLabel.text = " \(NotificationController.shared.timeAgoSinceDate(date, currentDate: Date(), numericDates: true)) "
//      }
    }
  }
  
  

  //MARK: - cardView
  let boxView = UIViewFactory()
    .backgroundColor(color: .white)
    .cornerRadious(value: 2.0).build()
  
  //MARK: - cell title Label
  let nameLabel = CustomLabel(text: "")
    .changeNumberOfLines(lines: 1)
    .buildUI()
  
  //MARK: - cell description Label
  let desciptionLabel = CustomLabel(text: "")
    .changeTextAlignment(.left)
    .changeLineBreakMode(mode: .byWordWrapping)
    .changeTextColor(UIColor.black.withAlphaComponent(0.8))
    .changeFont(12)
    .buildUI()
  
  //MARK: - IDPal Logo
  let logo : UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "idpal")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  //MARK: - Time Label
  let timeLabel = CustomLabel(text: "")
    .changeTextAlignment(.right)
    .changeLineBreakMode(mode: .byWordWrapping)
    .changeTextColor(.lightGray)
    .changeFont(11)
    .buildUI()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = UITableViewCell.SelectionStyle.none
    self.contentView.backgroundColor = UIColor.clear
    boxView.backgroundColor = UIColor.white
    self.contentView.addSubview(boxView)
    boxView.layer.cornerRadius = 2.0;
    boxView.backgroundColor = UIColor.white;
    
    let topConstraint = NSLayoutConstraint(item: boxView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 12)
    self.contentView.addConstraint(topConstraint)
    
    let leftConstraint = NSLayoutConstraint(item: boxView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 12)
    self.contentView.addConstraint(leftConstraint)
    
    
    let rightConstraint = NSLayoutConstraint(item: boxView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -12)
    self.contentView.addConstraint(rightConstraint)
    
    let bottoConstraint = NSLayoutConstraint(item: boxView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -5)
    self.contentView.addConstraint(bottoConstraint)
    
    
    //Here label added to boxView
    boxView.addSubview(nameLabel)
    boxView.addSubview(desciptionLabel)
    boxView.addSubview(logo)
    boxView.addSubview(timeLabel)
    
    ///NameLabel
    let topLabelConstraint = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: timeLabel, attribute: .bottom, multiplier: 1, constant: 3)
    boxView.addConstraint(topLabelConstraint)
    
    let leftLabelConstraint = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: logo, attribute: .right, multiplier: 1, constant: 6)
    boxView.addConstraint(leftLabelConstraint)
    
    let rightLabelConstraint = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: boxView, attribute: .right, multiplier: 1, constant: -12)
    boxView.addConstraint(rightLabelConstraint)
    
    
    // Descritpion
    let topLabelConstraint1 = NSLayoutConstraint(item: desciptionLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 4)
    boxView.addConstraint(topLabelConstraint1)
    
    let leftLabelConstraint2 = NSLayoutConstraint(item: desciptionLabel, attribute: .left, relatedBy: .equal, toItem: logo, attribute: .right, multiplier: 1, constant: 6)
    boxView.addConstraint(leftLabelConstraint2)
    
    
    let rightLabelConstraint3 = NSLayoutConstraint(item: desciptionLabel, attribute: .right, relatedBy: .equal, toItem: boxView, attribute: .right, multiplier: 1, constant: -12)
    boxView.addConstraint(rightLabelConstraint3)
    
    // Golden line which do all the resizing of cell stuff
    let bottomSeparatorCosntraint = NSLayoutConstraint(item: desciptionLabel, attribute: .bottom, relatedBy: .equal, toItem: boxView, attribute: .bottom, multiplier: 1, constant: -12)
    boxView.addConstraint(bottomSeparatorCosntraint)
    
    
    //logo
    let imageConstraint2 = NSLayoutConstraint(item: logo, attribute: .left, relatedBy: .equal, toItem: boxView, attribute: .left, multiplier: 1, constant: 14)
    boxView.addConstraint(imageConstraint2)
    
    
    let imageConstraint3 = NSLayoutConstraint(item: logo, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
    boxView.addConstraint(imageConstraint3)
    
    let imageConstraint4 = NSLayoutConstraint(item: logo, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
    boxView.addConstraint(imageConstraint4)
    
    let imageConstraint5 = NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: boxView, attribute: .centerY, multiplier: 1, constant: 0)
    boxView.addConstraint(imageConstraint5)
    
    //timeLabelConstraint1
    timeLabel.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 3).isActive = true
    timeLabel.rightAnchor.constraint(equalTo: boxView.rightAnchor, constant: -6).isActive = true
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
//    boxView.layer.shadowColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 0.50).cgColor
//    boxView.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1)
//    boxView.layer.borderWidth = 1.0
//    boxView.layer.borderColor = UIColor.lightGray.cgColor
//    boxView.alpha = 1
    
    
    boxView.layer.shadowOffset = CGSize(width: 10, height: 10)
    boxView.layer.shadowRadius = 5.0
    boxView.layer.shadowOpacity = 0.6    
    boxView.layer.masksToBounds = false
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

}
