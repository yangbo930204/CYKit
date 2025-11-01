import Foundation
import UIKit

public struct Constant {
    
    /// default edge to left or right
    public static let kLeftEdge: CGFloat = 14
    
    public static let ksideEdge: CGFloat = 30
    
    /// item edge
    public static let kItemSpace: CGFloat = 8
    
    /// tabBar height
    public static let kTabBarHeight: CGFloat = ajustBottomEdgeOnIPhoneX(49)
    
    /// naviBar height
    public static let kNaviBarHeight: CGFloat = ajustTopEdgeOnIPhoneX(64)
    
    /// statusBar height
    public static let kStatusBarHeight: CGFloat = 20
    
    /// default tableView section header title height
    public static let kSectionTitleHeight: CGFloat = 50
    
    /// default tableView cell height
    public static let kRowHeight: CGFloat = 44
    
    /// default big button height
    public static let kBigButtonHeight: CGFloat = 45
    /// default userIcon size
    public static let kUserIconSize: CGSize = CGSize(width: 150, height: 150)
    //屏幕宽高
    public static let WINDOW_WIDTH = UIScreen.main.bounds.size.width
    public static let WINDOW_HEIGHT = UIScreen.main.bounds.size.height
    public static let WINDOW_BOUNDS = UIScreen.main.bounds
    public static let SCREENSCALE = UIScreen.main.scale
    
    //屏幕宽高比
    public static let WINDOW_WIDTH_SCALE = UIScreen.main.bounds.size.width / 375
    public static let WINDOW_HEIGHT_SCALE = UIScreen.main.bounds.size.height / 667
    public static let keyWindow = UIWindow.key
    
    //设备 根据宽高判断
    public static let ISIPHONEX = WINDOW_HEIGHT - 812.0 == 0 // X  XS
    public static let ISIPHONEXR = WINDOW_HEIGHT - 896.0 == 0 //XR XSMAX
    
    public static let ISIPHONESE = WINDOW_HEIGHT - 568.0 == 0
    public static let ISIPHONE = WINDOW_HEIGHT - 667.0 == 0
    public static let ISIPHONEPlus = WINDOW_HEIGHT - 736.0 == 0
    
    //是否为刘海屏 
//    public static var ISHairScreen: Bool {
//        return safeAreaInsets.bottom > 0
//    }
    public static var ISHairScreen: Bool {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            return window.safeAreaInsets.top > 20
        }
        return false
    }

    //按当前屏幕宽高比适配后的宽度和高度
    public static func SCALE_WIDTH(_ width:CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.width / 375 * width
    }
    public static func SCALE_HEIGHT(_ height:CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height / 667 * height
    }
    
    //适配iPhone X的 方法
    //安全区域的偏移
    public static var safeAreaInsets: UIEdgeInsets {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first {
               return window.safeAreaInsets
           }
           return .zero
    }
    
    public static func ajustTopEdgeOnIPhoneX(_ edge :CGFloat) -> CGFloat{
        if ISHairScreen {
            return edge + safeAreaInsets.top - 20 //20是状态栏的高度
        }
        return edge
    }
    
    public static func ajustBottomEdgeOnIPhoneX(_ edge :CGFloat) -> CGFloat{
        if ISHairScreen {
            return edge + safeAreaInsets.bottom
        }
        return edge
    }
}
//异步线程
public func globalAsync(_ block: @escaping()->()){
    DispatchQueue.global().async {
        block()
    }
}

//异步主线程 防死锁
public func safeAsync(_ block: @escaping ()->()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async {
            block()
        }
    }
}

//主线程延迟
public func mainQueueAfter(time: TimeInterval, _ block: @escaping ()->()){
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        block()
    }
}

//打印log
public func Print<T>(_ item: T,
                        file: String = #file,
                        method: String = #function,
                        line: Int = #line){
    #if DEBUG
    print("\n\(file.lastPathComponent) [\(line)]\n\(item)\n")
    #endif
}



