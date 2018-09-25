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
        
        var viewModelIndex = 0
        
        for viewModel in self.musicKeyViewModelArray {
            
            var musicKey: BaseMusicKey
            let normalFileArray = MusicAttributesModel.toneFileWithKeyArray[viewModelIndex].first!
            var tomeModelArray: [ToneItemModel] = []
            
            for fileName in normalFileArray {
                let model = ToneItemModel.init(toneFileName: fileName)
                tomeModelArray.append(model)
            }

            if viewModel.ownKind == .Movable {
                
                musicKey = BaseMovableMusicKey.init(
                    frame: viewModel.ownFrame,
                    mainKey: viewModelIndex,
                    borderColor: .white,
                    tomeModelArray: tomeModelArray,
                    kind: viewModel.ownKind
                )
                
            }else {

                musicKey = BaseMusicKey.init(
                    frame: viewModel.ownFrame,
                    mainKey: viewModelIndex,
                    borderColor: .white,
                    tomeModelArray: tomeModelArray,
                    kind: viewModel.ownKind
                )
                
            }

            switch viewModel.ownKind {
            case .Movable?:
                musicKey.borderColor = UIColor.clear
                musicKey.backgroundColor = UIColor.flatOrange
                let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.draggedView(_:)))
                panGesture.cancelsTouchesInView = false
                musicKey.addGestureRecognizer(panGesture)
                
                
            case .BorderVariable?:
                musicKey.borderColor = UIColor.flatOrange
                
            default:
                print("普通类型")
            }
            
            self.addSubview(musicKey)
            self.musicKeyArray.append(musicKey)
            
            viewModelIndex += 1
        }
        
    }
    
}

// MARK: - 拖动等动作事件
extension OperateKeysView {
    @objc func draggedView(_ sender: UIPanGestureRecognizer){
        let keyDrag = self.musicKeyArray[1] as! BaseMovableMusicKey
        self.bringSubview(toFront: keyDrag)
        
        switch sender.state {
        case .began:
            keyDrag.ownCenter = keyDrag.center
            
        case .ended, .failed, .cancelled:
            keyDrag.center = keyDrag.ownCenter
            
        default:
            let location = sender.location(in: self)
            keyDrag.center = location
        }
        
    }
    
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
                
                // 判断点击是否为上层按钮
                if let lowerLevelKeyIndex = self.judgeKeyIsHigherLevelKey(pressedKey!.mainKey) {
                    self.musicKeyArray[lowerLevelKeyIndex].pressStatus = .Pressed
                    
                }
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
            
//            previousPressedKey?.pressStatus = .Unpressed
            
            
            // 本次点击的按钮不为空
            if pressedKey != nil {
                
                // 判断点击是否为上层按钮
                if let lowerLevelKeyIndex = self.judgeKeyIsHigherLevelKey(pressedKey!.mainKey) {
                    self.musicKeyArray[lowerLevelKeyIndex].pressStatus = .Pressed
                    
                }
                
                
                // 上次点击的按钮不为空
                if previousPressedKey != nil {

                    // 两次点击的按钮不一致
                    if pressedKey!.mainKey != previousPressedKey!.mainKey {
                        
                        previousPressedKey!.pressStatus = .Unpressed
                        
                        
                        // 判断是否从上层Key滑动到下层Key
                        if self.judgeKeyIsMoved(fromHigherLevelKey: previousPressedKey!, toLowerLevelKey: pressedKey!) == false {
                            
                            pressedKey!.pressStatus = .Pressed
                        }
                        
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
    
    /// 判断是否从上层Key滑动到下层Key [上层Key, 下层Key] -> Bool
    func judgeKeyIsMoved(fromHigherLevelKey: BaseMusicKey, toLowerLevelKey: BaseMusicKey) -> Bool {
        if let higherLevelKeyIndexArray = MusicKeyAttributesModel.StackKeysDict[toLowerLevelKey.mainKey] {
            
            if higherLevelKeyIndexArray.contains(fromHigherLevelKey.mainKey) {
                return true
            }
            
        }
        
        return false
    }// funcEnd
    
    /// 用Index判断是否为上层按钮 如果是上层按钮 返回其底层按钮Index
    func judgeKeyIsHigherLevelKey(_ keyIndex: Int) -> Int? {
        for lowerLevelKeyIndex in MusicKeyAttributesModel.StackKeysDict.keys {
            let higherLevelKeyIndexArray = MusicKeyAttributesModel.StackKeysDict[lowerLevelKeyIndex]!
            
            if higherLevelKeyIndexArray.contains(keyIndex) == true {
                
                return lowerLevelKeyIndex
            }
            
            
        }
        
        return nil
        
    }// funcEnd
    
}

