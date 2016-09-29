//
//  PageTitleView.swift
//  DYZB
//
//  Created by 郭吉刚 on 16/9/22.
//  Copyright © 2016年 郭吉刚. All rights reserved.
//

import UIKit


protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex : Int) 
    
}
// 
private let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kSelsetedColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
private let kScrollLineH : CGFloat = 2.0 //( 为什么kscrollH = 2.0报错)

class PageTitleView: UIView {
    
    // MARK:-定义属性,数组属性保存
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate : PageTitleViewDelegate?
    // MARK:-懒加载属性
    fileprivate lazy var titleLables : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
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
    fileprivate func setUI(){
        
    
        
        // 添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加title对应的Label
        setupTitleLables()
        
        // 设置底线和滚动view
        setupBottomMenuAndScrollLine()
    }
    
    
    fileprivate func setupTitleLables(){
        
        // 确定label的一些frame值
        let labelW:CGFloat = frame.width / CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        
        
        for (index,title) in titles.enumerated(){
            // 创建UILable
            let lable = UILabel()
            
            // 设置lableView属性
            lable.text = title
            lable.tag = index
            lable.font = UIFont.systemFont(ofSize: 16.0)
            lable.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            lable.textAlignment = .center
            
            // 设置frame
            let labelX:CGFloat = labelW * CGFloat(index)
            lable.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // label添加到scrollView
            scrollView.addSubview(lable)
            titleLables.append(lable)
            
            // 添加手势
            lable.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(PageTitleView.titleLabelClick(_:)))
            lable.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomMenuAndScrollLine(){
        // 设置底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: kScreenW, height: lineH)
        addSubview(bottomLine)
        
        // 添加ScrollLine
         //现货区第一个lable
       guard let fristLabel = titleLables.first else {return}
        fristLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - kScrollLineH, width: fristLabel.frame.width, height: kScrollLineH)
    }

    
}

// MARK:- 监听lable的点击
extension PageTitleView{
    @objc  func titleLabelClick(_ tapGes : UITapGestureRecognizer){
    // 获取当前lable下标
        let currentLab = (tapGes.view as? UILabel )!
        
        // 获取之前的lable
        let oldLab = titleLables[currentIndex]
        
        // 切换文字颜色
        oldLab.textColor = UIColor.darkGray
        currentLab.textColor = UIColor.orange
        
        // 保存最新的lable下标
        currentIndex = currentLab.tag
        
        // 滚动条位置改变
        let scrollLinePosition = CGFloat(currentLab.tag)*scrollLine.frame.width
        self.scrollLine.frame.origin.x = scrollLinePosition
        
        // 同志代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

// MARK: - 对外暴露方法
extension PageTitleView {
    func setTitleWithProgress(progress:CGFloat ,sourceIndex:Int,targetInde:Int) {
        // 取出sourceIndex、targetIndex对应的label
        let sourceLabel = titleLables[sourceIndex]
        let targetLabel = titleLables[targetInde]
        
        // 滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色渐变
        // 1.1取出变化范围
        let colorDelta = (kSelsetedColor.0 - kNormalColor.0,kSelsetedColor.1 - kNormalColor.1,kSelsetedColor.2 - kNormalColor.2)
        
        // 1.2变化
        sourceLabel.textColor = UIColor(r: kSelsetedColor.0-colorDelta.0*progress, g: kSelsetedColor.1-colorDelta.1*progress, b: kSelsetedColor.2-colorDelta.2*progress)
        
        // 1.3targetlab变化
        targetLabel.textColor = UIColor(r: kNormalColor.0+colorDelta.0*progress, g: kNormalColor.1+colorDelta.1*progress, b: kNormalColor.2+colorDelta.2*progress)
        
        // 记录最新的index
        currentIndex = targetInde
    }
}
