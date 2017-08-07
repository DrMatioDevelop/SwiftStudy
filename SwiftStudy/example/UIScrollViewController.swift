//
//  UIScrollViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/28.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class UIScrollViewController: BaseViewController, UIScrollViewDelegate {

    let imgScroll = UIScrollView(frame: CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: KISSize.height - KINavAndStateBarH))
    let images    = ["first", "second", "three"]
    let pageControl = UIPageControl(frame: CGRect(x: 0, y: KISSize.height  - 30.0, width: KISSize.width, height: 20.0))
    var currentPage = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        imgScroll.delegate   = self
        for (index, value) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: KISSize.width*CGFloat(index), y: 0, width: KISSize.width, height: imgScroll.KI_Height()))
            imageView.image = UIImage(named: value)
            
            imageView.clipsToBounds = true
            imageView.contentMode   = UIViewContentMode.scaleAspectFill
            
            imgScroll.addSubview(imageView)
        }
        imgScroll.delegate   = self
        imgScroll.isPagingEnabled = true
        imgScroll.contentSize     = CGSize(width: CGFloat(images.count) * KISSize.width, height:0)
        imgScroll.backgroundColor = UIColor.gray
        
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = images.count
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        
        view.addSubview(imgScroll)
        view.addSubview(pageControl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let number = Int(round(scrollView.contentOffset.x / KISSize.width))
        
        //由于swift是类型安全，所以通过逻辑比较时，需要两边的类型相同，不同类型需要先转换一下
        if number >= 0 && number <= images.count && number != currentPage {
            currentPage = number
            pageControl.currentPage = currentPage
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
