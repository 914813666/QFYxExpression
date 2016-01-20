//
//  UIQKeyboardExpressionVIew.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/5.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit



class UIQKeyboardExpressionView: UIView , UIScrollViewDelegate{
    private let TAG: Int = 555555
    private var scrollView: UIScrollView!
    /// 每行个数
    private var row: Int!
    /// 每页有多少行
    private var cols: Int!
    private var dataSource: NSArray!
    private var pageControl: UIPageControl!
    
    
    /// 点击回调
    var keyboardExpressionClick:((index: Int)->Void)?
    var keyboardExpressionClickWithName: ((index: Int, name: String)->Void)?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    init(frame: CGRect, dataSource: NSArray, row: Int, cols: Int) {
        super.init(frame: frame)
        self.row = row
        self.dataSource = dataSource
        self.cols = cols
        initializeUserInterface()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeUserInterface() {
        self.backgroundColor = UIColor.clearColor()
        let self_Height = CGRectGetHeight(self.bounds) - 10
        let self_Width  = CGRectGetWidth(self.bounds)

        let pageTotle   = Int(ceilf(Float(Float(dataSource.count) / Float(row * cols))))

        
        pageControl = UIPageControl(frame: CGRectMake(0,  self_Height, self_Width, 10))
        pageControl.numberOfPages = pageTotle
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.addSubview(pageControl)
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
        
        for (var i = 0 ; i < dataSource.count; i++) {
             let (x,y,c) = currentPostionWithIndex(i)
            let btn: UIButton = UIButton(type: .Custom)
            btn.frame = CGRectMake(CGFloat(y) * CGFloat(self_Width/CGFloat(row)) + self_Width * CGFloat(c), CGFloat(x) * CGFloat(self_Height / CGFloat(cols)), self_Width/CGFloat(row), (self_Height / CGFloat(cols))-5)
            btn.contentMode = UIViewContentMode.Center
            btn.imageView?.contentMode = .ScaleAspectFit
            btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 0)
            btn.setImage(UIImage(named: dataSource[i] as! String), forState: .Normal)
            scrollView.addSubview(btn)
            btn.addTarget(self, action: "q_buttonPressed:", forControlEvents: .TouchUpInside)
            btn.tag = TAG + i
            
           
//            print("第\(x)行,第\(y)列,第\(c)页")
        }
        scrollView.contentSize = CGSizeMake(self_Width * CGFloat(pageTotle), 0)
     }
    
    /**
    获取当前图片在scrollView中的位置
    
    - parameter index: 图片下标
    
    - returns: 图片（第几行,第几列，当前第几页）
    */
    func currentPostionWithIndex(index: Int) -> (row: Int, cols: Int,currentPage: Int) {

        let currentPage: Int = index / (row * cols) + 1
        
        var currentRow: Int = 0
        var currentCols: Int = 0
        if index != 0 {
            let temp1 = index - ((currentPage - 1) * row * cols)

            if temp1 != 0 {
                currentRow = temp1 / row
                currentCols = temp1 % row
            }
        }
        
        return (currentRow,currentCols,currentPage - 1)
    }

    
    func q_buttonPressed(button: UIButton) {
        let cT = button.tag - TAG
        print("当前点击第\(cT)个")
        if keyboardExpressionClick != nil {
            keyboardExpressionClick!(index: cT)
        }
        
        if keyboardExpressionClickWithName != nil {
            let name = self.dataSource[cT] as! String
            keyboardExpressionClickWithName!(index: cT,name: name)
            
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        self.pageControl.currentPage = Int(offsetX / CGRectGetWidth(scrollView.bounds))
    }
    
}
