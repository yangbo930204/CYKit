//
//  UILabelExt.swift
//  AFProject
//
//  Created by droog on 2019/8/2.
//  Copyright © 2019 droog. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel {
    var fontSize: CGFloat {
        get {
            return self.font.pointSize;
        }
        set {
            self.font = UIFont.cy.systemFontWithSize(size: newValue)
        }
    }
    
    var boldSize: CGFloat {
        get {
            return self.font.pointSize;
        }
        set {
            self.font = UIFont.cy.boldSystemFontWithSize(size: newValue)
        }
    }
}
