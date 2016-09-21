//
//  MainViewController.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/21.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Fellow")
        addChildVc("Profile")
        
    }
    
    private func addChildVc(storyBoradName:String){
        // 创建控制器
        let childVc = UIStoryboard(name: storyBoradName, bundle: nil).instantiateInitialViewController()!
        
        // 添加到自控制器
        addChildViewController(childVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
