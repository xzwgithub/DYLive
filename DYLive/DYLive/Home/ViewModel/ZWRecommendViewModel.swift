//
//  ZWRecommendViewModel.swift
//  DYLive
//
//  Created by xiezw on 2019/6/27.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

class ZWRecommendViewModel: ZWBaseViewModel {
    
    //MARK:懒加载属性
    lazy var cycleModels : [ZWCycleModel] = [ZWCycleModel]()
    private lazy var bigDataGroup : ZWAnchorGroupModel = ZWAnchorGroupModel()
    private lazy var prettyDataGroup : ZWAnchorGroupModel = ZWAnchorGroupModel()
    

}

//MARK:发送网络请求
extension ZWRecommendViewModel {
    
    //请求推荐数据
    func requestData(finishCallBack: @escaping ()->()) {
        
        //0.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime() as NSString]
        
        //0.1 创建Group
        let dispatchGroup = DispatchGroup()
        
        //1.请求第一部分推荐数据
        //进入DispatchGroup组
        dispatchGroup.enter()
        ZWNetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            
            //1.1 将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            //1.2 根据data该key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //1.3 遍历数组，获取字典，并将字典转成模型对象
            //1.3.1 设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //1.3.2 获取主播数据
            for dict in dataArray {
                self.bigDataGroup.anchors.append(ZWAchorModel.init(dict: dict))
            }
            
            //1.4离开组
            dispatchGroup.leave()
            print("请求到1")
            
        }
        
        //2.请求第二部分颜值数据
        dispatchGroup.enter()
        ZWNetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //2.1 将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else { return }
            
            //2.2 根据data 的key，获取数组
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else { return }
            
            //2.3遍历数组，获取字典，并将字典转成模型对象
            //2.3.1 设置组的属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            //2.3.2 获取主播数据
            for dict in dataArray {
                self.prettyDataGroup.anchors.append(ZWAchorModel.init(dict: dict))
            }
            
            //2.4离开组
            dispatchGroup.leave()
            print("请求到2")
            
        }
        
        //3. 请求2-12部分游戏数据
        //进入组
        dispatchGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            
            //离开组
            dispatchGroup.leave()
            print("请求到3")
            
        }
        
        //4.所有数据请求到，进行排序
        dispatchGroup.notify(queue: .main) {
            print("所有的数据都请求到")
            self.anchorGroups.insert(self.prettyDataGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
        
    }
    
    //请求无限轮播的数据
    func requestCycleData(finishCallBack: @escaping ()->()) {
        
        ZWNetWorkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            //1.获取整体的字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据字典的key 获取data数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(ZWCycleModel.init(dict: dict))
            }
            
            finishCallBack()
        }
        
    }
    
}
