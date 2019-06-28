//
//  ZWBaseAnchorViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/21.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

//MARK:常量
private let kItemMargin : CGFloat = 10.0
private let kHeaderViewH : CGFloat = 50.0

let kNormalItemW : CGFloat = (kScreenW - kItemMargin * 3)/2
let kNormalItemH : CGFloat = kNormalItemW * 3 / 4
let kPrettyItemH : CGFloat = kNormalItemW * 4 / 3

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "KHeaderViewID"
let kPrettyCellID = "kPrettyCellID"

class ZWBaseAnchorViewController: ZWBaseViewController {
    
    
    //定义属性
    var baseVM : ZWBaseViewModel!
    lazy var collectionView : UICollectionView = {[unowned self] in
        
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //2.创建UIColectionView
         let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "ZWCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "ZWCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "ZWCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置UI界面
        setUI()
        
        //2.请求数据
        loadData()
    }
    
}

//MARK: 设置UI界面
extension ZWBaseAnchorViewController {
    
    override func setUI() {
        
        //1.给父类中内容View的引用进行赋值
        contentView = contentView
        
        //2.再添加collectionView
        view.addSubview(collectionView)
        
        //再调用super
        super.setUI()
    }
}

//MARK:请求数据
extension ZWBaseAnchorViewController {
    
    func loadData() {
        
    }
    
}


extension ZWBaseAnchorViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! ZWCollectionNormalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath) as! ZWCollectionHeaderView
        
        //2.给headerView设置数据
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
}

//MARK: UICollectionViewDelegate 协议
extension ZWBaseAnchorViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //1.取出主播信息
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //2.判断是秀场房间还是普通房间
        //anchor.isVertical == 0 ?
        
    }
    
    private func presentShowRoomVC() {
        
        //1.创建VC
        let showRoomVC = ZWRoomShowViewController()
        
        //2.以Model的方式弹出
        self.present(showRoomVC, animated: true, completion: nil)
        
    }
    
    private func pushNormalRoomVC() {
        
        //1.创建VC
        let normalRoomVC = ZWRoomNormalViewController()
        
        
        //2.以push的方式弹出
        navigationController?.pushViewController(normalRoomVC, animated: true)
        
    }
    
}
