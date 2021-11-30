//
//  ViewController.swift
//  Chapter03-TapBar
//
//  Created by 엔나루 on 2021/08/04.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //title 레이블 생성
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        //title 레이블 속성 설정
        title.text = "첫번째 탭"
        title.textColor = UIColor.red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        
        //콘텐츠 내용에 맞게 레이블 크기 변경
        title.sizeToFit()
        
        //x축의 중앙에 오게 설정
        title.center.x = self.view.frame.width / 2
        
        //수퍼뷰에 추가
        self.view.addSubview(title)
        
    }

    //UIResponder에 정의되어 있음.
    //화면에서 터치가 끝났을 때 호출되는 메소드.
    //즉, 탭 한다고 표현하는 가벼운 터치가 발생했을 때 콜됨.
    //뷰컨을 탭하면 탭바를 숨김.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        //토글형식
        //tabBar?.isHidden = (tabBar?.isHidden == true) ? false : true
        
        //애니메이션
        //인자값: 초 ( 마이크로초 아님)
        //animate(withDuration: TimeInterval(0.15), animations: { ... }) 에서
        //animations: { ... } 부분의 매개변수를 생략한 채 트레일링 클로저로 떼 놓은 구문.
        UIView.animate(withDuration: TimeInterval(0.15)) {
            //alpha값이 0 이면 1로, 1이면 0으로 바꿔 준다.
            //호출될 때마다 점점 투명해졌다가 저점 진해질 것.
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0)
        }
        
    }
    

}

