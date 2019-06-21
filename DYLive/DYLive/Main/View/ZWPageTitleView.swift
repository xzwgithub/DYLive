//
//  ZWPageTitleView.swift
//  PageTitileViewDemo
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

//MARK:- 定义常量
private let kScrollLineH : CGFloat = 2.0
private let kLabelTextColor : (CGFloat,CGFloat,CGFloat) = (85,85,85) //颜色rgb值
private let kLabelTextSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

//MARK: - 定义协议
protocol ZWPageTitleViewDelegate : class {
    func pageTitleView(titleView:ZWPageTitleView, selectedIndex  index : Int)
}

class ZWPageTitleView: UIView {

    // MARK: - 定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : ZWPageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    private lazy var scrollView : UIScrollView = {[unowned self] in
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK: - labels 数组
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    //MARK: - 添加scrollLine
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    //MARK: - 自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //h设置UI界面
        setUpUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ZWPageTitleView {
    
    private func setUpUI(){
        
        //1.添加scrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        setUpTitleLables()
        
        //3.设置底线和滚动的滑块
        setUpBottomMenuAndScrollLine()
    }
    
    private func setUpTitleLables() {
        
        //0.确定label的一些frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(red: kLabelTextColor.0/255.0, green: kLabelTextColor.1/255.0, blue: kLabelTextColor.2/255.0, alpha: 1.0)
            label.textAlignment = .center
            
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollview中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    private func setUpBottomMenuAndScrollLine() {
        
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(red: kLabelTextSelectColor.0/255.0, green: kLabelTextSelectColor.1/255.0,blue: kLabelTextSelectColor.2/255.0, alpha: 1.0)
        
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        
    }
    
    
}

//MARK:- 监听label点击
extension ZWPageTitleView {
    
    @objc private func titleLabelClick(tapGes: UITapGestureRecognizer){
        
        //0.获取当前点击Label
         guard let currentLabel = tapGes.view as? UILabel else { return }
        
        //1.如果重复点击同一个label,那么直接返回
        if currentLabel.tag == currentIndex {
            return
        }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3.切换文字颜色
        currentLabel.textColor = UIColor(red: kLabelTextSelectColor.0/255.0, green: kLabelTextSelectColor.1/255.0,blue: kLabelTextSelectColor.2/255.0, alpha: 1.0)
        oldLabel.textColor = UIColor(red: kLabelTextColor.0/255.0, green: kLabelTextColor.1/255.0, blue: kLabelTextColor.2/255.0, alpha: 1.0)
        
        //4.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //5.滚动条位置修改
        let scrollLinePosition = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePosition
        }
        
        //6. 通知外部逻辑
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
    
}

//MARK:- 对外暴露的方法
extension ZWPageTitleView {
    
    func setTitleColorWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色渐变（复杂）
        //3.1取出颜色变化的范围
        let colorDelta = (kLabelTextSelectColor.0 - kLabelTextColor.0,kLabelTextSelectColor.1 - kLabelTextColor.1,kLabelTextSelectColor.2 - kLabelTextColor.2)
        
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(red: (kLabelTextSelectColor.0 - colorDelta.0 * progress)/255.0, green: (kLabelTextSelectColor.1 - colorDelta.1 * progress)/255.0, blue: (kLabelTextSelectColor.2 - colorDelta.2 * progress)/255.0, alpha: 1.0)
        
        //3.3变化的targetLabel
        targetLabel.textColor =  UIColor(red: (kLabelTextColor.0 + colorDelta.0 * progress)/255.0, green: (kLabelTextColor.1 + colorDelta.1 * progress)/255.0, blue: (kLabelTextColor.2 + colorDelta.2 * progress)/255.0, alpha: 1.0)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
    
}
