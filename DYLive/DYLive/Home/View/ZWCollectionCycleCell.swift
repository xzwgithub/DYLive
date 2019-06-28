//
//  ZWCollectionCycleCell.swift
//  DYLive
//
//  Created by xiezw on 2019/6/27.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit
import Kingfisher

class ZWCollectionCycleCell: UICollectionViewCell {

    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //定义模型属性
    var cycleModel : ZWCycleModel? {
    
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")
            let resource = ImageResource(downloadURL: iconURL!)
            iconImageView.kf.setImage(with: resource, placeholder: UIImage(named: "Img_default"))
        }
        
    }
    
   
}
