//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/06.
//

import UIKit
import PhotosUI

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, /*UIPickerViewDelegate,*/ PHPickerViewControllerDelegate {
    
    
    var picker: PHPickerViewController?
    var pickerconf = PHPickerConfiguration()
    let uinfo = UserInfoManager()
    let profileImage = UIImageView() //프로필 사진 이미지
    let tv = UITableView() //프로필 목록
    
// MARK: - viewDidLoad
    
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
        //let image = UIImage(named: "account.jpg")
        let image = self.uinfo.profile
        
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
        
        //버튼그리기
        self.drawBtn()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        self.profileImage.isUserInteractionEnabled = true
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
            //cellcontent.secondaryText = "가만안도 엔나루"
            cellcontent.secondaryText = self.uinfo.name ?? "Login please"
        case 1:
            cellcontent.text = "계정"
            //cellcontent.secondaryText = "jo34589@naver.com"
            cellcontent.secondaryText = self.uinfo.account ?? "Login please"
        default:
            ()
        }
        
        cell.contentConfiguration = cellcontent
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath) {
        if self.uinfo.isLogin == false {
            //로그인되어 있지 안핟면 로그인 창을 띄워 준다.
            self.doLogin(self.tv)
        }
    }
    
    @objc func close(_ sender: Any) {
        //화면 복귀를 위해 dismiss 메소드를 사용
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func doLogin(_ sender: Any) {
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)
        
        //알림창에 들어갈 입력폼 추가.
        loginAlert.addTextField() {
            (tf) in
            tf.placeholder = "Your Account"
        }
        loginAlert.addTextField() {
            (tf) in
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true
        }
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive){ (_) in
            let account = loginAlert.textFields?[0].text ?? "" //계정
            let passwd = loginAlert.textFields?[1].text ?? "" //비밀번호
            
            if self.uinfo.login(account: account, passwd: passwd) {
                //todo: 로그인 성공시 처리할 내용이 들어갈 예정
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()
                
            } else {
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
            }
        })
        self.present(loginAlert, animated: false)
    }
    
    @objc func doLogout(_ sender: Any) {
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) {
            (_) in
            if self.uinfo.logout() {
                //로그아웃시 처리할 내용이 들어갈 예정
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()
            }
        })
        self.present(alert, animated: false)
    }
    
    func drawBtn() {
        //버튼을 감쌀 뷰를 정의한다.
        let v = UIView()
        v.frame.size.width = self.view.frame.width
        v.frame.size.height = 40
        v.frame.origin.x = 0
        v.frame.origin.y = self.tv.frame.origin.y + self.tv.frame.height
        v.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        
        self.view.addSubview(v)
        
        //버튼을 정의한다.
        let btn = UIButton(type: .system)
        btn.frame.size.width = 100
        btn.frame.size.height = 30
        btn.center.x = v.frame.size.width / 2
        btn.center.y = v.frame.size.height / 2
        
        //로그인 상태일때는 로그아웃, 로그아웃일때는 로그인
        if self.uinfo.isLogin == true {
            btn.setTitle("로그아웃", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        } else {
            btn.setTitle("로그인", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        v.addSubview(btn)
    }
    /*
     //will use phpicker instead of uiimagepicker
     //some of UIImagePickerController.sourcyType is deprecated.
    func imgPicker(_ source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
     */
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        //픽커에서 사용자가 고른 사진을 프로필이미지칸에 올린다.
        picker.dismiss(animated: true, completion: nil)
        
        let itemProvider = results.first?.itemProvider
        
        if let item = itemProvider, item.canLoadObject(ofClass: UIImage.self) {
            item.loadObject(ofClass: UIImage.self ) {
                (image, error) in
                DispatchQueue.main.async {
                    self.profileImage.image = image as? UIImage
                }
            }
        } else {
            //handle if itemprovider cannot load itema as UIImage
            NSLog("cannot load item as UIImage")
            return
        }
    }
    
    //프로필 사진의 소스 타입을 선택하는 액션 메소드
    @objc func profile(_ sender: UIButton) {
        //로그인되어 있지 않을 경우 프로필 이미지 등록을 막고 대신 로그인 창을 띄워 준다.
        guard self.uinfo.account != nil else {
            self.doLogin(self)
            return
        }
        
        let alert = UIAlertController(title: nil, message: "사진을 가져올 곳을 선택해 주세요.", preferredStyle: .actionSheet)
        
        var pickerconf = PHPickerConfiguration()
        pickerconf.selectionLimit = 1
        pickerconf.filter = .images
        
        let picker = PHPickerViewController(configuration: pickerconf)
        picker.delegate = self
        
        alert.addAction(UIAlertAction(title: "사진 가져오기", style: .default) {(_) in
            self.present(picker, animated: true)
        })
        
        /*
         //deprecated 된 내용이 있어 같은 기능을 하는 코드를 대체.
        //카메라를 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable((.camera)) {
            alert.addAction(UIAlertAction(title: "카메라", style: .default) { (_) in
                self.imgPicker(.camera)
            })
        }
        
        //저장된 앨범을 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable((.camera)) {
            alert.addAction(UIAlertAction(title: "저장된 앨범", style: .default) { (_) in
                self.imgPicker(.savedPhotosAlbum) //deprecated
            })
        }
        
        //포토 라이브러리를 사용할 수 있으면
        if UIImagePickerController.isSourceTypeAvailable((.camera)) {
            alert.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) { (_) in
                self.imgPicker(.photoLibrary) //deprecated
            })
        }
        */
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
        
    }
    
}
