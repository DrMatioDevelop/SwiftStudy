//
//  TableViewHeadViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/2.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

let headViewHeight = KISSize.height / 3.0

class TableViewHeadViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let datas = ["下","拉","可","以","出","现","很","神","奇","的","事","情","yo","yo","yo","yo","yo","yo"]
    let tableView = UITableView(frame: CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: KISSize.height - KINavAndStateBarH), style: UITableViewStyle.plain)
    let reuseIdentifier = "customCell"
    let headView = UIImageView(frame: CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: headViewHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        headView.backgroundColor = UIColor.white
        headView.contentMode = UIViewContentMode.scaleAspectFill
//        view.addSubview(headView)
        
        let url = URL(string: "http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg")
        
        let task =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let _  = data, error == nil else {return}
            
            DispatchQueue.main.sync {
                self.headView.image = UIImage(data: data!)
            }
        }

        task.resume()
        
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.tableFooterView = UIView()
        
        //这个地方与didScrolle偏移量除以2有关系
        tableView.contentInset.top = headViewHeight
        tableView.contentOffset = CGPoint(x: 0.0, y: -headViewHeight)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        view.addSubview(tableView)
        view.sendSubview(toBack: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.textLabel?.text = datas[indexPath.row]
        cell?.textLabel?.textColor = UIColor.black
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offectY = scrollView.contentOffset.y + scrollView.contentInset.top
        if offectY <= 0 {
            headView.frame = CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: headViewHeight + ( -offectY))
        }
        else {
            print("offect:\(scrollView.contentOffset.y)  offectY:\(offectY)  offectY2:\(offectY/2.0)")
            let height = (headViewHeight - offectY) < 0.0 ? 0.0 : headViewHeight - offectY
            headView.frame = CGRect(x: 0.0, y: KINavAndStateBarH - offectY / 2.0, width: KISSize.width, height: height)
            headView.alpha = height / headViewHeight
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
