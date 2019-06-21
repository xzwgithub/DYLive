//
//  ZWPageContentView.swift
//  PageTitileViewDemo
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

protocol ZWPageContentViewDelegate : class {
    func pageContentView(contentView:ZWPageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}

class ZWPageContentView: UIView {

    //MARK: - 定义属性
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0.0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : ZWPageContentViewDelegate?
    
    //MARK: - 懒加载属性
    private lazy var collectionView:UICollectionView = {[unowned self] in
        
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()
    
    
    //MARK: -自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController?) {
        
        self.childVcs = childVcs
        self.parentViewController = parentVc
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: 设置UI界面
extension ZWPageContentView {
    
    private func setupUI(){
        
        //1.将所有子控制器添加到父控制器中
        for chileVC in childVcs {
            parentViewController?.addChild(chileVC)
        }
        
        //2. 添加UICollectionView用于在cell 中存放控制器view
         addSubview(collectionView)
         collectionView.frame = bounds
    }
    
}


//MARK:遵守UICollectionViewDataSource协议
extension ZWPageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        //2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
        
    }
}

//MARK: 遵守UICollectionViewDelegagte协议
extension ZWPageContentView : UICollectionViewDelegate {
    
    //即将开始滚动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    //滚动过程中调用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        
        //1.定义需要获取的数据
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        //2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        
        if currentOffsetX > startOffsetX { //左滑
            
            //2.1计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            print("progress:\(progress)---currentOffsetX:\(currentOffsetX)----scrollViewW:\(scrollViewW)")
            
            //2.2 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //2.3 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //2.4如果完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else { //右滑
            
            //2.1计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX/scrollViewW))
            
            //2.2 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            //2.3 计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //3.讲progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

//MARK: 对外暴露的方法
extension ZWPageContentView {
    
    func setContentIndex(currentIndex:Int) {
        
        //1.供外部调用，禁止代理方法执行
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
