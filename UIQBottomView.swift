//
//  UIQBottomView.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/5.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

/// 底部视图
class UIQBottomView: UIView, UIScrollViewDelegate {
    private let TAG: Int = 777777
    
    //按钮选中时颜色
    var selectedColor: UIColor! = UIColor ( red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5 ) {
        didSet {
            for x in TAG..<TAG + imageArray.count {
                let otherButton = self.viewWithTag(x) as! UIButton
                if otherButton.selected == true {
                    otherButton.backgroundColor = selectedColor
                    break
                }
            }
        }
    }
    /// 当前选中第几个
    var selectedIndex: Int! = 0 {
        didSet{
            print(selectedIndex)
            let btn = self.viewWithTag(TAG + selectedIndex) as! UIButton
            btn.selected = true
            btn.backgroundColor = selectedColor
            for x in TAG..<TAG + imageArray.count {
                let otherButton = scrollView.viewWithTag(x)
                if x != selectedIndex + TAG {
                    otherButton?.backgroundColor = UIColor.clearColor()
                    print(otherButton)
                    (otherButton as! UIButton).selected = false
                }
            }
        }
    }

    var sendButton: UIButton!
    
    private var scrollView: UIScrollView!
    private var imageArray: NSArray!
   
    private var buttonWidth: CGFloat!
    
    /// 选择按钮点击回调
    var qbottomViewClick: ((index: Int) -> Void)?
    /// 发送按钮点击回调
    var qbottomViewSendButtonClick: (()->())?
    
    
    init(frame: CGRect, imageArry:NSArray) {
        super.init(frame: frame)
        self.imageArray = imageArry

        self.buttonWidth = 60.0
        
        configScrollView()
        configSendButton()
        
        self.selectedIndex = 0
        
        
        let topLineLabel = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0.5))
        topLineLabel.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(topLineLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    配置滚动视图
    */
    func configScrollView() {
        scrollView = UIScrollView(frame: CGRectMake(0, 0, CGRectGetWidth(self.bounds) - self.buttonWidth, CGRectGetHeight(self.bounds)))
        scrollView.delegate = self
        self.addSubview(scrollView)
        for i in 0..<self.imageArray.count {
            let button = tabButtonWithIndex(i)
            self.scrollView.addSubview(button)
            
        }
        
    }
    
    /**
    配置发送按钮
    */
    func configSendButton() {
        self.sendButton = UIButton(frame: CGRectMake(CGRectGetWidth(self.bounds) - self.buttonWidth, 0, self.buttonWidth, CGRectGetHeight(self.bounds)))
        self.sendButton.backgroundColor = UIColor.orangeColor()
        self.sendButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        self.sendButton.setTitle("完成", forState: .Normal)
        self.sendButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.sendButton.addTarget(self, action: "sendButtonClick:", forControlEvents: .TouchUpInside)
        self.addSubview(sendButton)
        
    }
    
    func tabButtonWithIndex(index: Int) -> UIButton {
        let button = UIButton(frame: CGRectMake(self.buttonWidth * CGFloat(index), 0, self.buttonWidth, CGRectGetHeight(self.bounds)))
        let lineView = UIView(frame: CGRectMake(self.buttonWidth - 0.5, 0, 0.5, CGRectGetHeight(self.bounds)))
        lineView.backgroundColor = UIColor.lightGrayColor()
        button.setImage(UIImage(named: self.imageArray[index] as! String), forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFit
        button.addSubview(lineView)
        button.tag = TAG + index
        button.addTarget(self, action: "tabButtonClick:", forControlEvents: .TouchUpInside)
        if index == selectedIndex {
            button.selected = true
            button.backgroundColor = selectedColor
        }
        
        return button
    }
    
    
    func sendButtonClick(button: UIButton) {
       if qbottomViewSendButtonClick != nil {
            qbottomViewSendButtonClick!()
        }
       
    }
    
    func tabButtonClick(button: UIButton) {
        let cT = button.tag - TAG
        if cT == selectedIndex { return }
        
        selectedIndex = cT

        if qbottomViewClick != nil {
            qbottomViewClick!(index: cT)
        }
    }

}
