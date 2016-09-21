//
//  UIBarButton_Extension.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/21.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit


extension UIBarButtonItem{
    /* // 类方法
    class func createItem(imageName:String ,highImage:String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highImage), forState: .Highlighted)
        btn.frame = CGRect(origin: CGPointZero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }*/
    
    // 构造函数
    convenience init(imageName:String ,highImage:String = "", size:CGSize = CGSizeZero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if highImage != ""{
            btn.setImage(UIImage(named: highImage), forState: .Highlighted)
        }
        
        
        if size != CGSizeZero{
        btn.frame = CGRect(origin: CGPointZero, size: size)
        } else {
            btn.sizeToFit()
        }
        
        
        self.init(customView: btn)
    }
}