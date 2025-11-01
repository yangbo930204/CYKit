//
//  UIColor+TCZ.swift
//  Dormouse
//
//  Created by tczy on 2017/8/11.
//  Copyright © 2017年 WangSuyan. All rights reserved.
//

import UIKit
import Foundation


extension TypeWrapperProtocol where WrappedType == UIColor {
    
    //RGB进制颜色值
    public static func RGBCOLOR(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0);
    }
    
    //RGBA进制颜色值
    public static func RGBACOLOR(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a);
    }
    
    //16进制颜色值，如：#000000 , 注意：在使用的时候hexValue写成：0x000000
    public static func HexColor(hexValue: UInt) -> UIColor {
        return UIColor.init(red: ((CGFloat)(((hexValue) & 0xFF0000) >> 16))/255.0, green: ((CGFloat)(((hexValue) & 0xFF00) >> 8))/255.0, blue: ((CGFloat)((hexValue) & 0xFF))/255.0, alpha: 1.0)
    }
    
    //16进制颜色值
    public static func HexAColor(hexValue: UInt, a:CGFloat) -> UIColor {
        return UIColor.init(red: ((CGFloat)(((hexValue) & 0xFF0000) >> 16))/255.0, green: ((CGFloat)(((hexValue) & 0xFF00) >> 8))/255.0, blue: ((CGFloat)((hexValue) & 0xFF))/255.0, alpha: a)
    }
    
    //返回随机颜色
    public static var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    //颜色转图片
    public func trans2Image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(wrappedValue.cgColor)
        context?.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage ?? UIImage()
    }
    

}

extension UIColor {
    // Hex String -> UIColor
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // UIColor -> Hex String
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
         
        let multiplier = CGFloat(255.999999)
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
         
        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
