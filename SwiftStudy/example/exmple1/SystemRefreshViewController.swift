//
//  SystemRefreshViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/31.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class SystemRefreshViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let refreshTabView = UITableView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height), style: UITableViewStyle.plain);
    let refreshControl = UIRefreshControl()
    
    var contents = ["下下下下下","拉拉拉拉拉","刷刷刷刷刷","新新新新新","哟哟哟哟哟"]
    var news     = ["1111","2222","3333","4444","5555","6666"]
    let cellIdentifier = "RefreshCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshTabView.delegate   = self
        refreshTabView.dataSource = self
        refreshTabView.tableFooterView = UIView()
        refreshTabView.separatorStyle = UITableViewCellSeparatorStyle.none
        refreshTabView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(refreshTabView)
        if #available(iOS 10.0, *) {
            refreshTabView.refreshControl = refreshControl
        }
        else {
            // Fallback on earlier versions
        }
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "最后一次更新：\(Date())", attributes: [NSForegroundColorAttributeName : UIColor.white])
        refreshControl.addTarget(self, action:#selector(systemRefresh), for: UIControlEvents.valueChanged)
        

    }
    
    func systemRefresh () {
        print("beginRegresh")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
                self.contents.append(contentsOf: self.news)
                self.refreshTabView.reloadData()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell.textLabel?.text = String(indexPath.row + 1) + ":" + contents[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.backgroundColor = UIColor.white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\("indexPath.row")" + ":"+"\(#file)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
