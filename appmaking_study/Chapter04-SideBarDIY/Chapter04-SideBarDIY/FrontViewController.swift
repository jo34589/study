//
//  FrontViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 엔나루 on 2021/10/04.
//

import UIKit

class FrontViewController: UIViewController {
    
    //사이드 바 오픈 기능을 위임할 델리게이트
    //델리게이트 변수: 특정 기능을 맡길 대상을 지정하기 위한 변수
    //맡길 기능이 있는 클래스를 타입으로 지정한다.
    //아직 데릴게이트 변수를 선언만 했고 내용물은 비어있는 상태.
    //변수에 값을 넣어주는 작업은 프론트 컨트롤러가 아니라 RevealViewController 클래스가 처리해야 함.
    //이를 위한 구문을 나중에 RevealViewController 에 추가할 예정.
    var delegate: RevealViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //사이드 바 오픈용 버튼 정의
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"),
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(moveSide(_:)) )
        
        //버튼을 네비게이션 바의 왼쪽 영역에 추가
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        //사이드바는 왼쪽에 있다는 인식이므로 왼쪽 화면 끝에서 오른쪽으로 미는 제스쳐가 필요.
        //화면 끝에서 다른 쪽으로 패닝하는 제스처를 정의
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self,
                                                        action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left //시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft) //뷰에 제스처 객체를 등록
        
        //화면을 스와이프 하는 제스처를 정의(사이드 메뉴 닫기용)
        let dragRight = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(moveSide(_:)))
        //스와이프 방향은 왼쪽
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight) //뷰에 제스쳐 객체를 등록
        
    }
    
    //사용자의 액션에 따라 델리게이트 메소드를 호출한다.
    @objc func moveSide(_ sender: Any) {
        //sender 에 따라 실행할 메소드를 달리 해준다.
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            } else {
                self.delegate?.closeSideBar(nil)
            }
        }
    }
}
