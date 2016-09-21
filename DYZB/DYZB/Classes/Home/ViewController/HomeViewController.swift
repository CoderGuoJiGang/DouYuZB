//
//  HomeViewController.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/21.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI界面
        setupUI()
    }
    



}

// MARK:-设置UI界面
extension HomeViewController{
    
  
    private func setupUI(){
    
        // 设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
    // 设置左边的item
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), forState: .Normal)
//        btn.sizeToFit()
//        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        // 设置右边item
        let size = CGSizeMake(40, 40)
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