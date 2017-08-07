//
//  CustomPushViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/4.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class CustomPushViewController: BaseViewController, UINavigationControllerDelegate {

    //自定义专场动画，当前vc需要push 新的vc时，用该方法比较合适
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.contents = UIImage(named: "4")?.cgImage
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //设置自己成为导航栏的代理，同样可以用在别的controller的代理
        navigationController?.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = PushVC()
        navigationController?.pushViewController(vc, animated: true);
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.push {
            return PushAnimation()
        }
        else {
            return nil
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


//MARK: - pushVC
class PushVC : BaseViewController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.contents = UIImage(named: "8")?.cgImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //swift中 pop一个vc后，会返回该vc，如果忽略该返回值，会有一个警告，需要写上_, 相当于告诉编译器，知道有返回值 但不处理
        //其他带返回指定哦方法同样处理
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.pop {
            return PopAnimation()
        }
        else{
            return nil
        }
    }
}
