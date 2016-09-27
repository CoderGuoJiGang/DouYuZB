//
//  PagecontentView.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/25.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit

protocol PagecontentViewDelegate : class {
    func pageContentView(contentView : PagecontentView, progress : CGFloat, sourceIndex: Int,targetIndex : Int)
}

private let collectionCellID = "collectionCellID"

class PagecontentView: UIView {

    fileprivate var childVc : [UIViewController]
    fileprivate weak var parentVc : UIViewController? // weak修饰的须为可选类型
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    weak var delegate : PagecontentViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collection:UICollectionView = { [weak self] in
    // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        return collectionView
    }()
    
    
    
// 自定义构造函数
    init(frame: CGRect,childVcs : [UIViewController] , parentVc : UIViewController?) {
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
    fileprivate func setupUI(){
        // 1.将所有的自控制器添加到福控制器
        for child in childVc{
            parentVc?.addChildViewController(child) // 可选类型可选链
        }
        
        // 2.添加一个UICollectionView,用于cell中存自控制器view
        addSubview(collection)
        collection.frame = bounds
    }
}

// MArk:- UICollectionViewDatasource
extension PagecontentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVc.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        // cell内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let chidrVc = childVc[(indexPath as NSIndexPath).row]
        chidrVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(chidrVc.view)
        
        return cell
        
    }
}

// MARK: - UICollectionViewDelegate
extension PagecontentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 判断是否是点击事件
        if isForbidScrollDelegate {return}
        
        // 1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断左划还是右
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左划
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // targetIndex 
             targetIndex = sourceIndex + 1
            if targetIndex >= childVc.count {
                targetIndex = childVc.count - 1
            }
            // 如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVc.count {
                sourceIndex = childVc.count - 1
            }
        }
        // 将progress--sourceIndex--targetIndex传递给titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - 对外暴露方法
extension PagecontentView{
   public func setCurrentIndex(currentIndex : Int){
    
    // 记录需要禁止代理方法
    isForbidScrollDelegate = true
    
        let offSetX = CGFloat(currentIndex) * collection.frame.width
    collection.setContentOffset(CGPoint(x: offSetX,y:0), animated: false)
    }
}
