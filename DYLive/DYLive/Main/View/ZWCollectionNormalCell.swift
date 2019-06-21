//
//  ZWCollectionNormalCell.swift
//  DYLive
//
//  Created by xiezw on 2019/6/21.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWCollectionNormalCell: ZWCollectionBaseCell {

    
    @IBOutlet weak var roomNameLabel:UILabel!
    
    //MARK:定义属性模型
    override var anchor: ZWAchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            //2.房间名称
            roomNameLabel.text = anchor?.room_name
        }
    }
    
}
