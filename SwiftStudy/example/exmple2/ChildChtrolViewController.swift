//
//  ChildChtrolViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

let JumpNotification : String = "JUMP"

class ChildChtrolViewController: BaseViewController {

    var currentChildNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChild()
    }
    
    private func setupChild() {
        addChildViewController(ChlidAVC())
        addChildViewController(ChlidBVC())
        view.addSubview((childViewControllers.first?.view)!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(jump), name: NSNotification.Name(JumpNotification), object: nil)
    }
    
    func jump () {
        transition(from: currentChildNumber==0 ? childViewControllers.first! : childViewControllers.last!, to: currentChildNumber==0 ? childViewControllers.last! : childViewControllers.first!, duration: 1, options: currentChildNumber==0 ? UIViewAnimationOptions.transitionFlipFromLeft : UIViewAnimationOptions.transitionFlipFromTop, animations: nil, completion: nil)
        currentChildNumber = currentChildNumber==0 ? 1 : 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(JumpNotification), object: nil)
    }
}

//MARK: - ChlidAVC
class ChlidAVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(jump))
        view.addGestureRecognizer(tap)
    }
    
    func jump () {
      NotificationCenter.default.post(name: Notification.Name(JumpNotification), object: nil)
    }
}


//MARK: - ChlidBVC
class ChlidBVC:BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        let tap = UITapGestureRecognizer(target: self, action: #selector(jump))
        view.addGestureRecognizer(tap)
    }
    
    func jump () {
        NotificationCenter.default.post(name: Notification.Name(JumpNotification), object: nil)
    }
}
