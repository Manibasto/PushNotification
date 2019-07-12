//
//  Helper.swift
//  Pushnofify
//
//  Created by Anil Kumar on 11/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UIKit


class NotifyValue {
  private static var privateSharedInstance: NotifyValue?
  static var sharedInstance: NotifyValue {
    if privateSharedInstance == nil {
      privateSharedInstance = NotifyValue()
    }
    return privateSharedInstance!
  }
  
  var value : [notification] = []
  
}



extension UITableView {
  
  enum scrollsTo {
    case top,bottom
  }
  
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = UIColor(red: 0.17, green: 0.51, blue: 0.75, alpha: 1)
    messageLabel.numberOfLines = 0;
    messageLabel.alpha = 0.52
    messageLabel.textAlignment = .center;
    messageLabel.font = UIFont(name: "Montserrat-Medium", size: 29)
    messageLabel.sizeToFit()
    
    self.backgroundView = messageLabel;
    self.separatorStyle = .none;
  }
  
  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
  
  public func reloadData(_ completion: @escaping ()->()) {
    UIView.animate(withDuration: 0, animations: {
      self.reloadData()
    }, completion:{ _ in
      completion()
    })
  }
  
  func scroll(to: scrollsTo, animated: Bool) {
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
      let numberOfSections = self.numberOfSections
      let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
      switch to{
      case .top:
        if numberOfRows > 0 {
          let indexPath = IndexPath(row: 0, section: 0)
          self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
        break
      case .bottom:
        if numberOfRows > 0 {
          let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
          self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
        break
      }
    }
  }
}


class CustomLabel{
  let label  :UILabel
  init(text: String) {
    label = UILabel()
    label.text = text
    label.numberOfLines = 0
    label.textAlignment = .left
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont (name: "MuseoSans-500", size: 16)
    label.sizeToFit()
    label.translatesAutoresizingMaskIntoConstraints = false
  }
  func changeFont(_ font :CGFloat) -> Self{
    label.font = label.font.withSize(font)
    return self
  }
  func changeTextColor(_ customTextColor:UIColor)-> Self{
    label.textColor = customTextColor
    return self
  }
  func changeTextAlignment(_ text:NSTextAlignment)-> Self{
    label.textAlignment = text
    return self
  }
  func hiddenLabel(_ bool:Bool)-> Self{
    label.isHidden = bool
    return self
  }
  func changeNumberOfLines(lines:Int)-> Self {
    label.numberOfLines = lines
    return self
  }
  func changeLineBreakMode(mode:NSLineBreakMode)->Self{
    label.lineBreakMode = mode
    return self
  }
  func addBorderColor() -> Self{
    label.layer.borderWidth = 2.0
    label.layer.cornerRadius = 8
    return self
  }
  func changeBackgroundColor(color:UIColor)-> Self{
    label.backgroundColor = color
    return self
  }
  
  
  func buildUI() -> UILabel{
    return label
  }
  
  
}


final class UIViewFactory{
  
  private let view: UIView
  
  init() {
    view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func borderWith(value:CGFloat)->Self{
    view.layer.borderWidth = value
    return self
  }
  
  func borderColor(color:UIColor)->Self{
    view.layer.borderColor = color.cgColor
    return self
  }
  
  func backgroundColor(color: UIColor)-> Self{
    view.backgroundColor = color
    return self
  }
  func cornerRadious(value: CGFloat)-> Self{
    view.layer.cornerRadius = value
    return self
  }
  func clipToBounds(Bool: Bool)-> Self{
    view.clipsToBounds = Bool
    return self
  }
  func masksToBounds(Bool: Bool)-> Self {
    view.layer.masksToBounds = Bool
    return self
  }
  
  func shadowColor(color: UIColor)-> Self {
    view.layer.shadowColor = color.cgColor
    return self
  }
  
  func shadowOpacity(opaCity : Float)-> Self {
    view.layer.shadowOpacity = opaCity
    return self
  }
  
  func shadowRadious(with: CGFloat)-> Self{
    view.layer.shadowRadius = with
    return self
  }
  func shadowOffset(offSetWith : CGFloat,offSetHeignt: CGFloat)-> Self {
    view.layer.shadowOffset = CGSize(width: offSetWith, height: offSetHeignt)
    return self
  }
  
  func setAlpha(alpha: CGFloat)-> Self{
    view.alpha = alpha
    return self
  }
  
  func build() -> UIView {
    return view
  }
}

