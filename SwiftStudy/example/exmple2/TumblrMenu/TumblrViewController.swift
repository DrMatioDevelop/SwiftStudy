//
//  TumblrViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class TumblrViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    func setupView() {
        view.layer.contents = UIImage(named: "8")?.cgImage
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(MenuViewController(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
