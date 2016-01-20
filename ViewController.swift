//
//  ViewController.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/5.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    private var emojiView: UIQEmojiView!
    private var footView:UIQKeyboardToolBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        let newArr = NSMutableArray()
        for x in 10...30 {
            newArr.addObject(String(format: "coding_emoji_%d", x))
        
        }
        let newArr2 = NSMutableArray()
        
        for x in 1...8 {
            newArr2.addObject(String(format: "coding_emoji_gif_0%d", x))
            
            
        }
        
        let newArr3 = NSMutableArray()
        for x in 0...104 {
            newArr3.addObject(String(format: "%d", x))
        }
        let  titleImageNames = ["keyboard_emotion_emoji", "keyboard_emotion_monkey", "keyboard_emotion_monkey_gif"]
        
//        let keyView = UIQKeyboardExpressionView(frame: CGRectMake(0, 64, self.view.frame.width, 180), dataSource: newArr, row: 4, cols: 2)
//        self.view.addSubview(keyView)
        
        
        emojiView = UIQEmojiView(frame: CGRectMake(0,self.view.frame.height - 210 , self.view.frame.width, 210), emojisNames: [newArr,newArr2,newArr3], titleImageNames: titleImageNames)

        footView = UIQKeyboardToolBar(frame: CGRectMake(0, self.view.frame.height-40,  self.view.frame.width, 40))
        self.view.addSubview(footView)
        
        footView.qkeyboardToolBarClick = {(index: Int) in
            
            if index == 3 {
                SearchViewController.show(self, block: { (index) -> Void in
                    print("index:\(index)")
                })
//                let svc = SearchViewController()
//                self.presentViewController(svc, animated: true, completion: nil)
             
                return
            }
            
            
            if self.inputTextField.inputView != self.emojiView {
                self.inputTextField?.inputView = self.emojiView
                (self.footView.qkeyboardToolBarButtonArray[1] as! UIButton).setImage(UIImage(named: "keyboard_keyboard"), forState: .Normal)
            } else {
                self.inputTextField.inputView = nil
                  (self.footView.qkeyboardToolBarButtonArray[1] as! UIButton).setImage(UIImage(named: "keyboard_emotion"), forState: .Normal)
            }
            self.inputTextField.resignFirstResponder()
            let time: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 4 / 100))
            
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                self.inputTextField.becomeFirstResponder()
            })
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //MARK: - -KeyBoard Notification Handlers-

    func keyboardChange(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let animationDuration: NSTimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey]?.doubleValue)!
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue)!
        UIView.animateKeyframesWithDuration(animationDuration, delay: 0, options:UIViewKeyframeAnimationOptions.LayoutSubviews, animations: { () -> Void in
                let keyboardY = keyboardEndFrame.origin.y
            print(keyboardY)
            var frame = self.footView.frame
            print(frame)
            frame.origin.y = keyboardY - CGRectGetHeight(self.footView.frame)
            self.footView.frame = frame
            
            }) { (b:Bool) -> Void in
                
        }

    }


}

