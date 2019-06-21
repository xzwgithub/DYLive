//
//  ZWBaseAnchorViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/21.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWBaseAnchorViewController: ZWBaseViewController {
    
    
    //定义属性
    var baseVM : ZWBaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   

}
