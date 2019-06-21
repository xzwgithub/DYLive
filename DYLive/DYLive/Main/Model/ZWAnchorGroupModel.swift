//
//  ZWAnchorGroupModel.swift
//  DYLive
//
//  Created by xiezw on 2019/6/21.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWAnchorGroupModel: ZWBaseGameModel {
    
    //定义主播的模型对象数组
    @objc lazy var anchors : [ZWAchorModel] = [ZWAchorModel]()
    
    //组显示的图标
    @objc var icon_name : String = "home_header_normal"
    
    
    
    //该组中对应的房间信息
    @objc var room_list : [[String : Any]]? {
        
        //属性监听器，监听属性的改变
        didSet {
            guard let room_list = room_list else {
                return
            }
            for dict in room_list {
                anchors.append(ZWAchorModel.init(dict: dict))
            }
        }
    }
    

}
