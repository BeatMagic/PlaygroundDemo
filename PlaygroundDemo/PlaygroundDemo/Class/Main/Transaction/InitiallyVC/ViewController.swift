//
//  ViewController.swift
//  PlaygroundDemo
//
//  Created by X Young. on 2018/9/14.
//  Copyright © 2018年 X Young. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
//        let frame = CGRect.init(x: 40,
//                                y: 40,
//                                width: 200,
//                                height: 80)
//        
//        let testKey = BaseMusicKey.init(frame: frame,
//                                        borderColor: UIColor.yellow,
//                                        toneKey: .Tone1,
//                                        pitch: 10)
//        testKey.borderColor = UIColor.white
//        self.view.addSubview(testKey)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUI() -> Void {
        self.view.backgroundColor = UIColor.black
    }

}

