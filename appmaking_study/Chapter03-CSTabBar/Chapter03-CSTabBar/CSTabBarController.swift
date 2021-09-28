//
//  CSTabBarController.swift
//  Chapter03-CSTabBar
//
//  Created by 엔나루 on 2021/09/25.
//

import UIKit
class CSTabBarController: UITabBarController {
    
    let csView = UIView()
    let tabItem01 = UIButton(type: .system)
    let tabItem02 = UIButton(type: .system)
    let tabItem03 = UIButton(type: .system)
    
    override func viewDidLoad() {
        //기존 바를 숨기기
        self.tabBar.isHidden = true
        
        //새로운 탭 바 역할을 할 뷰를 위해 기준 좌표와 크기를 정의합니다.
        let width = self.view.frame.width
        let height:CGFloat = 50
        let x: CGFloat = 0
        let y = self.view.frame.height - height
        
        //정의된 값을 이용하여 새로운 뷰의 속성을 설정합니다.
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = .brown
        
        self.view.addSubview(self.csView)
        
        //버튼의 높이와 너비 설정
        let tabBtnWidth = self.csView.frame.size.width/3
        let tabBtnHeight = self.csView.frame.height
        
        //버튼의 영역을 차례대로 설정
        self.tabItem01.frame = CGRect(x: 0, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem02.frame = CGRect(x: tabBtnWidth, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        self.tabItem03.frame = CGRect(x: tabBtnWidth*2, y: 0, width: tabBtnWidth, height: tabBtnHeight)
        
        //버튼의 공통 속성을 설정하고 뷰에 추가.
        self.addTabBarBtn(btn: tabItem01, title: "첫 번째 버튼", tag: 0)
        self.addTabBarBtn(btn: tabItem02, title: "두 번째 버튼", tag: 1)
        self.addTabBarBtn(btn: tabItem03, title: "세 번째 버튼", tag: 2)
        
        //초기에 첫번째 화면이 선택될수 있도록 정의.
        self.onTabBarItemClick(self.tabItem01)
        
    }
    
    //버튼의 공통 속성을 정의하기 위한 메소드
    func addTabBarBtn(btn: UIButton, title: String, tag: Int) {
        //버튼의 타이틀과 태그값을 입력한다.
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        
        //버튼의 텍스트 색상을 일반 상태와 선택된 상태로 나누어 설정한다.
        btn.setTitleColor(.yellow, for: .selected)
        btn.setTitleColor(.white, for: .normal)
        
        //버튼에 액션 메소드를 연결한다.
        btn.addTarget(self, action: #selector(onTabBarItemClick(_:)), for: .touchUpInside)
        
        //csView 에 추가
        self.csView.addSubview(btn)
    }
    
    @objc func onTabBarItemClick(_ sender: UIButton) {
        //모든 버튼을 선택되지 않은 상태로 초기화 처리한다.
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        
        //인자값으로 전달된 버튼만 선택된 상태로 변경한다.
        sender.isSelected = true
        //버튼이 바뀔때 화면도 같이 바뀔 수 있게 추가된 구문.
        self.selectedIndex = sender.tag
    }
}
