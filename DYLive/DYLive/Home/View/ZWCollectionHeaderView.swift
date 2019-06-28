//
//  ZWCollectionHeaderView.swift
//  DYLive
//
//  Created by xiezw on 2019/6/25.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWCollectionHeaderView: UICollectionReusableView {
    

    //MARK :控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    //MARK:定义模型属性
    var group : ZWAnchorGroupModel? {
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}

//MARK: 从xib中快速创建类方法
extension ZWCollectionHeaderView {
    
    class func collectionHeaderView() -> ZWCollectionHeaderView {
        return Bundle.main.loadNibNamed("ZWCollectionHeaderView", owner: nil, options: nil)?.first as! ZWCollectionHeaderView
    }
    
}
