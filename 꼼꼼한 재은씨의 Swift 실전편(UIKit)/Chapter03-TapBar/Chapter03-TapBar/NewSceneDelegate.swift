//
//  NewSceneDelegate.swift
//  Chapter03-TapBar
//
//  Created by 엔나루 on 2021/08/12.
//

import UIKit

class NewSceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //탭 바 컨트롤러를 생성, 배경을 흰색으로 채우기
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white //직접 생성했기 때문에 기본 배경은 비어 있다(검은색나옴)
        
        //생성된 tbC를 루트 뷰 컨트롤러로 등록한다.
        //루트 뷰 컨트롤러를 결정하는 일은 window 가 한다.
        self.window?.rootViewController = tbC
        
        //탭 바 아이템에 연결된 뷰 컨트롤러의 객체를 생성한다.
        let view01 = ViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        //생성된 뷰 컨트롤러 객체들을 탭 바 컨트롤러에 등록한다.
        tbC.setViewControllers([view01, view02, view03], animated: false)
        
        //개별 탭 바 아이템 속성을 설정한다.
        //뷰 컨트롤러의 tabBarItem으로 참조해야 한다!
        view01.tabBarItem = UITabBarItem(title: "Calander", image: UIImage(named: "calander"), selectedImage: nil)
        view02.tabBarItem = UITabBarItem(title: "File", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo"), selectedImage: nil)
    }
}
