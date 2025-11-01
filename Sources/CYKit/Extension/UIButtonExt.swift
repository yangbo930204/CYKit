//
//  UIButtonExt.swift
//  AFProject
//
//  Created by droog on 2019/8/2.
//  Copyright © 2019 droog. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    /// 倒计时按钮
    ///
    /// - Parameters:
    ///   - timeLimit: 倒计时总时间
    ///   - title: 还没倒计时的title
    ///   - countDownTitle: 倒计时中
    ///   - mainColor: 还没倒计时的颜色
    ///   - countColor: 倒计时中的颜色
    public func timerButton(timeLimit: Int, title: String, countDownTitle: String) -> Void {
        //倒计时时间
        var timeOut = timeLimit
        let queue = DispatchQueue.global()
        let _timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(), queue: queue)
        //每秒执行一次
        _timer.schedule(deadline: .now(), repeating: .seconds(1) ,leeway:.milliseconds(timeOut))
        _timer.setEventHandler(handler: DispatchWorkItem(block: {
            if timeOut <= 0 {
                _timer.cancel()
                
                DispatchQueue.main.async {
                    self.setTitle(title, for: .normal)
                    self.isUserInteractionEnabled = true
                }
            }else{
                let allTime = timeLimit + 1
                let seconds = timeOut % allTime
                let timeStr = String(format: "(%02ds)", seconds)
                DispatchQueue.main.async {
                    self.setTitle(countDownTitle + timeStr, for: .normal)
                    self.isUserInteractionEnabled = false
                }
                timeOut -= 1
            }
        }))
        _timer.resume()
    }
    
    public enum ButtonImagePosition : Int {
        case left    //图片在左
        case top     //图片在上
        case right   //图片在右
        case bottom  //图片在下
    }
    
    /// 调整Button的image的位置
    ///
    /// - Parameters:
    ///   - position: 位置
    ///   - offset: 偏移量
    public func ajustImagePosition(position: ButtonImagePosition, offset: CGFloat) -> Void {
        //获取按钮图片的宽高
        let imageWidth = self.imageView?.frame.width ?? 0
        let imageHeight = self.imageView?.frame.height ?? 0
        //获取文字的宽高
        var labelWidth = self.titleLabel?.frame.width ?? 0
        var labelHeight = self.titleLabel?.frame.height ?? 0
        labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0
        labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0
        var titleLeft: CGFloat = 0, titleRight: CGFloat = 0, titleTop: CGFloat = 0, titleBottom: CGFloat = 0, imageLeft: CGFloat = 0, imageRight: CGFloat = 0, imageTop : CGFloat = 0, imageBottom: CGFloat = 0
        switch position {
        case .left:
            imageTop = 0;
            imageBottom = 0;
            imageLeft =  -offset / 2.0;
            imageRight = offset / 2.0;
            
            titleTop = 0;
            titleBottom = 0;
            titleLeft = offset / 2;
            titleRight = -offset / 2;
            break
            
        case .top:
            imageTop = -(labelHeight / 2.0 + offset / 2.0);
            imageBottom = (labelHeight / 2.0 + offset / 2.0);
            imageLeft = labelWidth / 2.0;
            imageRight = -labelWidth / 2.0;
            
            titleLeft = -imageWidth / 2.0;
            titleRight = imageWidth / 2.0;
            titleTop = imageHeight / 2.0 + offset / 2.0;
            titleBottom = -(imageHeight / 2.0 + offset / 2.0);
            break
            
        case .right:
            imageTop = 0;
            imageBottom = 0;
            imageRight = -(labelWidth + offset / 2.0);
            imageLeft = labelWidth + offset / 2.0;
            
            titleTop = 0;
            titleLeft = -(imageWidth + offset / 2.0);
            titleBottom = 0;
            titleRight = imageWidth + offset / 2.0;
            break
            
        case .bottom:
            imageLeft = (imageWidth + labelWidth) / 2.0 - imageWidth / 2.0;
            imageRight = -labelWidth / 2.0;
            imageBottom = -(labelHeight / 2.0 + offset / 2.0);
            imageTop = labelHeight / 2.0 + offset / 2.0;
            
            titleTop = -(imageHeight / 2.0 + offset / 2.0);
            titleBottom = imageHeight / 2.0 + offset / 2.0;
            titleLeft = -imageWidth / 2.0;
            titleRight = imageWidth / 2.0;
            break
        }
        self.imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight);
        self.titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight);
    }
}
