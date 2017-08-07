//
//  PickerViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit


let pickerViewRect = CGRect(x: 0, y: KISSize.height / 3.0, width: KISSize.width, height: KISSize.height / 3.0)
let showlabelRect  = CGRect(x: 0, y: 20, width: KISSize.width, height: KISSize.height/3.0 - 20.0);
let brnRect        = CGRect(x: 40, y: pickerViewRect.origin.y + pickerViewRect.size.height + 30, width: KISSize.width - 80, height: 30.0)

class PickerViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let pickerView = UIPickerView(frame: pickerViewRect)
    let showLabel  = UILabel(frame: showlabelRect)
    let btn        = UIButton(frame: brnRect)
    
    let hours = 0...23
    let mins  = 0...59
    let secs  = 0...59
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
   
    func setupView () {
        pickerView.delegate   = self
        pickerView.dataSource = self
        pickerView.selectRow(0, inComponent: 0, animated: true)
        
        
        showLabel.textColor     = UIColor.orange
        showLabel.textAlignment = NSTextAlignment.center
        showLabel.font          = UIFont.systemFont(ofSize: 20)
        
        btn.setTitle("随机选择", for: UIControlState.normal)
        btn.setTitleColor(UIColor.orange, for: UIControlState.normal)
        btn.titleLabel?.font    = UIFont.systemFont(ofSize: 30.0)
        btn.addTarget(self, action: #selector(randomTime), for: UIControlEvents.touchUpInside)
        
        view.addSubview(pickerView)
        view.addSubview(showLabel)
        view.addSubview(btn)
    
    }
    
    func randomTime () {
        pickerView.selectRow(Int(arc4random())%hours.count, inComponent: 0, animated: true)
        pickerView.selectRow(Int(arc4random())%mins.count, inComponent: 1, animated: true)
        pickerView.selectRow(Int(arc4random())%secs.count, inComponent: 2, animated: true)

    }
    
    func changeLabelTitle () {
        showLabel.text = "\(pickerView.selectedRow(inComponent: 0))时 \(pickerView.selectedRow(inComponent: 1))分  \(pickerView.selectedRow(inComponent: 2)) 秒"
    }
    
    
    
    //MARK: - UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return mins.count
        default:
            return secs.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return KISSize.width / 3.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        changeLabelTitle()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

        let pickerLabel = UILabel()
        switch component {
        case 0:
            pickerLabel.text = String(Array(hours)[row])+"时"
        case 1:
            pickerLabel.text = String(Array(mins)[row])+"分"
        default:
            pickerLabel.text = String(Array(secs)[row])+"秒"
        }
        pickerLabel.textColor = UIColor.green
        pickerLabel.font      = UIFont.systemFont(ofSize: 18)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
