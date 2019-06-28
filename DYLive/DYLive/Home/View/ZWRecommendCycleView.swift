//
//  ZWRecommendCycleView.swift
//  DYLive
//
//  Created by xiezw on 2019/6/27.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class ZWRecommendCycleView: UIView {
    
    
    //MARK: 定义属性
    var cycleTimer : Timer?
    var cycleModels : [ZWCycleModel]? {
        
        didSet {
            
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2. 设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置改控件不随父控件拉伸而拉伸，即设置为none或者空[]
        autoresizingMask = []
        
        //注册cell
        collectionView.register(UINib(nibName: "ZWCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
    
}

//MARK: 提供一个快熟创建View的类方法
extension ZWRecommendCycleView {
    class func recommendCycleView() -> ZWRecommendCycleView {
        return Bundle.main.loadNibNamed("ZWRecommendCycleView", owner: self, options: nil)?.first as! ZWRecommendCycleView
    }
}


//MARK: 遵守UICollectionViewDataSource 协议
extension ZWRecommendCycleView : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! ZWCollectionCycleCell
        
        let cycleModel = cycleModels?[indexPath.item % cycleModels!.count]
        
        cell.cycleModel = cycleModel
        
        return cell
    }
    
}


//MARK：遵守UICollectionViewDelegate协议
extension ZWRecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
    //监听用户拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        addCycleTimer()
    }
    
}





//MARK：对定时器的操作方法
extension ZWRecommendCycleView {
    
    
    //创建定时器的方法
    private func addCycleTimer() {
        
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
        
    }
    
    
    //移除定时器的方法
    private func removeCycleTimer() {
        
        //1.从运行循环中移除
        cycleTimer?.invalidate()
        
        //2.设置nil
        cycleTimer = nil
        
    }
    
    
    @objc private func scrollToNext() {
        
        //1.获取滚动的偏移量
        let currrentOffsetX = collectionView.contentOffset.x
        let offsetX = currrentOffsetX + collectionView.bounds.width
        
        //2.滚动到该位置
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        
    }
    
}
