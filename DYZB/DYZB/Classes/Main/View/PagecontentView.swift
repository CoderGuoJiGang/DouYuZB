//
//  PagecontentView.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/25.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit

private let collectionCellID = "collectionCellID"

class PagecontentView: UIView {

    private var childVc : [UIViewController]
    private var parentVc : UIViewController
    
    // MARK:- 懒加载属性
    private lazy var collection:UICollectionView = {
    // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .Horizontal
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        return collectionView
    }()
    
    
    
// 自定义构造函数
    init(frame: CGRect,childVcs : [UIViewController] , parentVc : UIViewController) {
        self.childVc = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        setupUI()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI
extension PagecontentView{
    private func setupUI(){
        // 1.将所有的自控制器添加到福控制器
        for child in childVc{
            parentVc.addChildViewController(child)
        }
        
        // 2.添加一个UICollectionView,用于cell中存自控制器view
        addSubview(collection)
        collection.frame = bounds
    }
}

// MArk:- UICollectionViewDElegate
extension PagecontentView:UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVc.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath)
        // cell内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let chidrVc = childVc[indexPath.row]
        chidrVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chidrVc.view)
        
        return cell
        
    }
}