//
//  AppDelegate.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if DataService.getImages().count == 0 {
            let images = [Image(id: 1, urlString: "https://images.unsplash.com/photo-1637266702043-287eb7d2b5b2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80", isFavourite: false), Image(id: 2, urlString: "https://images.unsplash.com/photo-1637266702921-a2eae66c7f9d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1828&q=80", isFavourite: false), Image(id: 3, urlString: "https://images.unsplash.com/photo-1637322450761-97b86275c4eb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80", isFavourite: false), Image(id: 4, urlString: "https://images.unsplash.com/photo-1637199503452-7f87024dd69f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60", isFavourite: false), Image(id: 5, urlString: "https://images.unsplash.com/photo-1637199503452-7f87024dd69f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60", isFavourite: false), Image(id: 6, urlString: "https://images.unsplash.com/photo-1637199503452-7f87024dd69f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60", isFavourite: false), Image(id: 7, urlString: "https://images.unsplash.com/photo-1637199503452-7f87024dd69f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60", isFavourite: false), Image(id: 8, urlString: "https://images.unsplash.com/photo-1637199503452-7f87024dd69f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60", isFavourite: false), Image(id: 9, urlString: "https://images.unsplash.com/photo-1637199503452-7f87024dd69f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwcm9maWxlLXBhZ2V8MTN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60", isFavourite: false), ]

            DataService.save(images: images)

        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

