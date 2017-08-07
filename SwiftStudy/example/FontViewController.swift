//
//  FontViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/28.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit


/*
 *  1.下载ttf文件，加入项目
 *  2.在info.plist文件添加一个字段 ： Fonts provided by application  （Array）
 *  3.添加item 写入字体的名字(全名)
 *  4.使用
 */
class FontViewController: BaseViewController,UITableViewDelegate, UITableViewDataSource {

    let fontTableView = UITableView(frame: CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: KISSize.height * 2 / 3.0 - KINavAndStateBarH), style: UITableViewStyle.plain)
    let button = UIButton(type: UIButtonType.system)
    
    let fontDS = ["点击一下改变字体，","字体就会改变，","不相信么，","点一下试试吧😊！"]
    let fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "Heiti SC"]
    
    var fontNumber = 0
    let cellIndentifier = "fongCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView () {
        fontTableView.delegate   = self;
        fontTableView.dataSource = self;
        fontTableView.backgroundColor = .black
        
        button.setTitle("改变字体", for: UIControlState.normal)
        button.backgroundColor = UIColor.orange
        button .addTarget(self, action: #selector(changeFont), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: fontTableView.KI_MaxY(), width: view.KI_Width(), height: KISSize.height - fontTableView.KI_MaxY())
        view.addSubview(button)
        view.addSubview(fontTableView)
    }
    
    func changeFont (btn : UIButton) {
        fontNumber = (fontNumber + 1)%fontNames.count
        button.titleLabel?.font = UIFont(name: fontNames[fontNumber], size: 24)
        print(fontNumber)
        fontTableView .reloadData()
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontDS.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         /*
          * ?? 空合运算符， a??b 对可选类型a 进行判断，为nil默认值为b，不为空就解封
          */
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIndentifier)
        
        cell.textLabel?.text = fontDS[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: fontNames[fontNumber], size: 24)
        cell.backgroundColor = UIColor.black
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fontTableView.KI_Height() / 4.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        let str = "当前字体是:"+(cell?.textLabel?.font.fontName)!
        print(str)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
