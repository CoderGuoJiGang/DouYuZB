//
//  PageTitleView.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/22.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2.0 //( 为什么kscrollH = 2.0报错)

class PageTitleView: UIView {
    
    // MARK:-定义属性,数组属性保存
    private var titles : [String]
    
    // MARK:-懒加载属性
    private lazy var titleLables : [UILabel] = [UILabel]()
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
//        scrollView.backgroundColor = UIColor.orangeColor()
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
  // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置UI界面
        setUI()
        
    }
 // 重写view的init必须实现以下方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
// MARK:-设置UI界面
extension PageTitleView{
    private func setUI(){
        
    
        
        // 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加title对应的Label
        setupTitleLables()
        
        // 设置底线和滚动view
        setupBottomMenuAndScrollLine()
    }
    
    
    private func setupTitleLables(){
        
        // 确定label的一些frame值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        
        for (index,title) in titles.enumerate(){
            // 创建UILable
            let lable = UILabel()
            
            // 设置lableView属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFontOfSize(16.0)
            lable.textColor = UIColor.darkGrayColor()
//            lable.backgroundColor = UIColor.purpleColor()
            lable.textAlignment = .Center
            
            // 设置frame
            let labelX:CGFloat = labelW * CGFloat(index)
            lable.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            print(CGRect(x: labelX, y: labelY, width: labelW, height: labelH))
            // label添加到scrollView
            scrollView.addSubview(lable)
            titleLables.append(lable)
        }
    }
    
    private func setupBottomMenuAndScrollLine(){
        // 设置底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: kScreenW, height: lineH)
//        scrollView.addSubview(bottomLine)
        addSubview(bottomLine)
        
        // 添加ScrollLine
         //现货区第一个lable
       guard let fristLabel = titleLables.first else {return}
        fristLabel.textColor = UIColor.orangeColor()
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - kScrollLineH, width: fristLabel.frame.width, height: kScrollLineH)
    }

    
}