//
//  ViewController.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/14.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var keysView: OperateKeysView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setData()
        self.setUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData() -> Void {
        self.keysView = OperateKeysView.init(frame: CGRect.init(
            x: 0,
            y: 0,
            width: ToolClass.getScreenWidth(),
            height: ToolClass.getScreenHeight()))
        
        self.view.addSubview(self.keysView)
    }
    
    func setUI() -> Void {
        self.view.backgroundColor = UIColor.black
        
        
    }

}

