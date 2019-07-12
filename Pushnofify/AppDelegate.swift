//
//  AppDelegate.swift
//  Pushnofify
//
//  Created by Mani Kumar on 28/11/18.
//  Copyright © 2018 AIT. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
  var appIsStarting = Bool()
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: ViewController())
    window?.makeKeyAndVisible()
    
    let keychainAccessGroupName = "H2C4R2VE3A.Com.Project.Pushnofify.NotificationService"
    let keychain = KeychainWrapper(serviceName: "Basto", accessGroup: keychainAccessGroupName)

//    let keyValue = keychain.string(forKey: "Test")
//
//
//    print("The super secret value is: \(keyValue)")
    
    
    
    if let data = keychain.data(forKey:"Test") {
      if let songs2 = try? PropertyListDecoder().decode([notification].self, from: data) {
        print(songs2)
        NotifyValue.sharedInstance.value = songs2
      }
    }
    
    
    
    
    let keychainQuery: [NSString: NSObject] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrAccount: "loginString" as NSObject,
      kSecAttrService: "Com.Project.Pushnofify.NotificationService" as NSObject,
      kSecReturnData: kCFBooleanTrue,
      kSecMatchLimit: kSecMatchLimitOne]
    var rawResult: AnyObject?
    let keychain_get_status: OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &rawResult)
    
    if (keychain_get_status == errSecSuccess) {
      if let retrievedData = rawResult as? Data,
        let password = String(data: retrievedData, encoding: String.Encoding.utf8) {
        // "password" contains the password string now
        print(password)
      }
    }
    
    
    FirebaseApp.configure()
    
    Messaging.messaging().delegate = self
    application.registerForRemoteNotifications()
    
    requestNotificationAuthorization(application: application)
    if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
      NSLog("🥰 [UIApplication.LaunchOptionsKey.remoteNotification] applicationState: \(applicationStateString) didFinishLaunchingWithOptions for iOS9: \(userInfo)")
      //TODO: Handle background notification
    }
    
    application.registerForRemoteNotifications()
    
    //        if let data =  UserDefaults(suiteName: "group.new.one")?.value(forKey: "Test") as? String {
    //          print(data)
    //        }        
    
    return true
  }
  //Fix Me
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    UNUserNotificationCenter.current().delegate = self
    return true
  }
  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    print("GetRemoute_Message",remoteMessage)
  }
  
  
  var applicationStateString: String {
    if UIApplication.shared.applicationState == .active {
      return "active"
    } else if UIApplication.shared.applicationState == .background {
      return "background"
    }else {
      return "inactive"
    }
  }
  
  
  func requestNotificationAuthorization(application: UIApplication) {
    if #available(iOS 10.0, *) {
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
    } else {
      let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
  }
  
}
extension AppDelegate : MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    NSLog("👏 [didReceiveRegistrationToken] didRefreshRegistrationToken: 👍 ---> \(fcmToken)")
  }
  
  // iOS9, called when presenting notification in foreground
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    print("🍎 --> [didReceiveRemoteNotification] applicationState: --> 🍎 \(applicationStateString) didReceiveRemoteNotification for iOS9 🍎: \(userInfo)")
    
    if UIApplication.shared.applicationState == .active {
      print(userInfo)
    } else {
    }
  }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("---------> 😍 willPresent")
    if let userInfo = notification.request.content.userInfo as? [String : AnyHashable]{
      if let aps = userInfo["aps"]  as? [String: Any] {
        if let message = aps["alert"] as? [String: Any] {
          let _ = message["body"] as? String ?? "Welcome to PushNotify."
          let _ = message["title"] as? String ?? "ID-Pal"
          if let _ = userInfo["gcm.message_id"] as? String{
            print("---------> 👏 willPresent PayLoad 👏 --> 😍 \(aps)")
          }
        }
      }
    }
    completionHandler([.alert, .badge, .sound])
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    print("---------> 😍 didReceive response")
    if let userInfo = response.notification.request.content.userInfo as? [String : AnyHashable]{
      if let aps = userInfo["aps"]  as? [String: Any] {
        if let message = aps["alert"] as? [String: Any] {
          let _ = message["body"] as? String ?? "Welcome to PushNotify."
          let _ = message["title"] as? String ?? "ID-Pal"
          if let _ = userInfo["gcm.message_id"] as? String{
            print("---------> 👏 didReceive response 👏 --> 😍 \(aps)")
          }
        }
      }
    }
    
    let window = UIApplication.shared.keyWindow!
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    weak var viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
    window.rootViewController = viewController
    window.makeKeyAndVisible()
    
    completionHandler()
  }
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    print("---------> 😍 didReceiveRemoteNotification")
      if let aps = userInfo["aps"]  as? [String: Any] {
        if let message = aps["alert"] as? [String: Any] {
          let messageDesc = message["body"] as? String ?? "Welcome to PushNotify."
          let title = message["title"] as? String ?? "ID-Pal"
          if let _ = userInfo["gcm.message_id"] as? String{
            print("---------> 👏 didReceive response 👏 --> 😍 \(aps)")            
            NotifyValue.sharedInstance.value.append(notification(Titile: title, Desc: messageDesc))
            NotificationCenter.default.post(name: Notification.Name("Test"), object: nil)
          }
        }
      }
    
    print("😘 ------> didReceiveRemoteNotification Userinfo in Background Mode On -----> 😍 \(userInfo) 😍")
    completionHandler(.newData)
  }
  
  
  
}
