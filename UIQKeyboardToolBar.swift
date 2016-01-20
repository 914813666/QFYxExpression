//
//  UIQKeyboardToolBar.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/6.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

class UIQKeyboardToolBar: UIView {
    private let TAG: Int = 88888
    private var keyboardToolBar: UIView!

    var qkeyboardToolBarButtonArray: NSMutableArray!
    
    var qkeyboardToolBarClick: ((index: Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeUserInterface() {
        let self_Width = CGRectGetWidth(self.bounds)
        let self_Height = CGRectGetHeight(self.bounds)
        qkeyboardToolBarButtonArray = NSMutableArray()
        
        
        keyboardToolBar = UIView(frame: CGRectMake(0, self_Height - 40, self_Width, 40))
        keyboardToolBar.backgroundColor = UIColor(red: 248.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
        self.addSubview(keyboardToolBar)
        
        let photoButton = toolBarButtonWithToolBar(keyboardToolBar.frame, index: 0, imageName: "keyboard_photo", sel: "buttonClick:")
        photoButton.tag = TAG
        let emotionButton = toolBarButtonWithToolBar(keyboardToolBar.frame, index: 1, imageName: "keyboard_emotion", sel: "buttonClick:")
        emotionButton.tag = TAG + 1
        let topicButton = toolBarButtonWithToolBar(keyboardToolBar.frame, index: 2, imageName: "keyboard_topic", sel: "buttonClick:")
        topicButton.tag = TAG + 2
        let atButton = toolBarButtonWithToolBar(keyboardToolBar.frame, index: 3, imageName: "keyboard_at", sel: "buttonClick:")
        atButton.tag = TAG + 3
        
        qkeyboardToolBarButtonArray.addObject(photoButton)
        qkeyboardToolBarButtonArray.addObject(emotionButton)
        qkeyboardToolBarButtonArray.addObject(topicButton)
        qkeyboardToolBarButtonArray.addObject(atButton)
        
        keyboardToolBar.addSubview(photoButton)
        keyboardToolBar.addSubview(emotionButton)
        keyboardToolBar.addSubview(topicButton)
        keyboardToolBar.addSubview(atButton)
        
        let topLineLabel = UILabel(frame: CGRectMake(0, 0, CGRectGetWidth(self.bounds), 0.5))
        topLineLabel.backgroundColor = UIColor.lightGrayColor()
        self.addSubview(topLineLabel)
        
    }
    
    /**
    创建点击按钮
    */
    func toolBarButtonWithToolBar(frame: CGRect, index: Int, imageName: String, sel: Selector) -> UIButton {
        let toolBar_Height = CGRectGetHeight(frame)
        let padding: CGFloat = 15
        let button_Width  = (CGRectGetWidth(frame) - padding * 2) / 4
        
        
        let button = UIButton(frame: CGRectMake(padding + button_Width * CGFloat(index), 0, button_Width, toolBar_Height))
        button.contentHorizontalAlignment = .Left
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.addTarget(self, action: sel, forControlEvents: .TouchUpInside)
        return button
        
    }
    
    func buttonClick(button: UIButton) {
        
        if qkeyboardToolBarClick != nil {
            qkeyboardToolBarClick!(index: button.tag - TAG)
        }
    
    }
}
