//
//  CollecItemAnimationViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

let itemAnimationSize = CGSize(width:KISSize.width - 20.0 , height: KISSize.height/3.0 - 20.0)

class CollecItemAnimationViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private var animationCollectionView : UICollectionView!
    var dsArray = animationItemModel.getData()
    private let reuseIdentifier = String(describing: AnimationItem.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        collectionFlowLayout.itemSize = itemAnimationSize
        collectionFlowLayout.minimumLineSpacing  = 10
        collectionFlowLayout.minimumInteritemSpacing = 10
        
        animationCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionFlowLayout)
        animationCollectionView.backgroundColor = UIColor.lightGray
        animationCollectionView.dataSource = self
        animationCollectionView.delegate   = self
        animationCollectionView.register(AnimationItem.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(animationCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dsArray?.count)!;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnimationItem
        item.prepareCell(model: (dsArray?[indexPath.row])!)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !collectionView.isScrollEnabled {
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimationItem else {
            return
        }
        
        collectionView.isScrollEnabled = false
        cell.handleCellSelected()
        cell.backButtonTapped = {
            print("闭包执行")
            collectionView.isScrollEnabled = true
            collectionView.reloadItems(at: [indexPath])
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { 
            
            cell.frame = CGRect(x: 10, y: self.animationCollectionView.contentOffset.y + KINavAndStateBarH, width: self.animationCollectionView.KI_Width(), height: KISSize.height - KINavAndStateBarH)
            cell.imageV.frame = cell.bounds
            cell.textV.frame = CGRect(x: 0, y: cell.imageV.KI_Height() - 60.0, width: self.animationCollectionView.KI_Width(), height: 60)
            
        }) { (finished) in
            print("动画结束")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


struct animationItemModel {
    let imageName : String
    let title     : String
    
    init(imageName: String?, title: String?) {
        self.imageName = imageName ?? ""
        self.title     = title     ?? "没有title"
    }
    
    static func getData() -> [animationItemModel]? {
        let txt = "Hedge fund billionaire Bill Ackman was humbled in 2015. His Pershing Square Capital Management had a terrible year, posting a -19.3% gross return."
        let imageNames = ["item_1","item_2","item_3","item_4","item_5"]
        let titles = Array(repeating: txt, count: imageNames.count)
        var result = [animationItemModel]()
        
        for (index, name) in imageNames.enumerated() {
            result.append(animationItemModel(imageName: name, title: titles[index]))
        }
        return result

    }
}
