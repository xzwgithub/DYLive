//
//  UIColor+Extension.swift
//  DYLive
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

extension UIColor {
    
    /*
     convenience:便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常用在对系统的类进行构造函数的扩充时使用
     便利构造函数的特点：
     1.便利构造函数通常都是写在extension里面
     2.便利函数init前面需要加载convenience
     3.在便利构造函数中需要明确调用self.init()
     */
    convenience init(r: CGFloat,g: CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
}
