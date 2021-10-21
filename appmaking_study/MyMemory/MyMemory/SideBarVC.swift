//
//  SideBarVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/05.
//

import UIKit

class SideBarVC: UITableViewController {
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    let uinfo = UserInfoManager()
    
    //목록 데이터 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    //아이콘 데이터 배열
    let icons = [
        UIImage(named:"icon01.png"),
        UIImage(named:"icon02.png"),
        UIImage(named:"icon03.png"),
        UIImage(named:"icon04.png"),
        UIImage(named:"icon05.png"),
        UIImage(named:"icon06.png")
    ]
    
// MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //테이블뷰의 헤더 뷰 작성
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = .brown
        //작성한 뷰를 테이블뷰에 추가(등록)
        self.tableView.tableHeaderView = headerView
        
        //이름 레이블의 속성을 정의하고 헤더 뷰에 추가
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        //self.nameLabel.text = "가만안도 엔나루"
        self.nameLabel.textColor = .white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.nameLabel.backgroundColor = .clear
        
        headerView.addSubview(self.nameLabel)
        
        //이메일 레이블의 속성을 정의하고, 헤더 뷰에 추가한다.
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 150, height: 30)
        //self.emailLabel.text = "jo34589@naver.com"
        self.emailLabel.textColor = .white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = .clear
        
        headerView.addSubview(emailLabel)
        
        //기본 이미지를 구현한다.
        //let defaultProfile = UIImage(named: "account.jpg")
        //self.profileImage.image = defaultProfile //이미지 등록
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50) //위치와 크기를 정의
        
        //프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2) //반원 형태로 라운딩
        self.profileImage.layer.borderWidth = 0 //테두리 두께 0으로
        self.profileImage.layer.masksToBounds = true //마스크 효과
        
        view.addSubview(self.profileImage) //헤더 뷰에 추가
    }
    
// MARK: - viewWillAppear
    
    //사이드 바가 화면에 표시될 때 마다 로그인 정보를 읽어와 갱신하도록 메소드를 작성
    //viewWillAppear 메소드는 화면이 표시될 때 마다 실행됨.
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재사용 큐에서 테이블 셀을 꺼내 온다. 없으면 새로 생성한다.
        let id = "menucell" //테이블 셀 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        //타이틀과 이미지를 대입한다.
        //cell 의 아래 두 속성은 deprecated 된 상황.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        //폰트 설정
        //deprecated
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { //새 글 작성을 눌렀을 때
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            //사이드바 컨트롤러에서 프론트 컨트롤러를 직접 참조할 수 없음.
            //메인 컨트롤러는 사이드 바와 프론트 양쪽을 참조함.
            let target = self.revealViewController().frontViewController as! UINavigationController
            //푸시 뷰 호출.
            target.pushViewController(uv!, animated: true)
            //사이드 바 닫아주기
            self.revealViewController().revealToggle(self)
        } else if indexPath.row == 5 { //계정 관리
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            //모달 방식으로 전시(아래에서 위로 올라옴)
            uv?.modalPresentationStyle = .fullScreen
            //completion: 부분을 클로저로 처리
            //사이드바를 닫음.
            self.present(uv!, animated: true) {
                self.revealViewController().revealToggle(self)
            }
        }
    }
}
