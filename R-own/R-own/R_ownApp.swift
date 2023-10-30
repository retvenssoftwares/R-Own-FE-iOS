//
//  R_ownApp.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import GoogleSignIn
import mesibo
import UIKit
import CallKit
import UserNotifications
import BackgroundTasks


class AppDelegate: NSObject, UIApplicationDelegate {
    @StateObject var mesiboVM = MesiboViewModel()
    @StateObject var loginData = LoginViewModel()
    

    let gcmMessageIDKey = "gcm.Message_ID"
    
      func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
          
          let providerFactory = YourAppCheckProviderFactory()
          AppCheck.setAppCheckProviderFactory(providerFactory)
          FirebaseApp.configure()
          
          
          
          //initalizing notification variables to null
          loginData.notificationPostView = false
          loginData.notificationUserpostID = ""
          loginData.notificationUserpostType = ""
          loginData.notificationMessageView = false
          loginData.notificationUserAddress = ""
          loginData.notificationProfileView = false
          loginData.notificationUseruserID = ""
          loginData.notificationUserrole = ""
          
          // Register the background fetch task
              BGTaskScheduler.shared.register(forTaskWithIdentifier: "app.retvens.rown", using: nil) { task in
                  self.handleBackgroundFetch(task: task as! BGAppRefreshTask)
              }
          
          // Push Notifications
          
          if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions,
              completionHandler: { _, _ in }
            )
          } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
          }
          
          application.registerForRemoteNotifications()
          
          // Messaging Delegate
          
          Messaging.messaging().delegate = self
//
//          Messaging.messaging().token { token, error in
//            if let error = error {
//              print("Error fetching FCM registration token: \(error)")
//            } else if let token = token {
//              print("FCM registration token: \(token)")
////              self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
//            }
//          }
          
        return true
      }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
        }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//
//      if let messageID = userInfo[gcmMessageIDKey] {
//        print("Message ID: \(messageID)")
//      }
//
//      print(userInfo)
//
//      completionHandler(UIBackgroundFetchResult.newData)
//    }
    
}

extension AppDelegate: MessagingDelegate {
  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      @StateObject var loginData = LoginViewModel()
      
      print("APN TOken ---")
      loginData.apnToken = String(describing: fcmToken!)
      print(loginData.apnToken)
    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
  }
    
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)  {
        let userInfo = notification.request.content.userInfo
        let title = notification.request.content.title
        let body = notification.request.content.body

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...
        
      if notification.request.content.userInfo["notificationType"] as! String == "comment" {
          print(notification.request.content.userInfo["postID"]!)
          print(notification.request.content.userInfo["postType"]!)
          
      } else if notification.request.content.userInfo["notificationType"] as! String == "like" {
          print(notification.request.content.userInfo["postID"]!)
          print(notification.request.content.userInfo["postType"]!)
          
      } else if notification.request.content.userInfo["notificationType"] as! String == "message" {
          print(notification.request.content.userInfo["userAddress"]!)
//          mesiboVM.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
//          mesiboVM.mesiboSetTPPUser(userInfo["userAddress"] as! String)
//          loginData.notificationMessageView = true
//          loginData.notificationUserAddress = userInfo["userAddress"] as! String
//
          print("==============================")
      } else if notification.request.content.userInfo["notificationType"] as! String == "connection" {
          print(notification.request.content.userInfo["userID"]!)
          print(notification.request.content.userInfo["role"]!)
          
      }
      
    // Change this to your preferred presentation option
        // Customize the notification presentation
        let presentationOptions: UNNotificationPresentationOptions = [.banner, .sound, .badge]
        
        completionHandler(presentationOptions)
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    // ...

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
      
      print(response.notification.request.content.userInfo["notificationType"]!)
      if response.notification.request.content.userInfo["notificationType"] as! String == "comment" {
          print(response.notification.request.content.userInfo["postID"]!)
          print(response.notification.request.content.userInfo["postType"]!)
          
          loginData.notificationPostView = true
          loginData.notificationUserpostID = response.notification.request.content.userInfo["postID"] as! String
          loginData.notificationUserpostType = response.notification.request.content.userInfo["postType"] as! String
          
      } else if response.notification.request.content.userInfo["notificationType"] as! String == "like" {
          print(response.notification.request.content.userInfo["postID"]!)
          print(response.notification.request.content.userInfo["postType"]!)
          loginData.notificationPostView = true
          loginData.notificationUserpostID = response.notification.request.content.userInfo["postID"] as! String
          loginData.notificationUserpostType = response.notification.request.content.userInfo["postType"] as! String
          
      } else if response.notification.request.content.userInfo["notificationType"] as! String == "message" {
          print(response.notification.request.content.userInfo["userAddress"]!)
          loginData.notificationMessageView = true
          loginData.notificationUserAddress = userInfo["userAddress"] as! String
            mesiboVM.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
            mesiboVM.mesiboSetTPPUser(userInfo["userAddress"] as! String)
            loginData.notificationMessageView = true
            loginData.notificationUserAddress = userInfo["userAddress"] as! String
          
      } else if response.notification.request.content.userInfo["notificationType"] as! String == "connection" {
          print(response.notification.request.content.userInfo["userID"]!)
          print(response.notification.request.content.userInfo["role"]!)
          loginData.notificationProfileView = true
          loginData.notificationUseruserID = response.notification.request.content.userInfo["userID"] as! String
          loginData.notificationUserrole = response.notification.request.content.userInfo["role"] as! String
          
      }
      
      completionHandler()
    // Print full message.
    print(userInfo)
  }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void)
    {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
        print(userInfo["notificationType"]!)
        if userInfo["notificationType"] as! String == "comment" {
            print(userInfo["postID"]!)
            print(userInfo["postType"]!)
            if userInfo["postType"] != nil {
                if userInfo["postType"]! as! String == "share some media" || userInfo["postType"]! as! String == "click and share"  {
                    loginData.notificationUserpostID = userInfo["postID"]! as! String
                    loginData.notificationPostView = true
                }
            }
            
        } else if userInfo["notificationType"] as! String == "like" {
            print(userInfo["postID"]!)
            print(userInfo["postType"]!)
            if userInfo["postType"] != nil {
                if userInfo["postType"]! as! String == "share some media" || userInfo["postType"]! as! String == "click and share" {
                    loginData.notificationUserpostID = userInfo["postID"]! as! String
                    loginData.notificationPostView = true
                }
            }
            
        } else if userInfo["notificationType"] as! String == "message" {
            print(userInfo["userAddress"]!)
            loginData.notificationMessageView = true
            loginData.notificationUserAddress = userInfo["userAddress"] as! String
        } else if userInfo["notificationType"] as! String == "connection" {
            print(userInfo["userID"]!)
            print(userInfo["role"]!)
        }
        
      if application.applicationState == .inactive {
          // The app was in the background and launched due to the notification
          // Schedule and present the notification
          print("vet")
          
      } else {
          // The app is currently active
          // You can handle the notification payload or show an in-app banner/notification as desired
      }
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }
      // Print full message.
      print(userInfo)
    
        completionHandler(.newData)
    }
    func handleBackgroundFetch(task: BGAppRefreshTask) {
        // Perform the necessary background fetch tasks here
        print("=========================================================================")
        mesiboVM.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
        print("=========================================================================")
        
        // Call the completion handler when the tasks are finished
        task.setTaskCompleted(success: true)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Schedule the background fetch task
        let request = BGAppRefreshTaskRequest(identifier: "app.retvens.rown")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1) // Schedule the task to start after 15 minutes
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Error scheduling background fetch task: \(error)")
        }
    }
    
