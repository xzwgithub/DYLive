//
//  UIBarButtonItem+Extension.swift
//  DYLive
//
//  Created by xiezw on 2019/6/27.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //便利构造函数：1 以convenience开头  2 在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero, viewController: UIViewController, selector: Selector) {
        
        print(size)
        
        //1.创建UIButton
        let btn = UIButton()
        btn.addTarget(viewController, action: selector, for: .touchUpInside)
        
        //2.设置btn图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        //3.设置btn尺寸
        if size == CGSize.zero {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        //4.创建UIBarButtonItem
        self.init(customView:btn)
        
    }
    
}
