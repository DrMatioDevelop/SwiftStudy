//
//  GradientViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/31.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class GradientViewController: BaseViewController {

    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func setupGradientLayer () {
        gradientLayer.frame = CGRect(x: 10.0, y: KINavAndStateBarH, width: KISSize.width - 20.0, height: KISSize.height - KINavAndStateBarH)
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor
        
        gradientLayer.colors = [color1,color2,color3,color4,color5]
        gradientLayer.locations = [0.1,0.3,0.5,0.7,1.0]
        
        //颜色 可以是多个
        gradientLayer.colors = [UIColor.white.cgColor,UIColor.red.cgColor]
        //颜色对应的范围 是gradientLayer的比例范围
        gradientLayer.locations = [0.5,1]
        
        //开始的点
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        //结束的点
        gradientLayer.endPoint   = CGPoint(x: 1.0, y: 1.0)
        view.layer.addSublayer(gradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
