//
//  UIQEmojiView.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/5.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

class UIQEmojiView: UIView {
    
    private var emojisNames: NSArray!
    private var titleImageNames: NSArray!
    
    private var views: NSMutableArray!
    
    private var currentView: UIView!
    private var bottomView: UIQBottomView!
    
    

    init(frame: CGRect,emojisNames: NSArray, titleImageNames: NSArray) {
        super.init(frame: frame)
        self.emojisNames = emojisNames
        self.titleImageNames = titleImageNames
        initializeUserInteface()
        clickEvents()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func initializeUserInteface() {
        self.backgroundColor = UIColor.whiteColor()
        views = NSMutableArray()
        
        currentView = {
            let view = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-35))
            view.backgroundColor = UIColor.whiteColor()
            self.addSubview(view)
            return view
            }()
        
        bottomView = {
            let bv = UIQBottomView(frame: CGRectMake(0, CGRectGetHeight(self.bounds)-35, CGRectGetWidth(self.bounds), 35), imageArry: self.titleImageNames)
            self.addSubview(bv)
//            bv.selectedIndex = 1
//            bv.selectedColor = UIColor.orangeColor()
            return bv
            }()
        
        //创建视图
        for(var i = 0; i < emojisNames.count; i++) {
            let emojisArray = emojisNames[i] as! NSArray
            var row: Int = 4
            var cols: Int = 2
            if i == 2 {
                row = 7
                cols = 4
            }
            
            let emojisView = UIQKeyboardExpressionView(frame: self.currentView.bounds, dataSource: emojisArray, row: row, cols: cols)
            emojisView.backgroundColor = currentView.backgroundColor
            currentView.insertSubview(emojisView, atIndex: 0)
            views.addObject(emojisView)
            
        }
    }
    
    func clickEvents() {
        bottomView.qbottomViewClick = {(index: Int)  in
            let view = self.views[index] as! UIQKeyboardExpressionView
            self.currentView.bringSubviewToFront(view)
        
            
        }
        
    }
}
