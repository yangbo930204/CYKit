//
//  GCDTimer.swift
//  WisedomSong
//
//  Created by droog on 2019/5/22.
//  Copyright © 2019 droog. All rights reserved.
//

import UIKit

public class GCDTimer {
    public init() {}
    private var timer: DispatchSourceTimer?
    /// 开启定时器
    ///
    /// - Parameters:
    ///   - timeInterval: 时间间隔  只支持到毫秒级
    ///   - queue: 队列
    ///   - closure: 回调
    public func start(timeInterval: TimeInterval = 1, queue: DispatchQueue = DispatchQueue.main, closure: (()->())? = nil){
        stop()
        timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(), queue: queue)
        timer?.schedule(deadline: .now(), repeating: .milliseconds(Int(timeInterval * 1000)), leeway: .milliseconds(0))
        timer?.setEventHandler(handler: { [weak self] in
            guard let _ = self else{ return }
            closure?()
        })
        timer?.resume()
    }
    
    public func stop(){
        guard let timer = timer, !timer.isCancelled else { return }
        timer.cancel()
        self.timer = nil
    }
}
