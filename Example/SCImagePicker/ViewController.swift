//
//  ViewController.swift
//  SCImagePicker
//
//  Created by revertsc on 02/08/2022.
//  Copyright (c) 2022 revertsc. All rights reserved.
//

import UIKit
import SCImagePicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let picker = SCImagePicker(frame: self.view.frame)
        self.view.addSubview(picker)
        
//        let vc = SCImagePicker()
//        self.present(vc, animated: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

