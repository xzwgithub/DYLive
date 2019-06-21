//
//  ZWBaseViewModel.swift
//  DYLive
//
//  Created by xiezw on 2019/6/21.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWBaseViewModel {
    
    lazy var anchorGroups : [ZWAnchorGroupModel] = [ZWAnchorGroupModel]()

}

extension ZWBaseViewModel {
    
    func loadAnchorData(isGroupData: Bool, URLString: String, parameters:[String : Any]? = nil, finishCallback:@escaping ()->()) {
        
        ZWNetWorkTools.requestData(type: .get, URLString: URLString, parameters: parameters) { (result) in
            
            //1.获取字典数据
            guard let resultDic = result as? [String : Any] else {return}
            guard let dataArray = resultDic["data"] as? [[String : Any]] else {return}
            
            //2.判断是否分组数据
            if isGroupData {
                //2.1字典转模型对象
                for dict in dataArray {
                    self.anchorGroups.append(ZWAnchorGroupModel(dict: dict))
                }
                
            }else {
                
                //2.1创建组
                let group = ZWAnchorGroupModel()
                
                //2.2 遍历dataArray所有的字典
                for dict in dataArray {
                    group.anchors.append(ZWAchorModel(dict: dict))
                }
                
                //2.3将group添加到anchorGroups里面
                self.anchorGroups.append(group)
            }
            
            //3.完成回调
            finishCallback()
            
        }
        
    }
}
