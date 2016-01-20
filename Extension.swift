
//
//  Extension.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/6.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

extension UISearchBar {
    /**
    改变背景颜色
    
    - parameter color: 颜色
    */
    func insertBgColor(color: UIColor) {
        let customBgTAG: Int = 999
        let realView: UIView = self.subviews[0] as UIView
        for(var i: Int = 0; i < realView.subviews.count; i++) {
            let cView = realView.subviews[i] as UIView
            if cView.tag == customBgTAG {cView.removeFromSuperview()}
        }
        
        
        let img = UIImage.imageWithColor(color, frame: CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)+20))
        let custombg = UIImageView(image: img)
        var frame = custombg.frame
        frame.origin.y -= 20
        custombg.frame = frame
        custombg.tag = customBgTAG
        (self.subviews[0] as UIView).insertSubview(custombg, atIndex: 1)
        
        
    }

}

extension UIImage {
    /**
    根据颜色生成对应图片
    
    - parameter aColor: <#aColor description#>
    - parameter frame:  <#frame description#>
    
    - returns: <#return value description#>
    */
    class func imageWithColor(aColor: UIColor,frame: CGRect) -> UIImage{
        UIGraphicsBeginImageContext(frame.size)
        let content = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(content, aColor.CGColor)
        CGContextFillRect(content, frame)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}