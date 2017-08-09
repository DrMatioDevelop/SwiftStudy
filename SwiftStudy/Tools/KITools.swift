//
//  KITools.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/27.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import Foundation
import UIKit

let KIRect  : CGRect  = UIScreen.main.bounds
let KISSize : CGSize  = UIScreen.main.bounds.size
let KIScale : CGFloat = UIScreen.main.scale


let KIStateBarHeight     : CGFloat = 20.0
let KINavgationBarHeight : CGFloat = 44.0
let KINavAndStateBarH    : CGFloat = 64.0
let KITabBarHeight       : CGFloat = 49.0

//此随机色在运行的时候已经确定
let KIRandomColor : UIColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)

let iPhone4 : Bool = UIScreen.instancesRespond(to: #selector(getter: RunLoop.currentMode)) ? CGSize(width: 640, height: 960).equalTo((UIScreen.main.currentMode?.size)!) : false

extension UIView {
    func KI_Height() -> CGFloat {
        return self.frame.size.height
    }
    
    func setKI_Height(ki_height : CGFloat) {
        var tmp = self.frame
        tmp.size.height = ki_height
        self.frame = tmp
    }
    
    func KI_Width() -> CGFloat {
        return self.frame.size.width
    }
    
    func setKI_Width(ki_Width : CGFloat) {
        var tmp = self.frame
        tmp.size.width = ki_Width
        self.frame = tmp
    }
    
    func KI_X() -> CGFloat {
        return self.frame.origin.x
    }
    
    func setKI_X(ki_X : CGFloat) {
        var tmp = self.frame
        tmp.origin.x = ki_X
        self.frame = tmp
    }
    
    func KI_Y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func setKI_Y(ki_Y : CGFloat) {
        var tmp = self.frame
        tmp.origin.y = ki_Y
        self.frame = tmp
    }
    
    func KI_MaxX() -> CGFloat {
        return self.KI_X() + self.KI_Width()
    }
    
    func KI_MaxY() -> CGFloat {
        return self.KI_Y() + self.KI_Height()
    }
}

extension UILabel {
    func KI_LabFont () -> UIFont {
        return self.font
    }
}

extension UIButton {
    func KI_BtnFont() -> UIFont {
        return (self.titleLabel?.font)!
    }
}
