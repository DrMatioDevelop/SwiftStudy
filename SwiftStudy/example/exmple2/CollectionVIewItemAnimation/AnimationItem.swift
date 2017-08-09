//
//  AnimationItem.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit
private let imageRect = CGRect(x: 0, y: 0, width:itemAnimationSize.width , height: itemAnimationSize.height)
private let textRect  = CGRect(x: 0, y: itemAnimationSize.height - 40,  width:itemAnimationSize.width, height: 40)
class AnimationItem: UICollectionViewCell {

    let imageV  = UIImageView(frame: imageRect)
    let textV   = UITextView(frame: textRect)
    let backBtn = UIButton(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
    
    var backButtonTapped:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageV.contentMode = UIViewContentMode.center
        imageV.clipsToBounds = true
        
        textV.font = UIFont.systemFont(ofSize: 14)
        textV.isUserInteractionEnabled = true
        
        backBtn.setImage(UIImage(named: "Back-icon"), for: UIControlState.normal)
        backBtn.addTarget(self, action: #selector(backBtnTouch(btn:)), for: UIControlEvents.touchUpInside)
        backgroundColor = UIColor.gray
        
        addSubview(imageV)
        addSubview(textV)
        addSubview(backBtn)
    }
    
    func backBtnTouch(btn : UIButton) {
        backBtn.isHidden = true
        backButtonTapped!()
    }
    
    func handleCellSelected() {
        backBtn.isHidden = false
        superview?.bringSubview(toFront: self)
    }
    
    func prepareCell(model : animationItemModel) {
        imageV.frame = imageRect
        textV.frame  = textRect
        imageV.image = UIImage(named: model.imageName)
        textV.text   = model.title
        backBtn.isHidden = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(corder:) has  not been implemented")
    }
}
