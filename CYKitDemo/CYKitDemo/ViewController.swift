//
//  ViewController.swift
//  CYKitDemo
//
//  Created by droog on 2020/9/2.
//  Copyright © 2020 droog. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let button = UIButton()
    
    let timer = GCDTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        button.setTitle("test", for: .normal)
        button.addTarget(self, action: #selector(testMethod), for: .touchUpInside)
        view.addSubview(button)
        button.bounds.size = CGSize(width: 100, height: 100)
        button.center = view.center
        button.backgroundColor = .cyan
        
        button.setTitleColor(UIColor(hexString: "#353535"), for: .normal)
        
        
        
        var s = 1
        timer.start(timeInterval: 1, queue: .main) {
            self.button.setTitle("test" + "  " + "\(s + 1)", for: .normal)
            s = s + 1
        }
        
        
        Print(Date().timeStamp())

        Print(Date().dayIndexSince1970())
        Print(Date().dayIndexSinceNow())
        
//        Date.formatHour(hour: "6")
    }
    
    
    @objc func testMethod() {
        
//        Print("分钟前".cy_localized)
//        Bundle.setLanguageType(type: .LanguageEnglish)
//        Print("分钟前".cy_localized)
//        Bundle.setLanguageType(type: .LanguageJapanese)
//        Print("分钟前".cy_localized)
//        Bundle.setLanguageType(type: .LanguageChineseSimplified)
        timer.stop()
        
//        let time = "1630056148"
        
        
//        Boolean
        
//        Print(time.timeShow())
//        Print(time.toTimeMin())
//        Print(time.timeStampToDate())
//        Print((time + "000").timeStampToYYYYMMddhhss())
//        Print((time + "000").timeStampToTimeShow(dataFormat: "YYYY-MM-dd hh-mm-ss"))
//        Print((time + "000").toDate())
//        Print((time + "000").toTime())
//        Print((time + "000").toTimeLast())
//        Print((time + "000").toTimeHour())
        
//        AlertViewHelper.showActionSheet(title: "title", items: ["1","2","3"], cancelTitle: "取消", controller: self) { index in
//            Print(index)
//        }
    }
}

