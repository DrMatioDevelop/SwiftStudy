//
//  ColorProgressViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/2.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

/// stride 可变步长的函数
class ColorProgressViewController: BaseViewController {

    let colorProgress = ColorProgress(frame: CGRect(x: 20, y: 200, width: KISSize.width-40, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseAnimation()
        
        view.addSubview(colorProgress)
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
                self.colorProgress.progress += 0.08
                if self.colorProgress.progress >= 1.0 {
                    time.invalidate()
                }
            }
        } else {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeEvent(time:)), userInfo: nil, repeats: true)
        }
    }
    
    func timeEvent (time : Timer) {
        self.colorProgress.progress += 0.08
        if self.colorProgress.progress >= 1.0 {
            time.invalidate()
        }
    }

    /*
     *  参考http://www.jianshu.com/p/91fccd32f6fb
     *   kCAFillModeForwards  过了开始时间之后  才会进入到动画开始状态 并且在RemovedOnCompletion 为false时在结束位置
     *   kCAFillModeBackwards 已开始就进入到    动画开始状态   并且RemovedOnCompletion为false时也会返回到开始位置
     *  
     *   CACurrentMediaTime() 图层的当前时间
     */
    func baseAnimation () {
        let testLayer = CALayer()
        testLayer.frame = CGRect(x: 0, y: 300, width: 50.0, height: 50.0)
        testLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(testLayer)

        //此处keypath为基础动画的 基本属性  单位时间内变化的属性
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.beginTime = CACurrentMediaTime() + 2
        animation.fromValue = 0
        animation.toValue   = 300
        animation.duration  = 2
        animation.fillMode  = kCAFillModeForwards
//        animation.isRemovedOnCompletion = false
        testLayer.add(animation, forKey: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


class ColorProgress: UIView, CAAnimationDelegate {
    
    let graditentLayer = CAGradientLayer()
    let maskLayer      = CALayer()
    
    var progress : CGFloat = 0.0 {
        didSet {
            changeMaskFrame()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView () {
        let whiteBGLayer = CALayer()
        whiteBGLayer.frame = self.bounds
        whiteBGLayer.cornerRadius = self.bounds.size.height / 2.0
        whiteBGLayer.borderColor  = UIColor.blue.cgColor
        whiteBGLayer.borderWidth  = 1.0
        
        layer.addSublayer(whiteBGLayer)
        
        graditentLayer.frame = self.bounds
        graditentLayer.cornerRadius = self.bounds.size.height / 2.0
        graditentLayer.borderColor  = UIColor.white.cgColor
        graditentLayer.borderWidth  = 1.0
        
        var colors = [CGColor]()
        for hue in stride(from: 0, to: 360, by: 5) {
            let color = UIColor(hue: CGFloat(hue) / 360.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            colors.append(color)
        }
        
        graditentLayer.colors = colors
        graditentLayer.startPoint = CGPoint(x: 0, y: 0.5)
        graditentLayer.endPoint   = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(graditentLayer)
        
        //添加显示区域
        changeMaskFrame()
        maskLayer.cornerRadius = bounds.size.height / 2.0
        maskLayer.backgroundColor = UIColor.white.cgColor
        graditentLayer.mask = maskLayer
        
        //动画
        prefromAnimation()
        
    }
    
    private func changeMaskFrame () {
        maskLayer.frame = CGRect(x: 0, y: 0, width: progress*bounds.size.width, height: bounds.size.height)
    }
    
    private func prefromAnimation () {
        var colors = graditentLayer.colors
        //移除最后一个元素  并且返回移除的元素
        let color  = colors?.popLast() as! CGColor
        colors?.insert(color, at: 0)
        
        
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = graditentLayer.colors
        animation.toValue = colors
        animation.duration = 0.08
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        graditentLayer.add(animation, forKey: "gradient")
    }
    
    //动画停止后继续动画
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if progress <= 1.0 {
            prefromAnimation()
        }
    }
}
