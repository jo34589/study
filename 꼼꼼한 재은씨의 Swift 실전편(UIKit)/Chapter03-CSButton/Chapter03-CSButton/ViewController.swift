//
//  ViewController.swift
//  Chapter03-CSButton
//
//  Created by 엔나루 on 2021/08/20.
//

import UIKit

class ViewController: UIViewController {

    //let btn = UIButton()
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 30, y: 40, width: 150, height: 30)
        let csBtn = CSButton(frame: frame)
        self.view.addSubview(csBtn)
        
        // Do any additional setup after loading the view.
    }
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //인자값에 따라 스타일로 결정되는 버튼 1
        let rectBtn = CSButton(type: .rect)
        rectBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        
        //인자값에 따라 스타일로 결정되는 버튼 2
        let circleBtn = CSButton(type: .circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        
        circleBtn.style = .rect
    }

}

