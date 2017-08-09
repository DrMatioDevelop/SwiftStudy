//
//  SortableViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/7.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

class SortableViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, SortableCollectionViewDelegate {

    var sortableView : SortableCollectionView!
    var timer : Timer?
    let reuseIdentiufier = String(describing: sortableItem.self)
    
    var data = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        for _ in 0...40 {
            let color = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            data.append(color)
        }
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = UICollectionViewScrollDirection.vertical
        flowlayout.itemSize = CGSize(width: (KISSize.width - 40.0) / 3.0, height: (KISSize.width - 40.0) / 3.0)
        flowlayout.minimumLineSpacing = 5
        flowlayout.minimumInteritemSpacing = 5
        flowlayout.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)
        
        sortableView = SortableCollectionView(frame: view.bounds, collectionViewLayout: flowlayout)
        sortableView.backgroundColor = UIColor.white
        sortableView.dataSource = self
        sortableView.delegate   = self
        sortableView.sortableDelegate = self
        sortableView.register(sortableItem.self, forCellWithReuseIdentifier: reuseIdentiufier)
        view.addSubview(sortableView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentiufier, for: indexPath) as! sortableItem
        cell.backgroundColor = data[indexPath.row]
        cell.setSortable(model: indexPath.row)
        return cell
    }
    
    //改变数据
    func exchangeDataSource(fromIndex: IndexPath, toIndex: IndexPath) {
        let tmp = data[fromIndex.row]
        data[fromIndex.row] = data[toIndex.row]
        data[toIndex.row] = tmp
    }
    
    //开始拖动
    func beginDragAndInitDragCell(collectionView: SortableCollectionView, dragCell: UIView) {
        dragCell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        dragCell.backgroundColor = UIColor.lightGray
    }
    
    //拖动结束
    func endDragAndResetDragCell(collectionView: SortableCollectionView, dragCell: UIView) {
        dragCell.transform = CGAffineTransform(scaleX: 1, y: 1)
        dragCell.backgroundColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
