//
//  BaseMovableMusicKey.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/17.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class BaseMovableMusicKey: BaseMusicKey {
    
    override func setData() {
        super.setData()
        
        // 拖动手势
        let panGesture = UIPanGestureRecognizer.init(target: nil, action: #selector(self.detectPan(_:)))
        
        self.addGestureRecognizer(panGesture)
    }
    
}

extension BaseMovableMusicKey {
    /// 拖动手势
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: self.getX() + translation.x, y: self.getY() + translation.y)
    }
}
