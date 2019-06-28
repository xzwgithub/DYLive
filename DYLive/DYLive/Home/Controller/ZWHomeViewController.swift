//
//  ZWHomeViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class ZWHomeViewController: UIViewController {
    
    //MARK: 懒加载属性
    private lazy var pageTitleView : ZWPageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = ZWPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : ZWPageContentView = {[weak self] in
        //1.确定内容frame
        let contentH = kScreenH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        //2.确定所有子控制器
        var childVcs = [UIViewController]()
        childVcs.append(ZWRecommendViewController())
        childVcs.append(ZWGameViewController())
        childVcs.append(ZWAmuseViewController())
        childVcs.append(ZWFunnyViewController())
        
        let pageContentView = ZWPageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self
        
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI页面
        setupUI()
    }
    
}

//MARK:设置UI界面
extension ZWHomeViewController {
    
    private func setupUI() {
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setUpNavigationBar()
        
        //2.添加titleView
        view.addSubview(pageTitleView)
        
        //3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = .purple
        
    }
    
    private func setUpNavigationBar() {
        
        //1.设置左侧item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", viewController: self, selector: #selector(logoAction))
        
        //2.　设置右侧item
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size, viewController: self, selector: #selector(historyAction))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size, viewController: self, selector: #selector(searchAction))
        let grcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, viewController: self, selector: #selector(scanAction))
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,grcodeItem]
    }
}


//MARK:遵守ZWPageTitleViewDelegate协议
extension ZWHomeViewController : ZWPageTitleViewDelegate {
    
    func pageTitleView(titleView: ZWPageTitleView, selectedIndex index: Int) {
        pageContentView.setContentIndex(currentIndex: index)
    }
}

//MARK:遵守ZWPageTitleViewDelegate协议
extension ZWHomeViewController : ZWPageContentViewDelegate {
    
    func pageContentView(contentView: ZWPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleColorWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


//MARK:监听事件点击
extension ZWHomeViewController {
    
    @objc fileprivate func logoAction() {
        print("logo")
    }
    
    @objc fileprivate func historyAction() {
        print("历史记录")
    }
    
    @objc fileprivate func searchAction() {
        print("搜索")
    }
    
    @objc fileprivate func scanAction() {
        print("浏览")
    }
    
}
