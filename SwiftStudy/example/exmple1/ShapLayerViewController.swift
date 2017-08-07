//
//  ShapLayerViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class ShapLayerViewController: BaseViewController, CAAnimationDelegate {

    let centerX : Double = 200.0
    let centerY : Double = 300.0
    
    private let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Shapelayer 动画"
        setupView()
    }

    private func setupView () {
        shapeLayer.fillColor = UIColor.clear.cgColor //填充颜色
        shapeLayer.lineWidth = 20.0
        shapeLayer.lineCap   = "round"  //线条风格
        shapeLayer.lineJoin  = "round"  //连接风格
        shapeLayer.strokeColor = UIColor.red.cgColor //线条颜色
        view.layer.addSublayer(shapeLayer)
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: 80, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: false)
        //关联layer和贝塞尔曲线
        shapeLayer.path = path.cgPath
        //创建动画， strokEnd属性
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue   = 1.0
        shapeLayer.autoreverses = false
        animation.duration  = 3.0
        
        //设置动画
        shapeLayer.add(animation, forKey: nil)
        animation.delegate = self
        
        //外围16根
        let count = 16
        for i in 0..<count {
            let line = CAShapeLayer()
            line.fillColor = UIColor.clear.cgColor
            line.strokeColor = UIColor.yellow.cgColor
            line.lineWidth  = 15.0
            line.lineCap    = "round"
            line.lineJoin   = "round"
            view.layer.addSublayer(line)
            
            let path2 = UIBezierPath()
            let x = centerX + 100*cos(2.0*Double(i) * M_PI / Double(count))
            let y = centerY - 100*sin(2.0*Double(i) * M_PI / Double(count))
            let len = 50
            
            path2.move(to: CGPoint(x: x, y: y))
            path2.addLine(to: CGPoint(x: x+Double(len)*cos(2*M_PI/Double(count)*Double(i)), y: y-Double(len)*sin(2*M_PI/Double(count)*Double(i))))
            line.path = path2.cgPath
            line.add(animation, forKey: nil)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //结束后设置整个填充为红色
         shapeLayer.fillColor = UIColor.red.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
