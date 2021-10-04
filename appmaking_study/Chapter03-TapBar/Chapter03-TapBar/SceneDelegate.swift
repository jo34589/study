//
//  SceneDelegate.swift
//  Chapter03-TapBar
//
//  Created by 엔나루 on 2021/08/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        //루트 뷰 컨트롤러를 UITabBarController 로 캐스팅한다.
        if let tbC = self.window?.rootViewController as? UITabBarController {
            //탭 바에서 탭 바 아이템 배열을 가져온다.
            if let tbItems = tbC.tabBar.items {
                //탭 바 아이템에 커스텀 이미지를 등록하고, 타이틀을 설정한다.
                //tbItems[0].image = UIImage(named: "calendar")
                //tbItems[1].image = UIImage(named: "file-tree")
                //tbItems[2].image = UIImage(named: "photo")
                tbItems[0].image = UIImage(named: "designbump")?.withRenderingMode(.alwaysOriginal)
                tbItems[1].image = UIImage(named: "rss")?.withRenderingMode(.alwaysOriginal)
                tbItems[2].image = UIImage(named: "facebook")?.withRenderingMode(.alwaysOriginal)
                
                tbItems[0].title = "Calendar"
                tbItems[1].title = "file"
                tbItems[2].title = "photo"
                
                //탭 바 아이템 전체를 순회하면서
                for tbItem in tbItems {
                    //selectedImage 속성에 이미지를 설정한다.
                    let image = UIImage(named: "checkmark")?.withRenderingMode(.alwaysOriginal)
                    tbItem.selectedImage = image
                    
                    //탭 바 아이템별 텍스트 색상 속성을 설정한다.
                    //attributes 메소드를 사용하기 때문에 NSAttributedStirng.Key 에 정의되어 있는 걸 사용해야 하며, 이 중에서 색상은 .foregorundColor 키에, 값은 UIColor를 가진다.
                    tbItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .disabled)
                    tbItem.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
                    
                    tbItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15)], for: .normal)
                }
            }
            /*
            tbC.tabBar.tintColor = .white
            tbC.tabBar.unselectedItemTintColor = .gray
            
            tbC.tabBar.backgroundImage = UIImage(named: "menubar-bg-mini")
            */
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
