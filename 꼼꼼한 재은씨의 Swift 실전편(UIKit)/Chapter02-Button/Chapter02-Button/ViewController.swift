//
//  ViewController.swift
//  Chapter02-Button
//
//  Created by 엔나루 on 2021/07/29.
//

import UIKit

class ViewController: UIViewController {

    @objc func btnOnClick(_ sender: Any) {
        //호출한 객체가 버튼이라면
        if let btn = sender as? UIButton {
            btn.setTitle("클릭되었습니다", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1 버튼 객체를 생성하고, 3 속성을 설정한다.
        let btn = UIButton(type: .system)
        //2 버튼의 위치와 영역을 정의해줌
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        //btn.titlelabel?.text = "테스트 버튼" 이라 하면 안됨. for: .normal 때문.
        //상태에 따라 다를수 있다.
        btn.setTitle("테스트 버튼", for: .normal)
        
        //위치를 수정
        btn.center = CGPoint(x:self.view.frame.size.width/2, y: 100)
        
        //4 버튼을 뷰에 추가.
        self.view.addSubview(btn)
        
        //버튼 이벤트와 메소드 btnOnClick(_:)를 연결한다.
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        
    }


}

