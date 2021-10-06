//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/06.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileImage = UIImageView() //프로필 사진 이미지
    let tv = UITableView() //프로필 목록
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "프로필"
        
        //뒤로가기 버튼 처리
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
        
        //추가) 배경 이미지 설정
        //프로필 이미지가 더 앞에 올 수 있도록 코드가 프로필 이미지를 작성하는 구간보다 위에 위치할 수 있게 해야 한다.
        let bg = UIImage(named: "profile-bg")
        let bgImg = UIImageView(image: bg)
        
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width/2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width/2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        self.view.addSubview(bgImg)
        
        //개인 프로필 영역 구현
        // 프로필 사진에 들어갈 기본 이미지
        let image = UIImage(named: "account.jpg")
        
        // 프로필 이미지 처리
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width/2, y: 270)
        
        // 프로필 이미지 둥글게 만들기: 마스크 효과를 적용
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        // 루트 뷰에 추가
        self.view.addSubview(self.profileImage)
        
        //테이블 뷰 프로퍼티의 기본 속성을 설정
        // 테이블 뷰
        // 프로필 이미지 아래 테이블 뷰가 위치하도록 함.
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        //테이블 뷰의 딜리게이트와 데이터 소스를 self 로 설정
        //클래스에서 설정한 프로토콜로 인해 가능.
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
        
        //view 에 추가한 subview 가 어떻게 보일지 확신이 없다면.
        self.view.bringSubviewToFront(self.tv)
        self.view.bringSubviewToFront(self.profileImage)
        
        //네비게이션 바 숨김 처리
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀의 내용을 설정
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        //책에서는 아래 두 문장으로 cell의 형태를 만들지만 이 두개는 deprecated 되어 잇다.
        //cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        //cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        //따라서 아래 내용으로 교체.
        var cellcontent = cell.defaultContentConfiguration()
        cellcontent.textProperties.font = UIFont.systemFont(ofSize: 14)
        cellcontent.secondaryTextProperties.font = UIFont.systemFont(ofSize: 13)
        
        cell.accessoryType = .disclosureIndicator
        
        //텍스트의 내용 또한 cellcontent 를 이용해야 함.
        switch indexPath.row {
        case 0:
            cellcontent.text = "이름"
            cellcontent.secondaryText = "가만안도 엔나루"
        case 1:
            cellcontent.text = "계정"
            cellcontent.secondaryText = "jo34589@naver.com"
        default:
            ()
        }
        
        cell.contentConfiguration = cellcontent
        return cell
    }
    
    @objc func close(_ sender: Any) {
        //화면 복귀를 위해 dismiss 메소드를 사용
        self.presentingViewController?.dismiss(animated: true)
    }
    
}
