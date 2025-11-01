//
//  UIFontExt.swift
//  AFProject
//
//  Created by droog on 2019/8/2.
//  Copyright © 2019 droog. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    public static func dom_fontScaleSize() -> CGFloat {
        if Constant.WINDOW_WIDTH < 375 {
            return -2
        }else if Constant.WINDOW_WIDTH > 375{
            return 1
        }
        return 0
    }
}

extension TypeWrapperProtocol where WrappedType == UIFont {
    public static func systemFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size + WrappedType.dom_fontScaleSize())
    }
    public static func boldSystemFontWithSize(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size + WrappedType.dom_fontScaleSize())
    }
}
