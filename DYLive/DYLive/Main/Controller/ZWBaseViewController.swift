//
//  ZWBaseViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWBaseViewController: UIViewController {
    
    // MARK:- 定义属性
    var contentView : UIView?
    
    //MARK:- 懒加载
    fileprivate lazy var animationImageView:UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        imageView.animationRepeatCount = LONG_MAX
        imageView.animationDuration = 0.5
        imageView.isUserInteractionEnabled = false
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()

    // MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
}

extension ZWBaseViewController {
    
      @objc func setUI(){
    
       //1.隐藏contentView
       contentView?.isHidden = true
    
       //2.添加动画视图
       view.addSubview(animationImageView)
    
       //3.执行动画
       animationImageView.startAnimating()
    
      //4.添加背景颜色
      view.backgroundColor = UIColor(r: 250, g: 250, b: 2250)
    }
    
    func loadDataFinished() {
        //1.停止动画
        animationImageView.stopAnimating()
        
        //2.隐藏animationImageView
        animationImageView.isHidden = true
        
        //3.显示contentView
        contentView?.isHidden = false
    }
}
