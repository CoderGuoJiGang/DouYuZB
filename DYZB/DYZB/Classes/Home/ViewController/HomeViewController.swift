//
//  HomeViewController.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/21.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40;

class HomeViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    fileprivate lazy var pageContentView : PagecontentView = { [weak self] in
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有自控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PagecontentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI()
    }
    



}

// MARK:-设置UI界面
extension HomeViewController{
    
  
    fileprivate func setupUI(){
        
        // 不需要调整UIscrollView.的内编剧
        automaticallyAdjustsScrollViewInsets = false
    
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加titleVIew
        view.addSubview(pageTitleView)
        
        // 3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    
    fileprivate func setupNavigationBar(){
    // 设置左边的item
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), forState: .Normal)
//        btn.sizeToFit()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        // 设置右边item
        let size = CGSize(width: 40, height: 40)
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage(named: "image_my_history"), forState: .Normal)
//        historyBtn.setImage(UIImage(named: "image_my_history_click"), forState: .Highlighted)
//        historyBtn.frame = CGRect(origin: CGPointZero, size: size)
//        let historyItem = UIBarButtonItem(customView: historyBtn)
//        let historyItem = UIBarButtonItem.createItem("image_my_history", highImage: "Image_my_history_click", size: size) // 类方法
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImage: "Image_my_history_click", size: size)
        
//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "btn_search"), forState: .Normal)
//        searchBtn.setImage(UIImage(named: "btn_search_click"), forState: .Highlighted)
//        searchBtn.frame = CGRect(origin: CGPointZero, size: size)
//        let searchItem = UIBarButtonItem(customView: searchBtn)
//         let searchItem = UIBarButtonItem.createItem("btn_search", highImage: "btn_search_clicked", size: size)
         let searchItem = UIBarButtonItem(imageName: "btn_search", highImage: "btn_search_clicked", size: size)
        
//        let qrcodeBtn = UIButton()
//        qrcodeBtn.setImage(UIImage(named: "Image_scan"), forState: .Normal)
//        qrcodeBtn.setImage(UIImage(named: "Image_scan_click"), forState: .Highlighted)
//        qrcodeBtn.frame = CGRect(origin: CGPointZero, size: size)
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
//        let qrcodeItem = UIBarButtonItem.createItem("Image_scan", highImage: "Image_scan_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImage: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
//        navigationItem.setRightBarButtonItems([historyItem,searchItem,qrcodeItem], animated: )
    }
}

// MARK: - 遵守pageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
            pageContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
}


// MARK: - 遵守pageContentViewDelegate
extension HomeViewController : PagecontentViewDelegate{
    func pageContentView(contentView: PagecontentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetInde: targetIndex)
    }
}
