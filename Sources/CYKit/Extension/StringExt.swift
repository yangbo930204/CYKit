import UIKit
import Foundation
extension String {
    
    /// 获取文字真是长度，包括颜文字
    /// let family1 = "👨‍👩‍👧‍👦"
    /// let family11 = "123👨‍👩‍👧‍👦123"
    /// print(family1.count)/1
    /// print(family1.utf16.count)/1
    /// print(family1.utf8.count)/25
    /// let range = family11.rangeOfString(family1)
    /// print(range) /(3,11)
    public var length: Int {
        return self.utf16.count
    }
    
    /// 检查去除空格换行后是否为空白字符串（常用于输入框）
    public var isBlank: Bool {
        //获取去除空格换行后的字符串
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }

    /// 去空格换行 返回新的字符串
    /// ex:    "he  llo \n  ".trimmed()="hello"
    public func trimmed() -> String {
        //timmingCaracters只去除前后空格换行
        return self.removeAllSapce.removeAllLine.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    
    var removeAllLine: String {
        return self.replacingOccurrences(of: "\n", with: "")
    }
    
    ///  json 字符转字典
    ///  ex:  "{\"key\":\"value\"}".toDictionary() = [key:value]
    public func toDictionary() -> [String: Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
            } catch let error {
                Print(error.localizedDescription)
            }
        }
        return nil
    }
    
    /// json转字典
    public func toArray<T>(t: T.Type) -> [T]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [T]
            } catch let error  {
                Print(error)
            }
        }
        return nil
    }
    
    /// String to Int
    public func toInt() -> Int {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return 0
        }
    }
    
    public func toInt64() -> Int64 {
        if let num = NumberFormatter().number(from: self) {
            return num.int64Value
        } else {
            return 0
        }
    }
    
    /// String to Double
    public func toDouble() -> Double {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return 0.0
        }
    }
    
    /// String to Float
    public func toFloat() -> Float {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return 0
        }
    }
    
    /// String to Bool
    public func toBool() -> Bool {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return false
    }
    
    ///  String to NSString
    public var toNSString: NSString { return self as NSString }
    
    ///最后一个分割
    ///ex. "/home/login/file.jpg".lastPathComponent = "file.jpg"
    public var lastPathComponent: String {
        return self.components(separatedBy: "/").last ?? ""
    }
    
    /// 获取文件类型
    /// ex. "/home/login/file.jpg".lastPathComponent = "jpg"
    public var pathExtension: String {
        return self.components(separatedBy: ".").last ?? ""
    }
    
    /// 截取字符串
    /// ex. "123456".substring(from: 1) = "23456"
    public func subString(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return ""
        }
    }
    
    /// ex. "123456".substring(from: 1, to: 6) = "123456"
    public func subString(from: Int, to: Int) -> String {
        if self.count > from && self.count >= to && to > from {
            let startIndex = self.index(self.startIndex, offsetBy: from-1)
            let endIndex = self.index(self.startIndex, offsetBy: to)
            let subString = self[startIndex..<endIndex]
            return String(subString)
        }
        return ""
    }
    
    /// ex. "123456".substring(to: 6) = "123456"
    public func subString(to: Int) -> String {
        if to > self.count {return self}
        if to <= 0 {return ""}
        let startIndex = self.startIndex
        let endIndex = self.index(self.startIndex, offsetBy: to)
        let subString = self[startIndex..<endIndex]
        return String(subString)
    }

    ///  根据range截断字符串
    ///  let range = Range(uncheckedBounds: (2, 3))
    /// "123456".subString(range: range) = "23"
    public func subString(range: Range<Int>) -> String {
        if range.endIndex > self.count {
            return ""
        }
        return self.subString(from: range.startIndex, to: range.endIndex)
    }
    
    ///  获取指定字符串的[NSRange]
    ///  获取所有字符串中包含的所有 特定字符串的 range
    ///  "12345678901234567890".matchStrRange("23") = [{1, 2}, {11, 2}]
    public func rangesOfString(_ subString: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: (subString as NSString).length).joined(separator: "") //辅助字符串
        if subString == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: subString).location != NSNotFound {
            let range = selfStr.range(of: subString)
            allRange.append(NSRange(location: range.location,length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }
    
    /// "12345678901234567890".rangeOfString("23") = {1,2}
    public func rangeOfString(_ subString: String) -> NSRange {
        let selfNS = self.toNSString
        return selfNS.range(of: subString)
    }
    
    /// 正则表达式获取目的值
    /// - parameter pattern: 一个字符串类型的正则表达式
    /// - parameter str: 需要比较判断的对象
    /// - imports: 这里子串的获取先转话为NSString的[以后处理结果含NS的还是可以转换为NS前缀的方便]
    /// - returns: 返回目的字符串结果值数组(目前将String转换为NSString获得子串方法较为容易)
    /// - warning: 注意匹配到结果的话就会返回true，没有匹配到结果就会返回false
    static func regexGetSub(pattern:String, str:String) -> [String] {
        var subStr = [String]()
        let regex = try! NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
        let results = regex.matches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.length))
        //解析出子串
        for  rst in results {
            let nsStr = str as  NSString  //可以方便通过range获取子串
            subStr.append(nsStr.substring(with: rst.range))
            //str.substring(with: Range<String.Index>) //本应该用这个的，可以无法直接获得参数，必须自己手动获取starIndex 和 endIndex作为区间
        }
        return subStr
    }
    
    /// 字符串高度
    public func height(_ width: CGFloat, font: UIFont, lineBreakMode: NSLineBreakMode?) -> CGFloat {
        var attrib: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key.font: font]
        if lineBreakMode != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = lineBreakMode!
            attrib.updateValue(paragraphStyle, forKey: NSAttributedString.Key.paragraphStyle)
        }
        let size = CGSize(width: width, height: CGFloat(Double.greatestFiniteMagnitude))
        return ceil((self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes:attrib, context: nil).height)
    }
    
    /// 获取富文本的高度(指定lineSpace的富文本)
    public func stringHeightWith(font: UIFont, width: CGFloat, lineSpace: CGFloat) -> CGFloat{
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byTruncatingTail;
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle:paragraphStyle]
        let text = self as NSString
        let rect = text.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size.height
    }
    
    /// 根据固定的size和font计算文字的rect
    ///
    /// - Parameters:
    /// - font: 文字的字体大小
    /// - size: 文字限定的宽高(计算规则:计算宽度, 传入一个实际的高度, 用于计算的宽度则取计算单位的最大值)
    /// - Returns: 返回的CGRect
    public func rect(with font: UIFont, size: CGSize) -> CGRect {
        return (self as NSString).boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    }
    
    /// 根据固定的size和font计算文字的height
    public func height(with font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(with: font, size: size).height
    }
    /// 根据固定的size和font计算文字的width
    public func width(with font: UIFont, size: CGSize) -> CGFloat {
        return self.rect(with: font, size: size).width
    }
    
    /// 是否为正确的是手机号
    ///
    /// - Parameter phone: 手机号
    /// - Returns: 是否正确
    public func isValidPhone() -> Bool{
        /*
        let str = "^[1-9][0-9]{4,11}$"
        
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@",str)
        
        return mobilePredicate.evaluate(with: phone)
         */
        return self.length > 1
    }
    
    /// 是否为有效的邮箱
    public func isValidEmail() -> Bool {
        let str = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let mobilePredicate = NSPredicate(format: "SELF MATCHES %@",str)
        return mobilePredicate.evaluate(with: self)
    }
    
    /// 昵称是否有效
    public func isValidNick() -> Bool {
       return self.length <= 12
    }
    
    /// 密码是否有效 （规则：限制长度在6~12，含有数字跟字母）
    public func isValidPassword() -> Bool {
        if self.length < 6 || self.length > 12 {
            return false
        }
        
        let passwordRegex = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,12}"
