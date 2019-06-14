//
//  MainViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/13.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC("Home")
        addChildVC("Live")
        addChildVC("Follow")
        addChildVC("Profile")
        
    }
    
    private func addChildVC(_ name : String) {
        
        //1.通过storyboard来获取控制器
       let childVC =  UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        
        //2.添加控制器
        addChild(childVC)
    }
    
}
