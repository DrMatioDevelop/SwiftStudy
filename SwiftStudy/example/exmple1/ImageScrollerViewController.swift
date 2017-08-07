//
//  ImageScrollerViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/2.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit


/// 对图片的缩放需要设置 zoomScale比例 改变图片的边距
class ImageScrollerViewController: BaseViewController {

    let scrollView = UIScrollView(frame: CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: KISSize.height - KINavAndStateBarH))
    let imageView  = UIImageView(image: UIImage(named: "Steve"))
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func loadView() {
        super.loadView()
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        setupBG()
        setupScrollView()
        setZoomScaleFor(scroVllViewSize: scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        recenterImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        setZoomScaleFor(scroVllViewSize: scrollView.bounds.size)
        if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
        recenterImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    

    
    /// 设置背景图
    func setupBG() {
        view.layer.contents = UIImage(named: "Steve")?.cgImage
        let visul = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        visul.frame = CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height)
        view.addSubview(visul)
    }
    
    //设施背景滚动视图
    func setupScrollView () {
        /*
         *  flexibleLeftMargin  自动调整view与父视图左边距，保证右边距不变
         *  flexibleWidth       自动调整view的宽度，保证左边和右边不变
         *  flexibleHeight      自动调整view的高度，保证上边和右边不变
         *  flexibleRightMargin 自动调整view与父视图右边距，保证左边距不变
         *  flexibleTopMargin   自动调整view与父视图的上边距，以保证下边距不变
         *  flexibleBottomMargin自动调整view与父视图的下边距，已保证上边距不变
         */
        
        scrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        scrollView.backgroundColor  = UIColor.clear
        scrollView.contentSize      = imageView.bounds.size
        scrollView.delegate         = self
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
    }
    
    
    /// 设置缩放
    ///
    /// - Parameter scroVllViewSize: <#scroVllViewSize description#>
    func setZoomScaleFor(scroVllViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        
        let widthScale  = scroVllViewSize.width  / imageSize.width
        let heightScale = scroVllViewSize.height / imageSize.height
        
        let minimunScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minimunScale
        scrollView.maximumZoomScale = 10
    }
    
    
    /// 重新定位image
    func recenterImage () {
        let scrollVIewSize = scrollView.bounds.size
        let imageViewSize  = imageView.frame.size
        
        let horizontalSpace = imageViewSize.width  < scrollVIewSize.width ? (scrollVIewSize.width - imageViewSize.width) / 2.0 : 0
        let verticalSpace   = imageViewSize.height < scrollVIewSize.height ? (scrollVIewSize.height - imageViewSize.height) / 2.0 : 0
        
        scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace)
        
//        print("scrollView X:\(scrollView.KI_X()) scrollView Y:\(scrollView.KI_Y()) scrollView Width:\(scrollView.KI_Width()) scrollView Height:\(scrollView.KI_Height())")
        
        print("contentInset top:\(scrollView.contentInset.top) contentInset left:\(scrollView.contentInset.left) contentInset bottom:\(scrollView.contentInset.bottom) contentInset Right:\(scrollView.contentInset.right)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ImageScrollerViewController: UIScrollViewDelegate {
    //需要缩放时，返回需要缩放的view
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    //缩放后调用
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
    
}
