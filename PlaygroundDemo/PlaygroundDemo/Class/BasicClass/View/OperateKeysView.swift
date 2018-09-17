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

    
    /// 上一次touch事件的内存地址
    var lastTouchAddr: String!
    
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
            case 9:
                viewModel.ownFrame = CGRect.init(
                    x: ToolClass.getScreenWidth() / 2 + generalHeight / 2,
                    y: ToolClass.getScreenHeight() - 200,
                    width: ToolClass.getScreenWidth() / 2 - generalHeight,
                    height: 70
                )
                
            case 10:
                
                viewModel.ownFrame = CGRect.init(
                    x: ToolClass.getScreenWidth() / 2 + generalHeight / 2 + marginTop * 1.5,
                    y: ToolClass.getScreenHeight() - 200 + marginTop * 1.5,
                    width: ToolClass.getScreenWidth() / 2 - generalHeight - marginTop * 3,
                    height: 70 - marginTop * 3
                )
                
            // 左下角
            case 11:
                viewModel.ownFrame = CGRect.init(
                    x: generalHeight / 2,
                    y: ToolClass.getScreenHeight() - 200,
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
        
        var maxPitch: UInt8 = 65
        
        for viewModel in self.musicKeyViewModelArray {
            
            let musicKey = BaseMusicKey.init(
                frame: viewModel.ownFrame,
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
        }
        
    }
    
}

// MARK: - 重载Touch事件
extension OperateKeysView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            self.lastTouchAddr = String(format: "%p",  touch)
//
//
//
//        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            self.lastTouchAddr = String(format: "%p",  touch)
//
//
//
//        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            self.lastTouchAddr = String(format: "%p",  touch)
//
//
//
//        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}

// MARK: - 关于点击区域的判断
extension OperateKeysView {
    /// 判断点击了哪些key
    func judgeTouchMusicKeys(_ touchPoint: CGPoint) -> [BaseMusicKey] {
        var resultArray: [BaseMusicKey] = []
        
        for musicKey in self.musicKeyArray {
            if musicKey.frame.contains(touchPoint) {
                resultArray.append(musicKey)
            }
            
        }
        
        return resultArray
    }// funcEnd
    
    /// 将点击的Key触发通知
//    func triggerKeysArrayNotification(_ array: [BaseMusicKey]) -> Void {
//        for key in array {
//            key.pressStatus = .
//        }
//    }
}

