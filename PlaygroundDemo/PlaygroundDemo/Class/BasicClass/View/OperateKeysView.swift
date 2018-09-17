//
//  OperateKeysView.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/15.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit
import ChameleonFramework

class OperateKeysView: UIView {
    /// 按钮数组
    var musicKeyArray: [BaseMusicKey] = []
    
    /// 按钮frame数组
    var musicKeyViewModelArray: [MusicKeyViewModel] = []

    
    /// touch事件的内存地址: 该touch事件经过的最后一个按钮
    var lastTouchKeyDict: [String: BaseMusicKey?] = [String: BaseMusicKey?]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setData()
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 自身属性的设置等
extension OperateKeysView {
    /// setData
    func setData() -> Void {
        let tmpRect = CGRect.init(x: 40, y: 40, width: 40, height: 40)
        self.musicKeyViewModelArray = [
            MusicKeyViewModel.init(tmpRect, .Normal),
            MusicKeyViewModel.init(tmpRect, .Movable),
            MusicKeyViewModel.init(tmpRect, .BorderVariable),
            MusicKeyViewModel.init(tmpRect, .BorderVariable),
            MusicKeyViewModel.init(tmpRect, .Normal),
            MusicKeyViewModel.init(tmpRect, .BorderVariable),
            MusicKeyViewModel.init(tmpRect, .Normal),
            MusicKeyViewModel.init(tmpRect, .BorderVariable),
            MusicKeyViewModel.init(tmpRect, .Normal),
            MusicKeyViewModel.init(tmpRect, .BorderVariable),
            MusicKeyViewModel.init(tmpRect, .Normal),
        ]
        
        let generalWidth: CGFloat = 250
        let generalX: CGFloat  = (ToolClass.getScreenWidth() - generalWidth) / 3 * 2
        let generalHeight: CGFloat  = 30
        let initialY: CGFloat  = 250
        let marginTop: CGFloat = 10
        
        
        for index in 0 ..< self.musicKeyViewModelArray.count {
            let viewModel = self.musicKeyViewModelArray[index]
            
            switch index {
                
            // 唯一一个大的普通
            case 0:
                viewModel.ownFrame = CGRect.init(x: generalX / 2 ,
                                                 y: generalX + 25,
                                                 width: ToolClass.getScreenWidth() - generalX,
                                                 height: 1 * generalX)
                
            // 唯一一个可拖动
            case 1:
                viewModel.ownFrame = CGRect.init(x: (ToolClass.getScreenWidth() - 50) / 2,
                                                 y: generalX,
                                                 width: 50,
                                                 height: 50)
                
            // 两个边框可变
            case 2, 3:
                viewModel.ownFrame = CGRect.init(
                    x: (ToolClass.getScreenWidth() - 100 * 2 - generalHeight) / 2,
                    y: generalX + 70,
                    width: 100,
                    height: 50
                )
                
                if index == 3 {
                    viewModel.ownFrame = CGRect.init(
                        x: (ToolClass.getScreenWidth() - 100 * 2 - generalHeight) / 2 + 100 + generalHeight,
                        y: generalX + 70,
                        width: 100,
                        height: 50
                    )
                }
                
            // 右下角大的
            case 8:
                viewModel.ownFrame = CGRect.init(
                    x: ToolClass.getScreenWidth() / 2 + generalHeight / 2,
                    y: ToolClass.getScreenHeight() - 250,
                    width: ToolClass.getScreenWidth() / 2 - generalHeight,
                    height: 70
                )
                
            case 9:
                
                viewModel.ownFrame = CGRect.init(
                    x: ToolClass.getScreenWidth() / 2 + generalHeight / 2 + marginTop * 1.5,
                    y: ToolClass.getScreenHeight() - 250 + marginTop * 1.5,
                    width: ToolClass.getScreenWidth() / 2 - generalHeight - marginTop * 3,
                    height: 70 - marginTop * 3
                )
                
            // 左下角
            case 10:
                viewModel.ownFrame = CGRect.init(
                    x: generalHeight / 2,
                    y: ToolClass.getScreenHeight() - 250,
                    width: ToolClass.getScreenWidth() / 2 - generalHeight,
                    height: 70
                )
                
            default:
                viewModel.ownFrame = CGRect.init(x: generalX,
                                                 y: initialY + CGFloat((index - 4)) * (marginTop + generalHeight),
                                                 width: generalWidth,
                                                 height: generalHeight)
                
            }

        }

    }
    
