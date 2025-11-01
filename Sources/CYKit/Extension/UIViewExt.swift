//
//  UIViewExt.swift
//  AFProject
//
//  Created by droog on 2019/8/2.
//  Copyright © 2019 droog. All rights reserved.
//

import UIKit
import Foundation


public extension TypeWrapperProtocol where WrappedType == UIView  {
    
    var x : CGFloat {
        get {
            return wrappedValue.frame.origin.x
        }
        
        set(newVal) {
            var tmpFrame : CGRect = wrappedValue.frame
            tmpFrame.origin.x     = newVal
            wrappedValue.frame    = tmpFrame
        }
    }
    
    var y : CGFloat {
        get {
            return wrappedValue.frame.origin.y
        }
        
        set(newVal) {
            var tmpFrame : CGRect = wrappedValue.frame
            tmpFrame.origin.y     = newVal
            wrappedValue.frame    = tmpFrame
        }
    }
    
    var left: CGFloat {
        get {
            return x
        }
        
        set(newVal) {
            x = newVal
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        
        set(newVal) {
            x = newVal - width
        }
    }
    
    var top: CGFloat {
        get {
            return y
        }
        
        set(newVal) {
            y = newVal
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height
        }
        
        set(newVal) {
            y = newVal - height
        }
    }
    
    var width: CGFloat {
        get {
            return wrappedValue.bounds.width
        }
        
        set(newVal) {
            var tmpFrame : CGRect = wrappedValue.frame
            tmpFrame.size.width   = newVal
            wrappedValue.frame    = tmpFrame
        }
    }
    
    var height: CGFloat {
        get {
            return wrappedValue.bounds.height
        }
        
        set(newVal) {
            var tmpFrame : CGRect = wrappedValue.frame
            tmpFrame.size.height  = newVal
            wrappedValue.frame    = tmpFrame
        }
    }
    
    var centerX : CGFloat {
        get {
            return wrappedValue.center.x
        }
        
        set(newVal) {
            wrappedValue.center = CGPoint(x: newVal, y: wrappedValue.center.y)
        }
    }
    
    var centerY : CGFloat {
        get {
            return wrappedValue.center.y
        }
        
        set(newVal) {
            wrappedValue.center = CGPoint(x: wrappedValue.center.x, y: newVal)
        }
    }
    
    var middleX : CGFloat {
        get {
            return width / 2
        }
    }
    
    var middleY : CGFloat {
        get {
            return height / 2
        }
    }
    
    var middlePoint : CGPoint {
        get {
            return CGPoint(x: middleX, y: middleY)
        }
    }
    
    var nearestViewcontroller: UIViewController? {
        var viewController: UIViewController?
        var next = wrappedValue.next
        while let _next = next {
            if _next.isKind(of: UIViewController.self) {
                viewController = next as? UIViewController
                break
            }
            next = _next.next
        }
        return viewController
    }
    
    var nearestTableView: UITableView? {
        var tableview: UITableView?
        var next = wrappedValue.next
        while let _next = next {
            if _next.isKind(of: UITableView.self) {
                tableview = next as? UITableView
                break
            }
            next = _next.next
        }
        return tableview
    }
    
    var nearestCollection: UICollectionView? {
        var collection: UICollectionView?
        var next = wrappedValue.next
        while let _next = next {
            if _next.isKind(of: UICollectionView.self) {
                collection = next as? UICollectionView
                break
            }
            next = _next.next
        }
        return collection
    }
    
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: wrappedValue.bounds)
        return renderer.image { rendererContext in
            wrappedValue.layer.render(in: rendererContext.cgContext)
        }
    }
    
    func renderToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(wrappedValue.bounds.size, wrappedValue.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            wrappedValue.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: wrappedValue.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = wrappedValue.bounds
        maskLayer.path = maskPath.cgPath
        wrappedValue.layer.mask = maskLayer
    }
    
    func corner(radius: CGFloat) {
        wrappedValue.layer.cornerRadius = radius
        wrappedValue.clipsToBounds = true
    }
}



public extension UIView  {
    
    var x : CGFloat {
        get {
            return frame.origin.x
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame    = tmpFrame
        }
    }
    
    var y : CGFloat {
        get {
            return frame.origin.y
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }
    
    var left: CGFloat {
        get {
            return x
        }
        
        set(newVal) {
            x = newVal
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
        
        set(newVal) {
            x = newVal - width
        }
    }
    
    var top: CGFloat {
        get {
            return y
        }
        
        set(newVal) {
            y = newVal
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height
        }
        
        set(newVal) {
            y = newVal - height
        }
    }
    
    var width: CGFloat {
        get {
            return bounds.width
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.height
        }
        
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    var centerX : CGFloat {
        get {
            return center.x
        }
        
        set(newVal) {
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    var centerY : CGFloat {
        get {
            return center.y
        }
        
        set(newVal) {
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    var middleX : CGFloat {
        get {
            return width / 2
        }
    }
    
    var middleY : CGFloat {
        get {
            return height / 2
        }
    }
    
    var middlePoint : CGPoint {
        get {
            return CGPoint(x: middleX, y: middleY)
        }
    }
    
    var nearestViewcontroller: UIViewController? {
        var viewController: UIViewController?
        var next = self.next
        while let _next = next {
            if _next.isKind(of: UIViewController.self) {
                viewController = next as? UIViewController
                break
            }
            next = _next.next
        }
        return viewController
    }
    
    var nearestTableView: UITableView? {
        var tableview: UITableView?
        var next = self.next
        while let _next = next {
            if _next.isKind(of: UITableView.self) {
                tableview = next as? UITableView
                break
            }
            next = _next.next
        }
        return tableview
    }
    
    var nearestCollection: UICollectionView? {
        var collection: UICollectionView?
        var next = self.next
        while let _next = next {
            if _next.isKind(of: UICollectionView.self) {
                collection = next as? UICollectionView
                break
            }
            next = _next.next
        }
        return collection
    }
    
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func asImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func renderToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    func corner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func border(width: CGFloat = 1, color: UIColor = .black){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    
    class func findLabel(view: UIView) -> [UILabel] {
        var labels = [UILabel]()
        for subView in view.subviews {
            if let subView = subView as? UILabel {
                labels.append(subView)
            }else{
                let alabels = findLabel(view: subView)
                labels.append(contentsOf: alabels)
            }
        }
        return labels
    }
    
    func shadow(color: UIColor, radius: CGFloat = 5, opacity: CGFloat = 0.8, offset: CGSize = .zero){
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.8
        layer.shadowOffset = offset
    }
}
