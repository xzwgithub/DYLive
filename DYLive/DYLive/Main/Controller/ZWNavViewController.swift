//
//  ZWNavViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/13.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //添加全屏pop手势
        addFullScreenPopGesture()
        
    }
    
    private func addFullScreenPopGesture() {
        
        //实现全屏pop手势
        //1.获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        
        //2.获取手势添加的view
        guard let gesView = systemGes.view else {return}
        
        //3.获取target/action
        //3.1 利用运行时机制，查看所有属性名称
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            //print(String(cString: name!))
        }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        print(targetObjc)
        
        //3.2取出target
        guard let target = targetObjc.value(forKey: "target") else { return  }
        
        //3.3取出action
        let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //1.隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

}
