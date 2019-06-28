//
//  NSDate+Extension.swift
//  DYLive
//
//  Created by xiezw on 2019/6/27.
//  Copyright © 2019 xiezw. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func getCurrentTime() -> String {
        
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}
