//
//  PushAnimation.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class PushAnimation: NSObject,UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    var transitionContext : UIViewControllerContextTransitioning?
    
    //转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    //转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //该参数包含了控制转场动必要的信息
        self.transitionContext = transitionContext
        //目标VC
        let toVC   = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        //当前VC
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        //容器View，转场动画都是在该容器中进行的，导航控制器的wrapper view就是该容器
        let containerView = transitionContext.containerView
        containerView.addSubview((fromVC?.view)!)
        containerView.addSubview((toVC?.view)!)
        
        let startPath = UIBezierPath(rect: CGRect(x: 0, y: KISSize.height / 2.0 - 2, width: KISSize.width, height: 4))
        let finalPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height))
        
        let masklayer = CAShapeLayer()
        masklayer.path = finalPath.cgPath
        toVC?.view.layer.mask = masklayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue   = finalPath.cgPath
        animation.duration  = transitionDuration(using: transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        masklayer.add(animation, forKey: "path")
        
    }
    
    //动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //通知transition完成，改方法一定要调用
        transitionContext?.completeTransition(!(transitionContext?.transitionWasCancelled)!)
        //清除fromVC的mask
        transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
        transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask   = nil
    }
}
