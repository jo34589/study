//
//  RevealViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 엔나루 on 2021/10/04.
//

import UIKit

//컨테이너 뷰 컨트롤러
//컨테이너 뷰 컨트롤러는 다른 뷰 컨트롤러를 구조적으로 표현하고 관리하는 역할을 맡고 있다.
//'자식 뷰 컨트롤러'라고 불리는 여러 개의 뷰 컨트롤러를 포함하고 관리하는 데 사용됨.
//하나의 뷰 컨트롤러가 다른 뷰 컨트롤러로 전환되는 방식을 제어하기도 함.
//ex) 분할 뷰 컨트롤러, 페이지 뷰 컨트롤러, 내비게이션 컨트롤러, 탭 바 컨트롤러 등.
class RevealViewController: UIViewController {
    
    var contentVC: UIViewController? // 콘텐츠를 담당할 뷰 컨트롤러
    var sideVC: UIViewController? // 사이드 바 메뉴를 담당할 뷰 컨트롤러
    
    var isSideBarShowing = false // 현재 사이드 바가 열려 있는지 여부
    
    let SLIDE_TIME = 0.3 // 사이드 바가 열리고 닫히는 데 걸리는 시간
    let SIDEBAR_WIDTH: CGFloat = 260 //사이드 바가 열릴 너비
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    // 초기 화면을 설정한다.
    func setupView() {
        //프론트 컨트롤러 객체를 읽어온다.
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            //읽어온 컨트롤러를 클래스 전체어서 참조할 수있도록 contentVC 속성에 저장한다.
            self.contentVC = vc
            //_프론트 컨트롤러 객체를 메인 컨트롤러의 자식으로 등록한다.
            self.addChild(vc) //_프론트 컨트롤러를 메인 컨트롤러의 자식 뷰 컨트롤러로 등록
            self.view.addSubview(vc.view) //_프론트 컨트롤러를 뷰의 메인 컨트롤러의 서브 뷰로 등록
            
            //_프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다.
            vc.didMove(toParent: self)
            
            //프론트 컨트롤러의 델리게이트 변수에 참조 정보를 넣어준다.
            //vc 는 네비게이션 뷰 컨트롤러
            //네비게이션 뷰 컨트롤러에 연결된 뷰 컨트롤러 중 첫번째 뷰 컨트롤러를 가져와서
            //FrontViewController로 타입 캐스팅하고 frontVC에 저장
            let frontVC = vc.viewControllers[0] as? FrontViewController
            frontVC?.delegate = self
        }
    }
    
    // 사이드 바의 뷰를 읽어온다.
    func getSideView() {
        guard self.sideVC == nil else {
            return
        }
        
        // 사이드 바 컨트롤러 객체를 읽어온다.
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") else {
            return
        }
        
        //다른 메소드에서도 참조할 수 있도록 sideVC 속성에 저장한다.
        self.sideVC = vc
        
        //읽어온 사이드 바 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결한다.
        self.addChild(vc)
        self.view.addSubview(vc.view)
        
        //사이드바 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 아려준다.
        vc.didMove(toParent: self)
        
        //_프론트 컨트롤러의 뷰를 제일 위로 올린다.
        self.view.bringSubviewToFront((self.contentVC?.view)!)
    }
    
    // 콘텐츠 뷰에 그림자 효과를 준다.
    func setShadowEffect(shadow: Bool, offset: CGFloat) {
        if (shadow == true) { //그림자 효과 설정
            self.contentVC?.view.layer.masksToBounds = false 
            self.contentVC?.view.layer.cornerRadius = 10 //그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8 //그림자 투명도 설정
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor //그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset) //그림자 크기
        } else {
            //그림자 없애기
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    //사이드 바를 연다.
    func openSideBar(_ complete: ( () -> Void)? ){
        
        //앞에서 정의했던 메소드들을 실행
        self.getSideView() //사이드 바 뷰를 읽어온다.
        self.setShadowEffect(shadow: true, offset: -2) //그림자 효과를 준다.
        //왜 offset 이 -2 이지?
        
        //애니메이션 옵션
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),//애니메이션 실행 시간(초)
                       delay: TimeInterval(0),//실행 전 대기할 시간(초)
                       options: options, //미리 지정해둔 애니메이션 실행 옵션
                       animations: { //실행할 애니메이션 내용
            //결과를 입력함
            //contentVC의 frame을 SIDEBAR_WIDTH 만큼 민다.
            self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        },
                       completion: { //애니메이션 종료 후 실행할 함수
            // 클로저의 $0 는 그럼 무얼 뜻하는 거지?
            // completion 에 들어갈 함수는 반드시 Bool 타입의 매개변수를 가져야 함.
            // 해당 함수를 호출 할 때 애니메이션의 실행 완료 여부를 여기에 넣어 전달하기 때문.
            // 따라서 $0 가 true 라면 애니메이션이 종료되었다는 뜻.
            if $0 == true {
                self.isSideBarShowing = true
                complete?()
            }
        })
    }
    
    
    //사이드 바를 닫는다.
    func closeSideBar(_ complete: ( () -> Void)? ) {
        
        //애니메이션 옵션
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(withDuration: TimeInterval(self.SLIDE_TIME),//애니메이션 실행 시간(초)
                       delay: TimeInterval(0),//실행 전 대기할 시간(초)
                       options: options, //미리 지정해둔 애니메이션 실행 옵션
                       animations: { //실행할 애니메이션 내용
            //결과를 입력함
            //contentVC의 frame의 x 좌표를 0으로 되돌린다.
            self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        },
                       completion: { //애니메이션 종료 후 실행할 함수
            if $0 == true {
                // 사이드 바 뷰를 제거한다.
                self.sideVC?.view.removeFromSuperview()
                self.sideVC = nil
                
                //닫힘 상태로 플래그를 변경.
                self.isSideBarShowing = false
                
                //그림자 효과를 제거
                self.setShadowEffect(shadow: false, offset: 0)
                
                //인자값으로 입력받은 완료함수를 실행
                complete?()
            }
        })
    }
}
