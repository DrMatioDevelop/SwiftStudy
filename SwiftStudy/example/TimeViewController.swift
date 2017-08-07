//
//  TimeViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/27.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import Foundation
import UIKit
class TimeViewController : BaseViewController {
    
    let showLable = UILabel(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height / 2.0))
    let beginBtn  = UIButton(frame: CGRect(x: 0, y:  KISSize.height / 2.0, width: KISSize.width/2.0, height: KISSize.height/2.0))
    let pauseBtn    = UIButton(frame: CGRect(x: KISSize.width/2.0, y:  KISSize.height / 2.0, width: KISSize.width/2.0, height: KISSize.height/2.0))
    
    var time : Timer?
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "时间"
        view.backgroundColor = UIColor.white
        setupView()
    }
    
    func setupView() {
        showLable.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        beginBtn.backgroundColor  = UIColor.red.withAlphaComponent(0.3)
        pauseBtn.backgroundColor  = UIColor.blue.withAlphaComponent(0.3)
        
        beginBtn.setTitle("开始", for: UIControlState.normal)
        beginBtn.setTitle("结束", for: UIControlState.selected)
        
        pauseBtn.setTitle("暂停", for: UIControlState.normal)
        pauseBtn.setTitle("继续", for: UIControlState.selected)
        
        
        [beginBtn, pauseBtn].forEach { (btn) in
            btn.addTarget(self, action: #selector(clickBtn(btn:)), for: UIControlEvents.touchUpInside)
        }
        
        showLable.text = "0"
        showLable.textColor = UIColor.white
        showLable.font      = UIFont.systemFont(ofSize: KISSize.height / 4.0)
        showLable.textAlignment = NSTextAlignment.center
        view.addSubview(showLable)
        view.addSubview(beginBtn)
        view.addSubview(pauseBtn)
    }
    
    
    func clickBtn(btn : UIButton) {
        switch btn {
        case beginBtn:
            beginBtn.isSelected  = !beginBtn.isSelected
            beginBtn.isSelected ? beginTime() : stopTime()
        case pauseBtn :
            pauseBtn.isSelected  = !pauseBtn.isSelected
            pauseBtn.isSelected ? pauseTime() : countTime()
        default:
            break
        }
    }
    
    func beginTime () {
        time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeLabel), userInfo: nil, repeats: true);
    }
    
    func stopTime () {
        count = 0
        showLable.text = String(count)
        time?.invalidate()
        time = nil
    }
    
    func pauseTime () {
        if !beginBtn.isSelected {
            return
        }
        time?.invalidate()
        time = nil;
    }
    
    func countTime () {
        if !beginBtn.isSelected {
            return
        }
        beginTime()
    }
    
    func changeLabel () {
        count += 1
        showLable.text = String(count)
    }

    
    //MARK: - Other
    override func didReceiveMemoryWarning() {
        
    }
}
