//
//  Common.swift
//  DYLive
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

//屏幕宽、高
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

//判断是否是 iphone
let KIsPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

//判断是否是iphoneX
let kIsPhoneX = Bool(kScreenW >= 375.0 && kScreenH >= 812.0 && KIsPhone)

//导航条的高度
let kNavigationBarH = CGFloat(kIsPhoneX ? 88 : 64)

//状态栏高度
let kStatusBarH = CGFloat(kIsPhoneX ? 44 : 20)

//tabbar高度
let kTabBarH = CGFloat(kIsPhoneX ? (49 + 34) : 49)

//顶部安全区域远离高度
let kTopSafeH = CGFloat(kIsPhoneX ? 44 : 0)

//底部安全区域远离高度
let kBottomSafeH = CGFloat(kIsPhoneX ? 34 : 0)

