//
//  ZWNetWorkTools.swift
//  DYLive
//
//  Created by xiezw on 2019/6/20.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class ZWNetWorkTools {
    
    class func requestData(type:MethodType,URLString : String,parameters:[String:Any]? = nil, finishCallback: @escaping (_ result: AnyObject) -> ()) {
        
        //1.获取类型
        let mothod = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        //2.发送请求
        Alamofire.request(URLString, method: mothod, parameters: parameters).responseJSON { (response) in
            
            //3.获取数据
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            
            //4.将结果返回
            finishCallback(result as AnyObject)
        }
        
    }

}
