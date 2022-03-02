//
//  TutorialMasterVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/20.
//

import UIKit

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {

    
    var pageVC: UIPageViewController!
    
    var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STEP 4"]
    //에셋카테고리에 등록된 이름을 사용.
    var contentImages = ["page0", "page1", "page2", "page3"]
    
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        //페이지 뷰 컨트롤러 객체 생성하기.
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC.dataSource = self
        
        //페이지 뷰 컨트롤러의 기본 페이지 지정
        let startContentVC = self.getContentVC(atIndex: 0)! //최초 노출
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true)
        
        //페이지 뷰 컨트롤러의 출력 영역 지정
        self.pageVC.view.frame.origin = CGPoint(x:0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        //페이지 뷰 컨트롤러를 마스터 뷰 컨트롤러의 자식 뷰 컨트롤러로 설정
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParent: self)
        
    }
    
    //콘텐츠 뷰 컨트롤러를 동적으로 생성할 메소드.
    //필요에 의해 정의하는 커스텀.
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        //인덱스가 데이터 배열 크기 범위를 벗어나면 nil
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        
        //"ContentsVC"라는 스토리보드ID를 가진 뷰 컨트롤러의 인스턴스를 생성하고 캐스팅한다.
        guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        
        //콘텐츠 뷰 컨트롤러 내용을 구성
        cvc.titleText = self.contentTitles[idx]
        cvc.imageFile = self.contentImages[idx] //
        cvc.pageIndex = idx
        
        return cvc
    }
    
    //현재 뷰컨트롤러보다 앞에 올 뷰컨트롤러
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //현재의 페이지 인덱스
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        //현재의 인덱스가 맨 앞이라면 nil 을 반환하고 종료
        guard index > 0 else {
            return nil
        }
        
        index -= 1
        return self.getContentVC(atIndex: index)
    }
    
    //현재 뷰컨트롤러보다 앞에 올 뷰컨트롤러
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //현재의 페이지 인덱스
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        index += 1
        
        //현재의 인덱스가 맨 앞이라면 nil 을 반환하고 종료
        guard index < self.contentTitles.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
