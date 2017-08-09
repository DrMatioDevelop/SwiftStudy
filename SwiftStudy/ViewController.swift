//
//  ViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/27.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

let timeCell = "timeCell"
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - 操作
    //TODO: - 记做
    //FIXME: - 提醒
    
    let testTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height), style: UITableViewStyle.plain)
    var tabDS:Array = [
        ["class":"TimeViewController","title":"时间"],
        ["class":"FontViewController","title":"字体"],
        ["class":"VideoViewController","title":"视频"],
        ["class":"UIScrollViewController","title":"滚动视图"],
        ["class":"UICollectionViewController","title":"集合视图"],
        ["class":"SystemRefreshViewController","title":"刷新"],
        ["class":"GradientViewController","title":"梯度颜色"],
        ["class":"DoCatchViewController","title":"DoCatch"],
        ["class":"ImageScrollerViewController","title":"图片滚动视图"],
        ["class":"VideoBackViewController","title":"背景小视频"],
        ["class":"ColorProgressViewController","title":"彩色进度条"],
        ["class":"TableViewHeadViewController","title":"头部放大"],
        ["class":"AnimationTableViewViewController","title":"TableView cell动画"],
        ["class":"WaveViewController","title":"波浪线"],
        ["class":"LayerRectViewController","title":"layer 绘图"],
        ["class":"PickerViewController","title":"Picker"],
        ["class":"ChildChtrolViewController","title":"ChildChtrol"],
        ["class":"CustomPushViewController","title":"自定义过场动画"],
        ["class":"TumblrViewController","title":"菜单"],
        ["class":"CollecItemAnimationViewController","title":"CollectionItemAnimation"],
        ["class":"SortableViewController","title":"可移动九宫格"],
        
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swift"
        view.backgroundColor = UIColor.white
        
        initView()
    }


    
    func initView () {
        tabDS = tabDS.reversed()
        
        testTableView.delegate = self
        testTableView.dataSource = self
        testTableView.register(UITableViewCell.self, forCellReuseIdentifier: timeCell)
        testTableView.tableFooterView = UIView()
        view.addSubview(testTableView)
        testTableView.reloadData()
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabDS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: timeCell)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        cell?.textLabel?.text = tabDS[indexPath.row]["title"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let claName = tabDS[indexPath.row]["class"]
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let cls = NSClassFromString(namespace + "." + claName!) as! UIViewController.Type
        let vc = cls.init()
        vc.title = tabDS[indexPath.row]["title"]
        self.navigationController?.pushViewController(vc, animated: true)

        print("\(indexPath.row)  :"+"\(#function)   "+"\(#file)")
    }
    
    //MARK: - other
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

