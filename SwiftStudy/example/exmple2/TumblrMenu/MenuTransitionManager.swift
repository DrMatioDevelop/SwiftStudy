//
//  MenuTransitionManager.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit
//MARK: - 出现上面先动的效果是 上中下的偏移量不同 与其他没有关系
class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    private var presenting = false
    
    func offStage(amount : CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    //关
    func offStageMenuController(menuVC : MenuViewController) {
        menuVC.view.alpha = 0;
        
        let topRowOffect : CGFloat = 300
        let middleRowOffect : CGFloat = 150
        let bottomRowOffect : CGFloat = 50
        
        menuVC.btns[0].transform = offStage(amount: -topRowOffect)
        menuVC.btns[1].transform = offStage(amount: topRowOffect)
        menuVC.btns[2].transform = offStage(amount: -middleRowOffect)
        menuVC.btns[3].transform = offStage(amount: middleRowOffect)
        menuVC.btns[4].transform = offStage(amount: -bottomRowOffect)
        menuVC.btns[5].transform = offStage(amount: bottomRowOffect)
    }
    
    func onStageMenuController(menuVC : MenuViewController) {
        menuVC.view.alpha = 1
        
        for btn in menuVC.btns {
            btn.transform = CGAffineTransform.identity
        }
        
    }
    
    //MARK: - UIViewControllerAnimatedTransitioning
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let screens : (from : UIViewController, to : UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        let menuVC = !presenting ? screens.from as! MenuViewController :screens.to as! MenuViewController
        let bottomVC = !presenting ? screens.to : screens.from
        
        let menuView   = menuVC.view
        let bottomView = bottomVC.view
        
        if self.presenting {
            offStageMenuController(menuVC: menuVC)
        }
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.7, //弹簧效果 范围0-1.0 值越小震动效果约明显
                       initialSpringVelocity: 0.8,  //初始速度 数值越大开始移动的速度越快，初速取值高，时间短的时候会有反弹
                       options: [],
                       animations: {
                        
                        self.presenting ? self.onStageMenuController(menuVC: menuVC) : self.offStageMenuController(menuVC: menuVC)
                        
        }) { (finished) in
                transitionContext.completeTransition(true)
            if self.presenting {
                UIApplication.shared.keyWindow?.addSubview(screens.from.view)
            }
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
        }
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
}
