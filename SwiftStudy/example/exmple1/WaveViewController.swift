//
//  WaveViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class WaveViewController: BaseViewController {

    let wave = WaveView(frame: CGRect(x: 0, y: 200.0, width: KISSize.width, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setpView()
    }

    func setpView () {
        wave.waveSpeed = 10.0
        wave.angularSpeed = 1.5
        view.addSubview(wave)
        
        let whiteView = UIView(frame: CGRect(x: 0, y: 230, width: KISSize.width, height: KISSize.height - 230))
        whiteView.backgroundColor = UIColor.white
        view.addSubview(whiteView)
        
        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: KISSize.width-200, height: 30))
        btn.setTitle("开始", for: .normal)
        btn.setTitle("结束", for: .selected)
        btn.setTitleColor(.orange, for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(changeStatus(_:)), for: .touchUpInside)
    }
    
    func changeStatus(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? wave.startWaver() : wave.stopWaver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

class WaveView: UIView {
    var waveSpeed:   CGFloat = 1.8
    var angularSpeed:CGFloat = 2.0
    var waveColor:   UIColor = UIColor.red
    
    private var waveDisplayLink: CADisplayLink?
    private var offsetX : CGFloat = 0.0
    
    //CAShapeLayer:CALayer的子类，可以画出各种图形，配合UIBeizerPath使用最好
    private var waveShapeLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    
    func startWaver () {
        if waveShapeLayer != nil {return}
        
        waveShapeLayer = CAShapeLayer()
        waveShapeLayer?.fillColor = waveColor.cgColor
        layer.addSublayer(waveShapeLayer!)
        
        /*
         CADisplayLink:一个和屏幕刷新相同的定时器，需要以特定的模式注册到RunLoop中，每次屏幕刷新时会调用绑定target上的selector
         duration: 每帧之间的时间
         pause:暂停，设置true为暂停 false为继续
         
         结束是，需要调用invalidate方法，并且冲Runloop中删除之前绑定target的selector  并且不能被继承
         */
        waveDisplayLink = CADisplayLink(target: self, selector: #selector(keyFrameWave))
        waveDisplayLink?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
    }
    
    func stopWaver () {
        UIView.animate(withDuration: 1, animations: { 
            self.alpha = 0
        }) { (finished) in
            self.waveDisplayLink?.invalidate()
            self.waveDisplayLink = nil
            self.waveShapeLayer?.removeFromSuperlayer()
            self.waveShapeLayer = nil
            self.alpha = 1.0
        }
    }
    
    func keyFrameWave () {
        offsetX -= waveSpeed
        
        //创建path
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: self.KI_Height() / 2.0))
        
        var y : CGFloat = 0.0
        for x in stride(from: 0, to: self.KI_Width(), by: 1) {
            y = self.KI_Height() * sin(0.01 * (angularSpeed * x + offsetX))
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: self.KI_Width(), y: self.KI_Height()))
        path.addLine(to: CGPoint(x: 0, y: self.KI_Height()))
        
        path.closeSubpath()
        waveShapeLayer?.path = path
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code) has not been implemented")
    }
}


