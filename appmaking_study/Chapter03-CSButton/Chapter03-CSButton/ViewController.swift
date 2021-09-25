//
//  ViewController.swift
//  Chapter03-CSButton
//
//  Created by 엔나루 on 2021/08/20.
//

import UIKit

class ViewController: UIViewController {

    //let btn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 30, y: 40, width: 150, height: 30)
        let csBtn = CSButton(frame: frame)
        self.view.addSubview(csBtn)
        
        // Do any additional setup after loading the view.
    }


}

