//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by 엔나루 on 2021/08/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //기본 알림창 버튼 생성
        let defaultAlertBtn = UIButton(type: .system)
        
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width/2
        defaultAlertBtn.setTitle("기본 알림창", for: .normal)
        defaultAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        self.view.addSubview(defaultAlertBtn)
        
        let defaultActionBtn = UIButton(type: .system)
        
        defaultActionBtn.frame = CGRect(x: 0, y: 200, width: 150, height: 30)
        defaultActionBtn.center.x = self.view.frame.width/2
        defaultActionBtn.setTitle("기본 액션시트", for: .normal)
        defaultActionBtn.addTarget(self, action: #selector(defaultAction(_:)), for: .touchUpInside)
        self.view.addSubview(defaultActionBtn)
    }
    
    @objc func defaultAlert(_ sender: Any) {
        //1 알림창을 정의
        let alert = UIAlertController(title: "알림창", message: /*"기본 메시지가 들어가는 곳"*/ nil, preferredStyle: .alert)
        //title 만 nil 처리하면 메시지 폰트가 자동으로 커진다.
        //메시지만 nil 처리하면 메시지가 없는 걸 제외하고 별 다를 게 없다.
        
        //2 버튼을 정의한다.
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        //버튼을 알림창에 추가한다
        //위아래 순서를 바꿔봐도 Cancel이 왼쪽 OK가 오른쪽이다.
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        //알림창에 들어갈 뷰 컨트롤러
        //주의: 반드시 알림창을 표시하기 전에 작성해 줘야 함.
        let v = UIViewController()
        v.view.backgroundColor = .gray
        //알림창의 컨텐츠뷰에 커스텀뷰를 집어넣는 마법의 구문
        //alert.contentViewController = v 같은 구문으로 처리할 수 없다.
        //퍼블릭 API가 아니기 때문에 아래 방식으로만 할 수 있다.
        alert.setValue(v, forKey: "contentViewController")
        
        //(반드시 마지막으로) 알림창을 화면에 표시한다.
        self.present(alert, animated: true)
    }

    @objc func defaultAction(_ sender: Any) {
        let action = UIAlertController(title: "액션 시트", message: "기본 메시지", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        action.addAction(cancelAction)
        action.addAction(okAction)
        
        let v = UIViewController()
        v.view.backgroundColor = .gray
        action.setValue(v, forKey: "contentViewController")
        
        self.present(action, animated: true, completion: nil)
    }
}

