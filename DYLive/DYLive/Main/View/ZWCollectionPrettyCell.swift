//
//  ZWCollectionPrettyCell.swift
//  DYLive
//
//  Created by xiezw on 2019/6/21.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWCollectionPrettyCell: ZWCollectionBaseCell {

   
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: ZWAchorModel? {
        didSet {
            //1.将属性传递给父类
            super.anchor = anchor
            
            // 2.所在城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
