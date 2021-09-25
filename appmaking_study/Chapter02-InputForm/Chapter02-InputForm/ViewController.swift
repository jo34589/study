//
//  ViewController.swift
//  Chapter02-InputForm
//
//  Created by 엔나루 on 2021/07/30.
//

import UIKit

class ViewController: UIViewController {

    //이메일 입력 필드
    //뷰 컨트롤러 내에서 자유롭게 사용하기 위해 viewdidload() 가 아닌 ViewController 클래스의 프로퍼티로 선언.
    var paramEmail: UITextField!
    //스위치 객체 선언
    var paramUpdate: UISwitch!
    //스테퍼 객체 선언
    var paramInterval: UIStepper!
    //스위치 컨트롤의 값을 표시할 객체 선언
    var txtUpdate: UILabel!
    //스테퍼 컨트롤의 값을 표시할 객체 선언
    var txtInterval: UILabel!
    
    override func viewDidLoad() {
        
        //1. 내비게이션 바 타이틀을 입력한다.
        self.navigationItem.title = "설정"
        
        //2. 이메일 레이블을 생성하고 영역과 기본 문구를 설정한다.
        let lblEmail = UILabel()
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        
        //3. 레이블의 폰트를 설정
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        //let font = UIFont(name: "Chalkboard SE", size: 14)
        //lblEmail.font = font
        //방식으로 시스템폰트 이외의 폰트를 쓸 수 있다.
        
        //4. 레이블을 루트 뷰에 추가
        self.view.addSubview(lblEmail)
        
        //자동갱신 레이블을 생성하고 추가
        let lblUpdate = UILabel()
        lblUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblUpdate)
        
        //갱신주기 레이블을 생성하고 추가
        let lblInterval = UILabel()
        lblInterval.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblInterval)
        
        //이메일 입력을 위한 텍스트필드 추가.
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: 120, y: 100, width: 220, height: 30)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = .roundedRect
        //첫글자 자동 대문자 변환 해제
        self.paramEmail.autocapitalizationType = .none
        
        self.view.addSubview(self.paramEmail)
        
        //스위치 객체 생성
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: 120, y: 120, width: 50, height: 30)
        
        //스위치가 ON 되어 있는 상태를 기본값으로 설정
        self.paramUpdate.setOn(true, animated: true)
        
        self.view.addSubview(self.paramUpdate)
        
        //갱신주기를 위한 스테퍼를 추가한다.
        self.paramInterval = UIStepper()
        
        self.paramInterval.frame = CGRect(x: 120, y: 200, width: 50, height: 30)
        self.paramInterval.minimumValue = 0 //스테퍼가 가질 수 있는 최소값
        self.paramInterval.maximumValue = 100 //스테퍼가 가질 수 있는 최대값
        self.paramInterval.stepValue = 1 //스테퍼의 값 변경 단위
        self.paramInterval.value = 0 //초기값 설정
        
        self.view.addSubview(self.paramInterval)
        
        //스위치 객체의 값을 표현할 레이블
        self.txtUpdate = UILabel()
        
        self.txtUpdate.frame = CGRect(x: 250, y: 150, width: 100, height: 30)
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.textColor = UIColor.red
        self.txtUpdate.text = "갱신함"
        
        self.view.addSubview(txtUpdate)
        
        //스테퍼 객체의 값을 표현할 레이블
        self.txtInterval = UILabel()
        
        self.txtInterval.frame = CGRect(x: 250, y: 200, width: 100, height: 30)
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        
        self.view.addSubview(txtInterval)
        
        //스위치와 스테퍼의 Vlaue Changed 이벤트를 메소드에 연결
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        //전송 버튼을 내비게이션 아이템에 추가하고, submit 메소드에 연결한다.
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = submitBtn
        
    }
    
    //스위치와 상호반응할 메소드
    @objc func presentUpdateValue(_ sender: UISwitch) {
        self.txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    //스테퍼와 상호반응할 메소드
    @objc func presentIntervalValue(_ sender: UIStepper) {
        //sender.value 가 실수형이라서 Int로 캐스팅
        self.txtInterval.text = "\(Int(sender.value))분마다"
    }
    
    //전송버튼과 상호반응할 액션 메소드
    @objc func submit(_ sender: Any) {
        let rcv = ReadViewController()
        rcv.pEmail = self.paramEmail.text
        rcv.pUpdate = self.paramUpdate.isOn
        rcv.pInterval = self.paramInterval.value
    }

}

