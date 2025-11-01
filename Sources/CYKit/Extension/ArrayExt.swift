//
//  ArrayExt.swift
//  AFProject
//
//  Created by droog on 2019/8/2.
//  Copyright © 2019 droog. All rights reserved.
//

import Foundation

extension Array {
    ///JsonStr
    public func jsonString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
                return jsonString
            }
        } catch {
            return ""
        }
        return ""
    }
    
    public static func arrayWithJson(_ jsonString: String) -> [[String:Any]]? {
        if let data = jsonString.data(using: String.Encoding.utf8), let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
            return dic
        }
        return nil
    }
    
    /// 获取数组中指定索引的值
    ///
    /// - Parameter index: 索引
    /// - Returns: 对象
    public func safeObjectAtIndex(index: Int) -> Element? {
        if index < self.count && index >= 0 {
            return self[index]
        }
        return nil
    }
}