//        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@#!%*?&^,.])[A-Za-z\\d$@#!%*?&^,.]{8,}"
        let predicate = NSPredicate(format: "SELF MATCHES%@", passwordRegex)
        return predicate.evaluate(with : self)
    }
    
    /// id是否有效
    public func isValidID() -> Bool {
        if self.length < 2 || self.length > 15 {
            return false
        }
        
        let passwordRegex = "^[A-Za-z0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES%@", passwordRegex)
        
        return predicate.evaluate(with : self)
    }
    
    /// 千分符 1，000格式
    ///
    /// - Parameter str: 数字
    /// - Returns: 1，000
    public static func calcuteSymbolLocation(str: String) -> String {
        var resultStr = str
        let symbolStr = "."
        let subRange = (resultStr as NSString).range(of: symbolStr)
        if subRange.location == 4  || subRange.location == 5 {
            resultStr.insert(",", at: str.index(resultStr.startIndex, offsetBy: 1))
        }
        return resultStr
    }
    
    /// 清除字符串小数点末尾的0
    public func cleanDecimalPointZear() -> String {
        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substring(with: NSMakeRange(offset, 1)) as NSString
            if s.isEqual(to: "0") || s.isEqual(to: ".") {
                offset -= 1
            } else {
                break
            }
        }
        return newStr.substring(to: offset + 1)
    }
    
    /// - 给证件号、手机号添加***替换
    /// 比如 18369901234 -> 18****1234
    public func cipherNumber() -> String? {
        if self.length < 7 { return self }
        var ciper = self
        let startIndex = ciper.index(ciper.startIndex, offsetBy: 3)
        let endIndex = ciper.index(ciper.endIndex, offsetBy: -4)
        
        var replaceStr = ""
        for _ in 0...(self.length - 7) {
            replaceStr.append("*")
        }
        ciper.replaceSubrange(startIndex...endIndex, with: replaceStr)
        return ciper
    }
    
    /// 比如 FF32424 -> F****4
    public func cipherPassportNumber() -> String? {
        if self.length < 5 { return self }
        var ciper = self
        let startIndex = ciper.index(ciper.startIndex, offsetBy: 2)
        let endIndex = ciper.index(ciper.endIndex, offsetBy: -3)
        
        var replaceStr = ""
        for _ in 0...(self.length - 5) {
            replaceStr.append("*")
        }
        ciper.replaceSubrange(startIndex...endIndex, with: replaceStr)
        return ciper
    }
    
    public func cipherEmail() -> String {
        guard isValidEmail() else { return self }
        let emails = self.components(separatedBy: "@")
        var ciper = self.components(separatedBy: "@").first!
        if ciper.length < 3 { return self }
        let startIndex = ciper.index(ciper.startIndex, offsetBy: 3)
        let endIndex = ciper.index(ciper.endIndex, offsetBy: -1)
        
        var replaceStr = ""
        for _ in 0...(ciper.length - 3) {
            replaceStr.append("*")
        }
        ciper.replaceSubrange(startIndex...endIndex, with: replaceStr)
        return ciper + "@" + emails.last!
    }
    
    /// 判断是否为合法的身份证号
    ///
    /// - Parameter sfz: 身份证
    /// - Returns: 是否合法
    public static func isValidateIDCardNumber(sfz:String)->(Bool){
        let value = sfz.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        var length = 0
        if value == "" {
            return false
        }else{
            length = value.length
            if length != 15 && length != 18 {
                return false
            }
        }
        
        //省份代码
        let arearsArray = ["11","12", "13", "14",  "15", "21",  "22", "23",  "31", "32",  "33", "34",  "35", "36",  "37", "41",  "42", "43",  "44", "45",  "46", "50",  "51", "52",  "53", "54",  "61", "62",  "63", "64",  "65", "71",  "81", "82",  "91"]
        let valueStart2 = (value as NSString).substring(to: 2)
        var arareFlag = false
        
        if arearsArray.contains(valueStart2) {
            arareFlag = true
        }
        if !arareFlag{
            return false
        }
        
        var regularExpression = NSRegularExpression()
        var numberofMatch = Int()
        var year = 0
        
        switch (length) {
        case 15:
            year = Int((value as NSString).substring(with: NSRange(location:6,length:2)))!
            if year%4 == 0 || (year%100 == 0 && year%4 == 0){
                do{
                    regularExpression = try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: .caseInsensitive) //检测出生日期的合法性
                }catch{}
            }else{
                do{
                    regularExpression =  try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: .caseInsensitive) //检测出生日期的合法性
                }catch{}
            }
            numberofMatch = regularExpression.numberOfMatches(in: value, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, value.length))
            if(numberofMatch > 0) {
                return true
            }else {
                return false
            }
            
        case 18:
            year = Int((value as NSString).substring(with: NSRange(location:6,length:4)))!
            if year%4 == 0 || (year%100 == 0 && year%4 == 0){
                do{
                    regularExpression = try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive) //检测出生日期的合法性
                }catch{}
            }else{
                do{
                    regularExpression =  try NSRegularExpression.init(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive) //检测出生日期的合法性
                    
                }catch{}
            }
            
            numberofMatch = regularExpression.numberOfMatches(in: value, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, value.length))
            
            if(numberofMatch > 0) {
                let s =
                    (Int((value as NSString).substring(with: NSRange(location:0,length:1)))! +
                        Int((value as NSString).substring(with: NSRange(location:10,length:1)))!) * 7 +
                        (Int((value as NSString).substring(with: NSRange(location:1,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:11,length:1)))!) * 9 +
                        (Int((value as NSString).substring(with: NSRange(location:2,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:12,length:1)))!) * 10 +
                        (Int((value as NSString).substring(with: NSRange(location:3,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:13,length:1)))!) * 5 +
                        (Int((value as NSString).substring(with: NSRange(location:4,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:14,length:1)))!) * 8 +
                        (Int((value as NSString).substring(with: NSRange(location:5,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:15,length:1)))!) * 4 +
                        (Int((value as NSString).substring(with: NSRange(location:6,length:1)))! +
                            Int((value as NSString).substring(with: NSRange(location:16,length:1)))!) *  2 +
                        Int((value as NSString).substring(with: NSRange(location:7,length:1)))! * 1 +
                        Int((value as NSString).substring(with: NSRange(location:8,length:1)))! * 6 +
                        Int((value as NSString).substring(with: NSRange(location:9,length:1)))! * 3
                
                let Y = s%11
                var M = "F"
                let JYM = "10X98765432"
                
                M = (JYM as NSString).substring(with: NSRange(location:Y,length:1))
                if M == (value as NSString).substring(with: NSRange(location:17,length:1))
                {
                    return true
                }else{return false}
            }else {
                return false
            }
        default:
            return false
        }
    }
    
    /// 转换为时间显示  00:00 （10位）
    /// let time = "1630056148"
    /// Print(time.timeShow())
    /// 22:28  例如  2:57 显示为 02：02
    /// - Returns: 1
    public func timeShow() -> String {
        let time = self.toInt()
        return timeFormat(time: time)
    }
    
    private func timeFormat(time: Int) -> String {
        return transformTimeStr(time: (time % 3600) / 60) + ":" + transformTimeStr(time:(time) % 60)
    }
    
    private func transformTimeStr(time: Int) -> String{
        if time > 9 {
            return String(time)
        }else{
            return "0" + String(time)
        }
    }
    
    /// 时间戳转YYYY-MM-dd  （13位）
    /// 
    /// - Returns: 时间
    public func timeStampToDate() -> String{
        let date = Date(timeIntervalSince1970: self.toDouble()/1000)
        return date.getpointDate()
    }
    
    
    /// 时间戳转YYYY-MM-dd hh mm ss （13位）
    ///
    /// Print(time.toTimeMin())
    ///
    /// - Returns: 时间
    public func timeStampToYYYYMMddhhss() -> String{
        let date = Date(timeIntervalSince1970: self.toDouble()/1000)
        return date.string()
    }
    
    /// 时间戳转YYYY-MM-dd  （13位）
    ///
    /// - Returns: 时间
    public func timeStampToTimeShow(dataFormat: String) -> String {
        let date = Date(timeIntervalSince1970: self.toDouble()/1000)
        return date.stringWithDateFormat(dateFormat: dataFormat)
    }
    
    /// 时间戳转YYYY-MM-dd  （13位）
    ///
    /// - Returns: 时间
    public func toDate() -> Date {
        var date: Date?
        if self.toDouble() > 0 {
            date = Date(timeIntervalSince1970: self.toDouble()/1000)
        }
        else {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy-MM-dd"
            date = formatter.date(from: self)
        }
        return date ?? Date()
    }
    
    
    /// 显示小时分钟 （13位）
    /// 17：22
    public func toTimeHour() -> String {
        var result = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "en")
        
        let createDate = Date(timeIntervalSince1970: self.toDouble()/1000.0) //创建一个日历类
        let formatterSr = "HH:mm"
        formatter.dateFormat = formatterSr
        result = formatter.string(from: createDate)
        return result
    }
    
    /// 生成随机字符串
    ///
    /// - Parameter length: 随机字符串的长度
    /// - Returns: 字符串
    public static func randomStr(length: Int = 16) -> String {
        let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var ranStr = ""
        for _ in 0...(length - 1) {
            let index = Int(arc4random_uniform(UInt32(characters.length)))
            ranStr.append(characters.subString(from: index, to: index + 1))
        }
        return ranStr
    }
    
    
    /// - 判断是不是纯数字
    public func isPureNumber() -> Bool {
        let regex = "^[0-9]*$"
        let predicate = NSPredicate(format: "SELF MATCHES%@", regex)
        
        return predicate.evaluate(with: self)
    }
    
    /// - 修改数字的颜色
    public func modifyNumberColor(color: UIColor,
                      font: UIFont,
                      regx: String = "([0-9]\\d*\\.?\\d*)") -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        do {
            // 数字正则表达式
            let regexExpression = try NSRegularExpression(pattern: regx, options: NSRegularExpression.Options())
            let result = regexExpression.matches(
                in: self,
                options: NSRegularExpression.MatchingOptions(),
                range: NSMakeRange(0, count)
            )
            for item in result {
                attributeString.setAttributes(
                    [.foregroundColor : color, .font: font],
                    range: item.range
                )
            }
        } catch {
            Print("Failed with error: \(error)")
        }
        return attributeString
    }
}

