//
//  ZWBaseTableTableViewController.swift
//  DYLive
//
//  Created by xiezw on 2019/6/14.
//  Copyright © 2019 xiezw. All rights reserved.
//

import UIKit

let kChatCellID = "kChatCellID"

class ZWBaseTableTableViewController: UIViewController {

    // MARK: -定义属性
    var count : Int = 0
    
    // MARK: -懒加载属性
    lazy var tableView: UITableView = {[unowned self] in
        let tableView = UITableView(frame: self.view.bounds,style: .plain)
        tableView.backgroundColor = UIColor(r: 244, g: 245, b: 245)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: kChatCellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - 设置UI
extension ZWBaseTableTableViewController {
    func setupUI() {
       view.addSubview(tableView)
    }
}

extension ZWBaseTableTableViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kChatCellID, for: indexPath) as! ZWChatViewCell
        return cell
    }
}
