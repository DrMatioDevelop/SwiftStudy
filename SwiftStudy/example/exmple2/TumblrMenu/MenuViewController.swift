//
//  MenuViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {

    var btns = [UIButton]()
    let transitionManager = MenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        transitioningDelegate = transitionManager
        view.backgroundColor  = UIColor(white: 1, alpha: 0.5)
        
        let width  : CGFloat = KISSize.width / 2.0
        let height : CGFloat = KISSize.height / 3.0
        let names  = ["Audio", "Chat", "Link", "Photo", "Quote","Text"];
        
        for index in 0...5 {
            let rect = CGRect(x: width * CGFloat(index%2), y: height * CGFloat(index / 2), width: width, height: height)
            let btn  = UIButton(frame: rect)
            
            btn.setTitle(names[index], for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn.setImage(UIImage(named: names[index]), for: UIControlState.normal)
            
            view.addSubview(btn)
            btn.aliginContentVerticallyByCenter()
            btn.addTarget(self, action: #selector(dismissView), for: UIControlEvents.touchUpInside)
            btns.append(btn)
        }
    }
    
    func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIButton {
    //设置按钮图片在上，文字在下的效果
    func aliginContentVerticallyByCenter () {
        contentVerticalAlignment   = UIControlContentVerticalAlignment.center
        contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        //图片与title之间有一个默认的间隔10
        let offect: CGFloat = 10
        
        //在有的ios版本上，会出现获得不到frame的情况，加上下面这两句会100%得到
        titleLabel?.backgroundColor = backgroundColor
        imageView?.backgroundColor  = backgroundColor
        
        //title
        let titleWidth  = titleLabel?.frame.size.width
        let titleHeight = titleLabel?.frame.size.height
        let titleLef = titleLabel?.frame.origin.x
        let titlerig = frame.size.width - titleWidth! - titleLef!
        
        //img
        let imageWidth  = imageView?.frame.size.width
        let imageHeight = imageView?.frame.size.height
        let imageLef    = imageView?.frame.origin.x
        let imageRig    = frame.size.width - imageWidth! - imageLef!
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageLef!, bottom: titleHeight!, right: -imageRig)
        titleEdgeInsets = UIEdgeInsets(top: imageHeight! + offect, left: -titleLef!, bottom: 0, right: -titlerig)
        
    }
}
