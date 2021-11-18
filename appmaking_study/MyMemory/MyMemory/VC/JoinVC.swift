//
//  JoinVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/11/17.
//

import UIKit
import Alamofire
import PhotosUI

class JoinVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPickerViewControllerDelegate {
    
    
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    //테이블 뷰에 들어갈 텍스트 필드들
    var fieldAccount: UITextField! //계정 필드
    var fieldPassword: UITextField! //비밀번호 필드
    var fieldName: UITextField! //이름 필드
    
    //API 호출 상태값을 관리할 변수
    var isCalling = false
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //프로필 이미지 원형으로 깍기
        self.profile.layer.cornerRadius = self.profile.frame.width / 2
        self.profile.layer.masksToBounds = true
        
        //프로필 이미지에 탭 제스처 및 액션 이벤트 설정
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
        
        //인디케이터 뷰를 화면 맨 앞으로
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    //MARK: - tableView func
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        //각 테이블 뷰 셀 안에 들어갈 텍스트필드 모두에 공통으로 적용할 프레임 객체
        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width-20, height: 37)
        
        switch indexPath.row {
        case 0:
            self.fieldAccount = UITextField(frame: tfFrame)
            self.fieldAccount.placeholder = "계정(이메일)"
            self.fieldAccount.borderStyle = .none
            self.fieldAccount.autocapitalizationType = .none
            self.fieldAccount.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldAccount)
        case 1:
            self.fieldPassword = UITextField(frame: tfFrame)
            self.fieldPassword.placeholder = "비밀번호"
            self.fieldPassword.borderStyle = .none
            self.fieldPassword.autocapitalizationType = .none
            self.fieldPassword.isSecureTextEntry = true
            self.fieldPassword.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldPassword)
        case 2:
            self.fieldName = UITextField(frame: tfFrame)
            self.fieldName.placeholder = "이름"
            self.fieldName.borderStyle = .none
            self.fieldName.font = UIFont.systemFont(ofSize: 14)
            cell.addSubview(self.fieldName)
        default:
            ()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    //MARK: - when tap profile
    @objc func tappedProfile(_ sender: Any) {
        //전반부: 원하는 소스 타입을 선택할 수 있는 액션 시트 구현
        let msg = "프로필 이미지를 읽어올 곳을 선택하세요."
        let sheet = UIAlertController(title: msg, message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "포토 라이브러리", style: .default) {
            (_) in
            var pickerconf = PHPickerConfiguration()
            pickerconf.selectionLimit = 1
            pickerconf.filter = .images
            
            let picker = PHPickerViewController(configuration: pickerconf)
            picker.delegate = self
            
            self.present(picker, animated: false)
            
        })
        sheet.addAction(UIAlertAction(title: "카메라", style: .default) {
            (_) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                
                self.present(picker, animated: false)
            } else {
                //Utils 에서 extension 으로 정의한 알림창 간소화 메소드
                self.alert("카메라를 사용할 수 없습니다.")
            }
        })
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) {
                    (image, error) in
                    DispatchQueue.main.async {
                        self.profile.image = image as? UIImage
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let rawVal = UIImagePickerController.InfoKey.originalImage.rawValue
        if let img = info[UIImagePickerController.InfoKey(rawValue: rawVal)] as? UIImage {
            self.profile.image = img
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - IBAction(done btn)
    
    @IBAction func submit(_ sender: Any) {
        if self.isCalling == true{
            self.alert("진행 중입니다. 잠시만 기다려주세요.")
            return
        } else {
            self.isCalling = true
        }
        
        //인디케이터 뷰 회전 시작
        self.indicatorView.startAnimating()
        
        //1. 전달할 값 준비
            //이미지를 Base64인코딩 처리
        let profileImg = self.profile.image!.pngData()?.base64EncodedString()
            //전달값을 Parameters 타입의 객체로 정의
            // Parameters 는 Alamofire 에 정의되어 있음.
        let param: Parameters = [
            "account"       : self.fieldAccount.text!,
            "passwd"        : self.fieldPassword.text!,
            "name"          : self.fieldName.text!,
            "profile_image" : profileImg
        ]
        
        //2. api 호출
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/join"
        let call = AF.request(url, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default)
        
        //3. 서버 응답값 처리
        call.responseJSON() { res in
            //인디케이터 뷰 애니메이션 정지
            self.indicatorView.stopAnimating()
            //JSON 형식으로 값이 제대로 전달되었는지 확인
            guard let jsonObject = try! res.result.get() as? [String: Any] else {
                self.isCalling = false
                self.alert("서버 호출 과정에서 오류가 발생했습니다.")
                return
            }
            
            //응답 코드 확인. 0 이면 성공(서버에서 설정)
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode == 0 {
                self.alert("가입이 완료되었습니다.") {
                    self.performSegue(withIdentifier: "backProfielVC", sender: self)
                }
            } else {
                self.isCalling = false
                let errorMsg = jsonObject["error_msg"] as! String
                self.alert("오류발생: \(errorMsg)")
            }
        }
    }
}