//    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        // Perform the necessary background fetch tasks here
//
//        // Call the completion handler with the appropriate result
//        completionHandler(.newData)
//    }
}
//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken
//                     deviceToken: Data) {
//        print()
//        Messaging.messaging() .apnsToken = deviceToken
//    }
//
//    func application(_ application: UIApplication,
//                     didFailToRegisterForRemoteNotificationswithError
//                     error: Error) {
//        print("Failed to register with push")
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//      let userInfo = notification.request.content.userInfo
//
//      Messaging.messaging().appDidReceiveMessage(userInfo)
//
//      // Change this to your preferred presentation option
//      completionHandler([[.alert, .sound]])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//      let userInfo = response.notification.request.content.userInfo
//
//      Messaging.messaging().appDidReceiveMessage(userInfo)
//
//      completionHandler()
//    }
//
//    func application(_ application: UIApplication,
//    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
//       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//      Messaging.messaging().appDidReceiveMessage(userInfo)
//      completionHandler(.noData)
//    }
//
//}





@main
struct R_ownApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var mesiboVM = MesiboViewModel()
    @StateObject var networkMonitor = NetworkMonitor()
    
    @StateObject var languageData = LanguageViewModel()
    @StateObject var loginData = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashView(languageData: languageData, loginData: loginData, mesiboVM: mesiboVM)
                .overlay{
                    if loginData.showLoader{
                        RownLoaderView(loginData: loginData)
                    }
                }
                .environmentObject(networkMonitor)
                .environment(\.locale, Locale.init(identifier: languageData.currentLanguage))
                .onOpenURL { url in
                    print("url working")
                    let tappedURL = url.absoluteString
                    print(tappedURL)
                }
            }
    }
}
//func displayPushNotification(title: String?, body: String?) {
//    let content = UNMutableNotificationContent()
//    content.title = title ?? ""
//    content.body = body ?? ""
//    content.sound = .default
//
//    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
//    UNUserNotificationCenter.current().add(request) { error in
//        if let error = error {
//            print("Error displaying push notification: \(error)")
//        }
//    }
//}
func scheduleLocalizedNotification(title: String, body: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request) { error in
        if let error = error {
            print("Error scheduling local notification: \(error)")
        } else {
            print("Local notification scheduled successfully")
        }
    }
}

func scheduleAndPresentNotification(userInfo: [AnyHashable: Any], loginData: LoginViewModel, mesiboVM: MesiboViewModel) {
    // Extract the necessary data from the userInfo dictionary
    
    mesiboVM.mesiboInitalize(loginData.mainUserMesiboToken, address: loginData.mainUserPhoneNumber, remoteUserName: loginData.mainUserFullName)
    
    guard let aps = userInfo["aps"] as? [String: Any],
          let alert = aps["alert"] as? [String: Any],
          let title = alert["title"] as? String,
          let body = alert["body"] as? String else {
        return
    }
    
    // Create the notification content
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    
    // Create the notification trigger for immediate delivery
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0, repeats: false)
    
    // Create the notification request
    let request = UNNotificationRequest(identifier: "BackgroundFetchNotification", content: content, trigger: trigger)
    
    // Get the notification center
    let notificationCenter = UNUserNotificationCenter.current()
    
    // Schedule the notification
    notificationCenter.add(request) { error in
        if let error = error {
            print("Error scheduling notification: \(error.localizedDescription)")
        } else {
            print("Notification scheduled successfully")
        }
    }
}

class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    if #available(iOS 14.0, *) {
      return AppAttestProvider(app: app)
    } else {
      return DeviceCheckProvider(app: app)
    }
  }
}