    /// setUI
    func setUI() -> Void {
        self.backgroundColor = UIColor.black
        self.isMultipleTouchEnabled = true
        
        var maxPitch: UInt8 = 65
        var viewModelIndex = 0
        
        
        for viewModel in self.musicKeyViewModelArray {
            
            let musicKey = BaseMusicKey.init(
                frame: viewModel.ownFrame,
                mainKey: viewModelIndex,
                borderColor: .white,
                toneKey: .Piano,
                pitch: maxPitch,
                kind: viewModel.ownKind)
            
            switch viewModel.ownKind {
            case .Movable:
                musicKey.borderColor = UIColor.clear
                musicKey.backgroundColor = UIColor.flatOrange
                
            case .BorderVariable:
                musicKey.borderColor = UIColor.flatOrange
                
            default:
                print("普通类型")
            }
            
            self.addSubview(musicKey)
            self.musicKeyArray.append(musicKey)
            
            maxPitch -= 1
            viewModelIndex += 1
        }
        
    }
    
}

// MARK: - 拖动等动作事件
extension OperateKeysView {

}

// MARK: - 重载Touch事件
extension OperateKeysView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchAddress = String(format: "%p",  touch)
            
            let pressedKey = self.judgeTouchMusicKey(touch.location(in: self))
            self.lastTouchKeyDict[touchAddress] = pressedKey
            
            // 如果点到按钮就触发通知
            if pressedKey != nil {
                pressedKey!.pressStatus = .Pressed
            }
            
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchAddress = String(format: "%p",  touch)
            // 上次点击的按钮
            let previousPressedKey = self.lastTouchKeyDict[touchAddress]!
            
            // 本次点击的按钮
            let pressedKey = self.judgeTouchMusicKey(touch.location(in: self))
            
            // 本次点击的按钮不为空
            if pressedKey != nil {
                
                // 上次点击的按钮不为空
                if previousPressedKey != nil {
                    
                    // 两次点击的按钮不一致
                    if pressedKey!.mainKey != previousPressedKey!.mainKey {
                        pressedKey!.pressStatus = .Pressed
                        previousPressedKey!.pressStatus = .Unpressed
                    }
                    
                }else {
                    pressedKey!.pressStatus = .Pressed
                    
                }
                
                
                
            }else {
                // 上次点击的按钮不为空
                if previousPressedKey != nil {
                    previousPressedKey!.pressStatus = .Unpressed
                    
                }
            }
            
            self.lastTouchKeyDict[touchAddress]! = pressedKey
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let touchAddress = String(format: "%p",  touch)
            let lastKey = self.lastTouchKeyDict[touchAddress]!
            if lastKey != nil {
                lastKey!.pressStatus = .Unpressed
                
            }
            
            self.lastTouchKeyDict.removeValue(forKey: touchAddress)

        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchAddress = String(format: "%p",  touch)
            let lastKey = self.lastTouchKeyDict[touchAddress]!
            if lastKey != nil {
                lastKey!.pressStatus = .Unpressed
                
            }
            
            self.lastTouchKeyDict.removeValue(forKey: touchAddress)
            
        }
    }
}

// MARK: - 关于点击区域的判断
extension OperateKeysView {
    /// 判断点击了哪个key
    private func judgeTouchMusicKey(_ touchPoint: CGPoint) -> BaseMusicKey? {
        
        var tmpMusicKeyArray: [BaseMusicKey] = []
        
        for musicKey in self.musicKeyArray {
            if musicKey.frame.contains(touchPoint) {
                tmpMusicKeyArray.append(musicKey)
                
            }
            
        }
        
        if tmpMusicKeyArray.count != 0 {
            return tmpMusicKeyArray.last!
        }
        
        return nil
    }// funcEnd
    
    
}


/*
import UIKit

class ViewController: UIViewController {
    //拖动的view
    @IBOutlet weak var myView: UIView!
    //拖动view的上约束
    @IBOutlet weak var myViewTopLayoutConstraint: NSLayoutConstraint!
    //拖动手势
    @IBOutlet var panGesture: UIPanGestureRecognizer!
 
    //保存初始时拖动view上约束的值
    var myViewTopLayoutConstant: CGFloat!
    //保存初始时拖动view的y坐标值
    var myViewOriginY: CGFloat!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加拖动手势响应
        panGesture.addTarget(self, action: #selector(ViewController.pan))
        //保存初始时拖动view上约束的值（用于后面还原）
        myViewTopLayoutConstant = myViewTopLayoutConstraint.constant
    }
 
    //拖动手势
    func pan() {
        //拖动开始
        if panGesture.state == .began {
            myViewOriginY = myView.frame.origin.y
        }
 
            //拖动过程
        else if panGesture.state == .changed {
            let y = panGesture.translation(in: self.view).y
            myViewTopLayoutConstraint.constant = myViewTopLayoutConstant + y
        }
 
            //拖动结束
        else if panGesture.state == .ended {
            //回弹
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                () -> Void in
                self.myView.frame.origin.y = self.myViewOriginY
            }, completion: { (success) -> Void in
                if success {
                    //回弹动画结束后恢复默认约束值
                    self.myViewTopLayoutConstraint.constant = self.myViewTopLayoutConstant
                }
            })
            return
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

 */
