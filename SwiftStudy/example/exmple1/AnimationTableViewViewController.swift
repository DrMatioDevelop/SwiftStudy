//
//  AnimationTableViewViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class AnimationTableViewViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    let tableData = ["Read 3 article on Medium", "Cleanup bedroom", "Go for a run", "Hit the gym", "Build another swift project", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom"]
    let animationTableView = UITableView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height), style: UITableViewStyle.plain)
    let reuseIdentifier = "animationCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAnimationOfTableView()
    }
    
    func setupView () {
        animationTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        animationTableView.delegate   = self
        animationTableView.dataSource = self
        animationTableView.tableFooterView = UIView()
        animationTableView .register(AnimationTableCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(animationTableView)
    }
    
    func setAnimationOfTableView () {
        animationTableView.reloadData()
        
        //所有可见的cell
        let cells = animationTableView.visibleCells
        let tableViewHeight = animationTableView.KI_Height()
        
        for (index , cell) in cells.enumerated() {
            //设置cell的动画起始位置
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            UIView.animate(withDuration: 1.0,
                           delay: 0.05 * Double(index),
                           usingSpringWithDamping: 0.8,   //弹簧效果0.0-1.0 值越小震动效果越明显
                           initialSpringVelocity: 0,      //表示初始速度 数值越大开始移动的速度越快  初速取值高时间较短  也会出现反弹的情况
                           options: [],
                           animations: {
                        //动画结束位置
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }
    
    func colorForIndex(index : Int) -> UIColor {
        let itemCount = tableData.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.textLabel?.text = tableData[indexPath.row]
        cell?.textLabel?.textColor = .white
        cell?.textLabel?.backgroundColor = .clear
        cell?.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell?.selectionStyle = .gray
        return cell!;
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class AnimationTableCell : UITableViewCell {
    let gradientLayer = CAGradientLayer()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //让颜色过渡起来  给人一种存在分割线的感觉
        gradientLayer.frame = self.bounds
        let color1 = UIColor(white: 1.0, alpha: 0.2).cgColor
        let color2 = UIColor(white: 1.0, alpha: 0.1).cgColor
        let color3 = UIColor.clear.cgColor
        let color4 = UIColor(white: 0.0, alpha: 0.05).cgColor
        
        gradientLayer.colors = [color1,color2,color3,color4]
        gradientLayer.locations = [0,0.04,0.98,0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    

}
