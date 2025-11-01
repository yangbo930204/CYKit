import Foundation
import UIKit

public protocol linkCreateCompatible {
    associatedtype WrapperType
    var cy: WrapperType { get }
    static var cy: WrapperType.Type { get }
}
extension linkCreateCompatible {
    public var cy: LinkDescriber<Self> {
        return LinkDescriber(value: self)
    }
    public static var cy: LinkDescriber<Self>.Type {
        return LinkDescriber.self
    }
}
public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}
public struct LinkDescriber<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}

extension UIColor: linkCreateCompatible{}
extension UIView: linkCreateCompatible{}
extension UIFont: linkCreateCompatible{}
