//
//  UICollectionViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/7/28.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit
var itemSize = CGSize(width: KISSize.width - 80, height: KISSize.height * 0.618)

class UICollectionViewController: BaseViewController {

    let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: KINavAndStateBarH, width: KISSize.width, height: KISSize.height - KINavgationBarHeight))
    let data = UICollectionModel.createInterests()
    var collectionView : UICollectionView!
    let reuseIdentifier  = "CollectionTest"
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        backgroundImageView.image = UIImage(named: "blue")
        backgroundImageView.clipsToBounds = true
        backgroundImageView.isUserInteractionEnabled = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        flowLayout.minimumLineSpacing = 20.0
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        flowLayout.itemSize = itemSize
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: KISSize.width, height: KISSize.height * 0.618), collectionViewLayout: flowLayout)
        collectionView.center = view.center
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        visualEffectView.frame = backgroundImageView.bounds
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(visualEffectView)
        visualEffectView.addSubview(collectionView)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension UICollectionViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        item.data = self.data[indexPath.row]
        return item
    }
}
