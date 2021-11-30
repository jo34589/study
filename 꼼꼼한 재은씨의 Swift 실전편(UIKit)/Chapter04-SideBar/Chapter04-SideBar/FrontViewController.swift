//
//  FrontViewController.swift
//  Chapter04-SideBar
//
//  Created by 엔나루 on 2021/09/30.
//

import UIKit

class FrontViewController : UIViewController {
    
    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //메인 컨틀롤러의 참조 정보를 가져온다.
        if let revealVC = self.revealViewController() {
            //버튼이 클릭될 때 메인 컨트롤러에 정의된 revealToggle(_:)을 호출하도록 정의한다.
            //bar button item 이기 때문에 addTarget 이 아니라 target과 action 속성에 각각 값을 넣어주어야 함.
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
        
    }
}
