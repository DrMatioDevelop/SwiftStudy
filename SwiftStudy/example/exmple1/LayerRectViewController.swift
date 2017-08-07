//
//  LayerRectViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/3.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class LayerRectViewController: BaseViewController {

    let btn1 = UIButton(frame: CGRect(x: 100, y: 200, width: KISSize.width - 200, height: 30))
    let btn2 = UIButton(frame: CGRect(x: 100, y: 300, width: KISSize.width - 200, height: 30))
    var drawView = DrawRectView(frame: CGRect(x: 0, y: 64, width: KISSize.width, height: KISSize.height - KINavAndStateBarH))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        title = "画图与动画"
        view.backgroundColor = .white
        
        btn1.setTitle("DrawRect", for: .normal)
        btn1.setTitleColor(.orange, for: .normal)
        btn2.setTitle("CAShapeLayer", for: .normal)
        btn2.setTitleColor(.orange, for: .normal)
        
        btn1.addTarget(self, action: #selector(showView), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(showView), for: .touchUpInside)
        
        view.addSubview(btn1)
        view.addSubview(btn2)
    }
    
    func showView(_ sender: UIButton) {
        if sender.currentTitle == "DrawRect" {
            print("采用drawrect画图")
            view.addSubview(drawView)
        }else {
            print("采用cashapelayer")
            navigationController?.pushViewController(ShapLayerViewController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



//MARK: - DrawRect
class DrawRectView: UIView {
    
    var tap : UITapGestureRecognizer?
    
    override func draw(_ rect: CGRect) {
        if tap == nil {
            tap = UITapGestureRecognizer(target: self, action: #selector(removeSelf))
        }
        
        simpleDraw()
        
        pathARC()
        
        pathTriangle()
        
        pathSecondBezier()
    }
    
    
    func removeSelf () {
        self.removeFromSuperview()
    }
    
    private func simpleDraw () {
        let path = UIBezierPath(roundedRect: CGRect(x: 20.0, y: 20.0, width: 100.0, height: 100.0), cornerRadius: 20)
        path.lineWidth = 5
        UIColor.green.set()
        path.fill()
        UIColor.red.set()
        path.stroke()
    }
    
    //圆弧
    private func pathARC () {
        let path = UIBezierPath(arcCenter: CGPoint(x: 20, y: 150.0), radius: 100, startAngle: 0, endAngle: CGFloat(M_PI * 90 / 180), clockwise: true)
        path.lineCapStyle  = CGLineCap.round
        path.lineJoinStyle = CGLineJoin.round
        
        UIColor.red.set()
        path.stroke()
    }
    
    private func pathTriangle () {
        let path = UIBezierPath()
        //起点
        path.move(to: CGPoint(x: 20, y: 300))
        path.addLine(to: CGPoint(x: 150, y: 400))
        path.addLine(to: CGPoint(x: 20, y: 400))
        path.close()
        
        path.lineWidth = 5
        
        UIColor.green.set()
        path.fill()
        
        UIColor.red.set()
        path.stroke()
    }
    
    private func pathSecondBezier () {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 200, y: 150))
        path.addQuadCurve(to: CGPoint(x: 200, y: 300), controlPoint: CGPoint(x: 50, y: 50))
        path.lineWidth = 5
        
        UIColor.red.set()
        path.stroke()
    }
    
}
