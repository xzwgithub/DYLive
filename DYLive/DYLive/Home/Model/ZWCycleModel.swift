//
//  ZWCycleModel.swift
//  DYLive
//
//  Created by xiezw on 2019/6/27.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWCycleModel: NSObject {
    
    //标题
    @objc var title : String = ""
    
    //图片
    @objc var pic_url : String = ""
    
    //主播信息对应的字典
    @objc var room : [String : NSObject]? {
        didSet {
            guard let room = room else {return}
            anchor = ZWAchorModel(dict: room)
        }
    }
    
    //主播对象对应的模型对象
    @objc var anchor : ZWAchorModel?
    
    //自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
