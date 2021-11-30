//
//  ViewController.swift
//  Chapter03-CSStepper
//
//  Created by 엔나루 on 2021/09/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let stepper = CSStepper()
        stepper.frame = CGRect(x: 30, y: 100, width: 130, height: 30)
        
        //vlauechange 이벤트가 발생하면 logging 메소드 호출
        stepper.addTarget(self, action: #selector(logging(_:)), for: .valueChanged)
        
        self.view.addSubview(stepper)
    }
    
    @objc func logging(_ sender: CSStepper) {
        NSLog("현재 스테퍼의 값은 \(sender.value) 입니다.")
    }


}

