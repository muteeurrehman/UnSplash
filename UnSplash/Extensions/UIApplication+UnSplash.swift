//
//  UIApplication+UnSplash.swift
//  UnSplash
//
//  Created by Mutee Ur Rehman on 20/11/2021.
//

import Foundation

extension UIApplication {
    struct Constants {
        static let CFBundleShortVersionString = "CFBundleShortVersionString"
    }
    
    class func bundleIdentifier() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as! String
    }
   
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: Constants.CFBundleShortVersionString) as! String
    }
  
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
  
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
        return version == build ? "v\(version)" : "v\(version)(\(build))"
    }
}
