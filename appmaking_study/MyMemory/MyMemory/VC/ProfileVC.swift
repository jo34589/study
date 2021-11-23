//
//  ProfileVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/06.
//

import UIKit
import PhotosUI
import Alamofire
import LocalAuthentication

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, /*UIPickerViewDelegate,*/ PHPickerViewControllerDelegate {
    
    
    var picker: PHPickerViewController?
    var pickerconf = PHPickerConfiguration()
    let uinfo = UserInfoManager()
    let profileImage = UIImageView() //프로필 사진 이미지
    let tv = UITableView() //프로필 목록
    
    //인디케이터
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    //api 호출 상태값
    var isCalling = false
    
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
        
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tokenValidate()
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
        //중복 처리 방지
        if self.isCalling == true {
            self.alert("응답을 기다리는 중입니다. \n잠시만 기다려 주세요.")
            return
        } else {
            self.isCalling = true
        }
        
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
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.isCalling = false
        })
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive){ (_) in
            //인디케이터 실행
            self.indicatorView.startAnimating()
            
            let account = loginAlert.textFields?[0].text ?? "" //계정
            let passwd = loginAlert.textFields?[1].text ?? "" //비밀번호

            //비동기 방식으로 변경되는 부분
            self.uinfo.login(account: account, passwd: passwd, success: {
                self.indicatorView.stopAnimating()
                self.isCalling = false
                
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
                self.drawBtn()
                
                //서버와 데이터 동기화
                let sync = DataSync()
                DispatchQueue.global(qos: .background).async {
                    sync.downloadBackupData()
                }
                
            }, fail: { msg in
                self.indicatorView.stopAnimating()
                self.isCalling = false
                
                self.alert(msg)
            })
            
            /*
             이 주석안의 내용은 위에서 비동기 방식으로 변경됨.
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
            */
        })
        self.present(loginAlert, animated: false)
    }
    
    @objc func doLogout(_ sender: Any) {
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) {
            (_) in
            
            self.indicatorView.startAnimating()
            
            self.uinfo.logout() {
                //로그아웃시 처리할 내용이 들어갈 예정
                self.indicatorView.stopAnimating()
                
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
        //인디케이터 실행
        self.indicatorView.startAnimating()
        
        let itemProvider = results.first?.itemProvider
        
        if let item = itemProvider, item.canLoadObject(ofClass: UIImage.self) {
            item.loadObject(ofClass: UIImage.self ) {
                (image, error) in
                DispatchQueue.main.async {
                    let img = image as? UIImage
                    self.uinfo.newProfile(img, success: {
                        //인디케이터 종료
                        self.indicatorView.stopAnimating()
                        self.profileImage.image = img
                    }, fail: { msg in
                        //인디케이터 종료
                        self.indicatorView.stopAnimating()
                        self.alert(msg, completion: nil)
                    })
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
    
    
    
    @IBAction func backProfileVC(_ segue: UIStoryboardSegue) {
        //단지 프로필 화면으로 되돌아오기 위한 표식 역할만 할뿐
        //아무 내용도 작성하지 않음
    }
}


extension ProfileVC {
    //토큰 인증 메소드
    func tokenValidate() {
        //0. 응답 캐시를 사용하지 않도록 한다.
        URLCache.shared.removeAllCachedResponses()
        // iOS 는 특정 http 호출이 빈번하게 발생하면 응답 캐시를 사용한다.(URLCache)
        // 토큰 유효성 검증의 경우 응답 캐시가 사용되면 서버와 디바이스 간에 동기화 문제가
        // 발생할 수 있다. 따라서 응답 캐시를 삭제한다.
        
        //1. 키 체인에 엑세스 토큰이 없을 경우 유효성 검증을 진행하지 않음.
        let tk = TokenUtils()
        guard let header = tk.getAuthorizationHeader() else {
            //getAuthorizationHeader() 는 엑세스 토큰이 비어 있으면 nil을 반환한다.
            //즉 로그인 한 적 없는 상태
            return
        }
        
        //로딩 인디케이터
        self.indicatorView.startAnimating()
        
        //2. tokenValidate API 를 호출
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/tokenValidate"
        let validate = AF.request(url, method: .post, encoding: JSONEncoding.default, headers: header)
        
        validate.responseJSON() { res in
            self.indicatorView.stopAnimating()
            
            let responseBody = try! res.result.get()
            print(responseBody) //응답 결과를 확인하기 위해 메시지 본문 전체를 출력
            guard let jsonObject = responseBody as? NSDictionary else {
                self.alert("잘못된 응답입니다.")
                return
            }
            //3. 응답 결과 처리
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode != 0 { //응답 결과가 실패일때, 즉 토큰이 만료되었을 때
                //로컬 인증 실행
                self.touchID()
            }
        } // end of response closure
    } // end of func tokenValidate()
    
    //터치 아이디 인증 메소드
    func touchID() {
        // 1. LAContext 인스턴스 생성
        let context = LAContext()
        
        // 2. 로컬 인증에 사용할 변수 정의
        var error: NSError?
        let msg = "인증이 필요합니다."
        //인증 정책
        let deviceAuth = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        
        // 3. 로컬 인증이 사용 가능한지 여부 확인
        if context.canEvaluatePolicy(deviceAuth, error: &error) {
            // 4. 터치 아이디 인증창 실행
            context.evaluatePolicy(deviceAuth, localizedReason: msg) {(success, e) in
                if success { // 5. 인증 성공
                    //토큰 갱신 메소드 실행
                    self.refresh()
                } else { // 6. 인증 실패
                    //여기 들어간 구문들은 어떻게든 인증이 실행되고 나서
                    //인증이 실패했을 때 실행되게 된다.
                    print((e?.localizedDescription)!)
                    
                    switch (e!._code) {
                    case LAError.systemCancel.rawValue:
                        self.alert("시스템에 의해 인증이 취소되었습니다.")
                    case LAError.userCancel.rawValue:
                        self.alert("사용자에 의해 인증이 취소되었습니다.") {
                            self.commonLogout(true)
                        }
                    case LAError.userFallback.rawValue:
                        //OperationQueue.main.addOperation()은
                        //인증창과 로그인용 경고창이 충돌하지 않게 하기 위해서 썼다.
                        //해제하고 테스트 할 경우 기기를 재부팅해야 함.
                        OperationQueue.main.addOperation() {
                            self.commonLogout(true)
                        }
                    default:
                        OperationQueue.main.addOperation {
                            self.commonLogout(true)
                        }
                    }
                }
            }
        } else { // 7. 인증창이 실행되지 못한 경우
            print(error!.localizedDescription)
            switch (error!.code) {
            case LAError.biometryNotEnrolled.rawValue:
                print("터치 아이디가 등록되지 않았습니다.")
            case LAError.passcodeNotSet.rawValue:
                print("패스 코드가 설정되어 있지 않습니다.")
            default: // LAError.touchIDNotAvailable 포함
                print("터치 아이디를 사용할 수 없습니다.")
            }
            OperationQueue.main.addOperation {
                self.commonLogout(true)
            }
        }
    }
    
    //토큰 갱신 메소드
    func refresh() {
        self.indicatorView.startAnimating()
        
        //1. 인증 헤더
        let tk = TokenUtils()
        let header = tk.getAuthorizationHeader()
        
        //2. 리프레시 토큰 전달 준비
        let refreshToken = tk.load("kr.co.rubypaper.MyMemory", account: "refreshToken")
        let param: Parameters = ["refresh_token" : refreshToken!]
        
        //3. 호출 및 응답
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/refresh"
        let refresh = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        refresh.responseJSON() { res in
            self.indicatorView.stopAnimating()
            
            guard let jsonObejct = try! res.result.get() as? NSDictionary else {
                self.alert("잘못된 응답입니다.")
                return
            }
            
            //4. 응답 결과 처리
            let resultCode = jsonObejct["result_code"] as! Int
            if resultCode == 0 { //성공: 엑세스 토큰 갱신됨
                //4-1. 키 체인에 저장된 엑세스 토큰 교체
                let accessToken = jsonObejct["access_toekn"] as! String
                tk.save("kr.co.rubypaper.MyMemory", account: "accessToken", value: accessToken)
            } else { //실패: 엑세스 토큰 만료
                //4-2. 로그아웃 처리
                self.alert("인증이 만료되었으므로 다시 로그인 해야 합니다.") {
                    OperationQueue.main.addOperation {
                        self.commonLogout(true)
                    }
                }
            }
        } // end of responseJSON closure
    }// end of func refresh
    
    func commonLogout(_ isLogin: Bool = false) {
        //1. 저장된 기존 개인 정보와 키 체인 데이터를 삭제하여 로그아웃 상태로 전환
        let userInfo = UserInfoManager()
        userInfo.deviceLogout()
        
        //2. 현재의 화면이 프로필 화면이라면 바로 UI를 갱신한다.
        self.tv.reloadData()
        self.profileImage.image = userInfo.profile
        self.drawBtn()
        
        //3. 기본 로그인 창 실행 여부
        if isLogin {
            self.doLogin(self)
        }
    }
}

