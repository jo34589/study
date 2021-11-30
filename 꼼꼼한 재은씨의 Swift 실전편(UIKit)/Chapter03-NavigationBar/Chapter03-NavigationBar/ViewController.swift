//
//  ViewController.swift
//  Chapter03-NavigationBar
//
//  Created by 엔나루 on 2021/08/16.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.initTitle()
        //self.initTitleNew()
        //self.initTitleImage()
        //self.initTitleInput()
        self.initURLInput()
    }
    
    //완전하지 않은 것.
    func initTitle() {
        //타이틀용 레이블 객체
        let nTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        //줄 수
        nTitle.numberOfLines = 2
        
        //속성 설정
        nTitle.textAlignment = .center
        nTitle.font = UIFont.systemFont(ofSize: 15)
        nTitle.text = "58개 숙소 \n 1박(1월 10일 ~ 1월 11일)"
        
        //네비게이션 타이틀에 입력
        self.navigationItem.titleView = nTitle
        
        //배경 색상설정
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    
    func initTitleNew() {
        //복합적인 레이블을 구현할 컨테이너 뷰
        let containerView = UIView(frame:CGRect(x: 0, y: 0, width: 200, height: 36))
        
        //위 레이블
        let topTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 18))
        topTitle.numberOfLines = 1
        topTitle.textAlignment = .center
        topTitle.font = UIFont.systemFont(ofSize: 15)
        topTitle.textColor = .white
        topTitle.text = "58개 숙소"
        
        //아래 레이블
        let subTitle = UILabel(frame: CGRect(x: 0, y: 18, width: 200, height: 18))
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.font = UIFont.systemFont(ofSize: 12)
        subTitle.textColor = .white
        subTitle.text = "1박(1월 10일 ~ 1얼 11일)"
        
        //레이블들 추가
        containerView.addSubview(topTitle)
        containerView.addSubview(subTitle)
        
        //네비게이션바에 추가
        self.navigationItem.titleView = containerView
        
        //배경색 설정
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
        
    }
    
    func initTitleImage() {
        //@3x 를 붙이지 않아야 함.
        let image = UIImage(named: "swift_logo")
        let imageV = UIImageView(image: image)
        
        self.navigationItem.titleView = imageV
    }
    
    func initTitleInput() {
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.autocapitalizationType = .none
        tf.spellCheckingType = .no
        tf.keyboardType = .URL
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3
        tf.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        
        self.navigationItem.titleView = tf
        
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 50, height: 37)
        v.backgroundColor = .brown
        
        let leftItem = UIBarButtonItem(customView: v)
        self.navigationItem.leftBarButtonItem = leftItem
        
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 40, height: 37)
        rv.backgroundColor = .green
        
        let rightItem = UIBarButtonItem(customView: rv)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func initURLInput() {
        let tf = UITextField()
        tf.frame = CGRect(x: 0, y: 0, width: 300, height: 35)
        tf.backgroundColor = .white
        tf.font = UIFont.systemFont(ofSize: 13)
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.keyboardType = .URL
        tf.keyboardAppearance = .dark
        tf.layer.borderWidth = 0.3
        tf.layer.borderColor = UIColor.gray.cgColor
        
        //오른쪽 아이템 영역에 들어갈 컨테이너 뷰
        let lv = UIImage(named: "arrow-back")
        let leftItem = UIBarButtonItem(image: lv, style: .plain, target: self, action: nil)
        
        let rv = UIView()
        rv.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
        
        let cnt = UILabel()
        cnt.frame = CGRect(x: 10, y: 8, width: 20, height: 20)
        cnt.font = UIFont.boldSystemFont(ofSize: 10)
        cnt.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0)
        cnt.text = "12"
        cnt.textAlignment = .center
        
        cnt.layer.borderColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.0).cgColor
        cnt.layer.borderWidth = 2
        cnt.layer.cornerRadius = 3 // 모서리를 둥글게 처리
        
        rv.addSubview(cnt)
        
        let more = UIButton(type: .system)
        more.frame = CGRect(x: 50, y: 10, width: 16, height: 16)
        more.setImage(UIImage(named: "more"), for: .normal)
        
        rv.addSubview(more)
        
        let rightItem = UIBarButtonItem(customView: rv)
        
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.titleView = tf
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
}

