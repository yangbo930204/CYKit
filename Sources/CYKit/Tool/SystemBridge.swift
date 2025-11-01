//
//  WSSystemBridge.swift
//  WisedomSong
//
//  Created by droog on 2018/7/23.
//  Copyright © 2018年 droog. All rights reserved.
//

import Foundation
import UIKit

public struct SystemBridge {
    
    // 根据某个URL跳转 (适配到iOS10)
    public static func jumpToSystemSetting(url: String) {
        let sysUrl: URL = URL(string: url)!
        if UIApplication.shared.canOpenURL(sysUrl) {
            UIApplication.shared.open(sysUrl, options: [:], completionHandler: nil)
        }
    }
    
    // 是否开启远程通知
    public static func isOpenRemoteNotification() -> Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
    // 评分
    public static func jumpToScore(appId: String) {
        let metalkAppStoreUrl: String = String.init(format: "https://itunes.apple.com/app/id%@?mt=8", appId)
        jumpToSystemSetting(url: metalkAppStoreUrl)
    }
    
    // 找到当前显示的window
    public static func currentWindow() -> UIWindow? {
        // 找到当前显示的UIWindow
        var window = UIWindow.key
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindow.Level.normal {
            for tempWindow in UIApplication.shared.windows {
                if tempWindow.windowLevel == UIWindow.Level.normal {
                    window = tempWindow
                    break
                }
            }
        }
        return window
    }
    
    /* 递归找最上面的viewController */
    public static func topViewController() -> UIViewController? {
        return self.topViewControllerWithRootViewController(viewController: self.currentWindow()?.rootViewController?.children.last)
    }
    
    private static func topViewControllerWithRootViewController(viewController: UIViewController?) -> UIViewController? {
        if viewController == nil {
            return nil
        }
        if let presentVC = viewController?.presentedViewController {
            return topViewControllerWithRootViewController(viewController: presentVC)
        }
        else if let tabVC = viewController as? UITabBarController {
            if let selectVC = tabVC.selectedViewController {
                return topViewControllerWithRootViewController(viewController: selectVC)
            }
            return nil
        }
        else if let naiVC = viewController as? UINavigationController {
            return topViewControllerWithRootViewController(viewController: naiVC.visibleViewController)
        }
        else {
            return viewController
        }
    }
    
    /// 退出APP
    public static func exitApp(){
        exit(0)
    }
}


extension UIWindow {
    public static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
        else {
            return UIApplication.shared.keyWindow
        }
    }
}