extension Array where Element == UInt8 {
    public var hexString: String {
        return self.compactMap { String(format: "%02x", $0).uppercased() }
            .joined(separator: "")
    }
}

extension String.StringInterpolation {
    /// 提供 `Optional` 字符串插值
    /// 而不必强制使用 `String(describing:)`
    /// 可选值插值样式
    public enum OptionalStyle {
        /// 有值和没有值两种情况下都包含单词 `Optional`
        case descriptive
        /// 有值和没有值两种情况下都去除单词 `Optional`
        case stripped
        /// 使用系统的插值方式，在有值时包含单词 `Optional`，没有值时则不包含
        case `default`
    }
    
    /// 使用提供的 `optStyle` 样式来插入可选值
    public mutating func appendInterpolation<T>(_ value: T?, optStyle style: String.StringInterpolation.OptionalStyle) {
        switch style {
        // 有值和没有值两种情况下都包含单词 `Optional`
        case .descriptive:
            if value == nil {
                appendLiteral("Optional(nil)")
            } else {
                appendLiteral(String(describing: value))
            }
        // 有值和没有值两种情况下都去除单词 `Optional`
        case .stripped:
            if let value = value {
                appendInterpolation(value)
            } else {
                appendLiteral("nil")
            }
        // 使用系统的插值方式，在有值时包含单词 `Optional`，没有值时则不包含
        default:
            appendLiteral(String(describing: value))
        }
    }
    
    /// 使用 `stripped` 样式来对可选值进行插值
    /// 有值和没有值两种情况下都省略单词 `Optional`
    public mutating func appendInterpolation<T>(_ value: T?) {
        appendInterpolation(value, optStyle: .stripped)
    }
    
}
