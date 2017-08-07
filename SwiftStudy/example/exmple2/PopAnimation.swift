//
//  PopAnimation.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class PopAnimation: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    var transitionContext : UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let containerView = transitionContext.containerView
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview((fromVC?.view)!)
        
        let startPath = UIBezierPath(rect: CGRect(x: 0, y: KISSize.height / 2.0 - 2, width: KISSize.width, height: 4))
        let finalPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height))
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = finalPath.cgPath
        fromVC?.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = finalPath.cgPath
        animation.toValue   = startPath.cgPath
        animation.duration  = transitionDuration(using: transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate  = self
        maskLayer.add(animation, forKey: "path")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext?.completeTransition(!(transitionContext?.transitionWasCancelled)!)
        transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)?.view.layer.mask = nil
        transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
    }

}
