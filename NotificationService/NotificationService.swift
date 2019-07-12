//
//  NotificationService.swift
//  NotificationService
//
//  Created by Anil Kumar on 11/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

  var contentHandler: ((UNNotificationContent) -> Void)?
  var bestAttemptContent: UNMutableNotificationContent?
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    self.contentHandler = contentHandler
    bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
    
    print("Manikandan")
    
    guard let bestAttemptContent = bestAttemptContent else {
      return
    }
    
    UserDefaults(suiteName: "group.new.one")?.set("Mani", forKey: "Test")
    print(request.content.userInfo)
    
    
    if let userInfo = request.content.userInfo as? [String : AnyHashable]{
      if let aps = userInfo["aps"]  as? [String: Any] {
        if let message = aps["alert"] as? [String: Any] {
          let messageDesc = message["body"] as? String ?? "Welcome to PushNotify."
          let title = message["title"] as? String ?? "ID-Pal"
          if let _ = userInfo["gcm.message_id"] as? String{
            print("---------> 👏 PayLoad 👏 --> 😍 \(aps)")
            NotifyValue.sharedInstance.value.append(notification(Titile: title, Desc: messageDesc))
            
            let keychainAccessGroupName = "H2C4R2VE3A.Com.Project.Pushnofify.NotificationService"
            let noti = NotifyValue.sharedInstance.value
            let keychain = KeychainWrapper(serviceName: "Basto", accessGroup: keychainAccessGroupName)
            let p = keychain.set(try! PropertyListEncoder().encode(noti), forKey: "Test")
            print(p)
          }
        }
      }
    }
    
    guard let attachmentUrlString = request.content.userInfo["attachment"] as? String else {
      return
    }
    
    guard let url = URL(string: attachmentUrlString) else {
      return
    }
    
    URLSession.shared.downloadTask(with: url, completionHandler: { (optLocation: URL?, optResponse: URLResponse?, error: Error?) -> Void in
      if error != nil {
        print("Download file error: \(String(describing: error))")
        return
      }
      guard let location = optLocation else {
        return
      }
      guard let response = optResponse else {
        return
      }
      
      do {
        let lastPathComponent = response.url?.lastPathComponent ?? ""
        var attachmentID = UUID.init().uuidString + lastPathComponent
        
        if response.suggestedFilename != nil {
          attachmentID = UUID.init().uuidString + response.suggestedFilename!
        }
        
        let tempDict = NSTemporaryDirectory()
        let tempFilePath = tempDict + attachmentID
        
        try FileManager.default.moveItem(atPath: location.path, toPath: tempFilePath)
        let attachment = try UNNotificationAttachment.init(identifier: attachmentID, url: URL.init(fileURLWithPath: tempFilePath))
        
        bestAttemptContent.attachments.append(attachment)
      }
      catch {
        print("Download file error: \(String(describing: error))")
      }
      
      OperationQueue.main.addOperation({() -> Void in
        print("Manikandan")
        self.contentHandler?(bestAttemptContent);
      })
    }).resume()
  }
  
  override func serviceExtensionTimeWillExpire() {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
      contentHandler(bestAttemptContent)
    }
  }
  
  /*
  func CallApi(MessageId: String){
    print(MessageId)
    //  let parameters = ["message_id": MessageId] as [String : String]
    
    let urlString = URL(string: "https://projects.dev-client.id-pal.com/2.3.0/api/updatePushNotificationDeliveryStatus")!
    var request = URLRequest(url: urlString)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let postString = "message_id=\(MessageId)"
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {                                                 // check for fundamental networking error
        print("error=\(error)")
        return
      }
      
      if let httpStatus = response as? HTTPURLResponse {           // check for http errors
        print("response = \(response)")
      }
      let responseString = String(data: data, encoding: .utf8)
      print("responseString = \(responseString)")
    }
    task.resume()
  }
  */
  
}
