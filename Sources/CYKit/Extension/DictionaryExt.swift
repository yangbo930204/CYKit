//
//  DictionaryExt.swift
//  AFProject
//
//  Created by droog on 2019/8/2.
//  Copyright © 2019 droog. All rights reserved.
//

import Foundation
extension Dictionary {
    
    public static func dicWithJson(_ jsonString: String) -> [String:Any]? {
        if let data = jsonString.data(using: String.Encoding.utf8), let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
            return dic
        }
        return nil
    }
    // 输出带格式的json字符串
    public func jsonString() -> String {
        do {
            let stringData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let string = String(data: stringData, encoding: String.Encoding.utf8){
                return string
            }
        } catch _ {
            return ""
        }
        return ""
    }
    // 输出不带各种的json字符串
    public func jsonTrimString() -> String {
        do {
            let stringData = try JSONSerialization.data(withJSONObject: self, options: .sortedKeys)
            if let string = String(data: stringData, encoding: .utf8) {
                return string
            }
        } catch  {
            return ""
        }
        return ""
    }
}
