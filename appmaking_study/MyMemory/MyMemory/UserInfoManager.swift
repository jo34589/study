//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/10/14.
//

import UIKit
import Alamofire

struct UserInfoKey {
    //저장에 사용할 키
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
    static let tutorial = "TUTORIAL"
    
}

//계정 및 사용자 정보를 저장 관리하는 클래스
class UserInfoManager {
    //연산 프로퍼티 loginId 정의
    var loginId: Int {
        //다른 곳에서 loginId 라는 변수를 불러오면 이 값을 준다.
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        //다른 곳에서 loginId 에 값(v)을 대입하면 아래 구문을 실행한다.
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    
    var account: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set(v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set (v) {
            let ud = UserDefaults.standard
            ud.set(v, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    
    var profile: UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            } else {
                return UIImage(named: "account.jpg") //이미지가 없다면 기본 이미지
            }
        }
        set(v) {
            if v != nil {
                let ud = UserDefaults.standard
                ud.set(v!.pngData(), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    
    var isLogin: Bool {
        //로그인 아이디가 0 이거나 계정이 비어 있으면
        if self.loginId == 0 || self.account == nil {
            return false
        } else {
            return true
        }
    }
    
    func login(account: String, passwd: String, success: (()->Void)? = nil, fail: ((String)->Void)? = nil) {
        //todo: 이 부분은 나중에 서버와 연동되는 코드로 대체될 예정입니다.
        /*
        if account.isEqual("sqlpro@naver.com") && passwd.isEqual("1234") {
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("엔나루", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        } else {
            return false
        }
        */
        
        //1. url과 전송할 값 준비
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/login"
        let param: Parameters = [
            "account": account,
            "passwd": passwd
        ]
        
        //2. API 호출
        let call = AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default)
        
        //3. API 호출 결과 처리
        call.responseJSON() { res in
            //JSON 형식으로 응답했는지 확인
            let result = try! res.result.get()
            guard let jsonObject = result as? NSDictionary else {
                fail?("잘못된 응답 형식입니다:\(result)")
                return
            }
            //응답 코드 확인
            let resultCode = jsonObject["result_code"] as! Int
            if resultCode == 0 { //로그인 성공
                //user_info 이하 항목을 딕셔너리 형태로 추출하여 저장
                let user = jsonObject["user_info"] as! NSDictionary
                
                self.loginId = user["user_id"] as! Int
                self.account = user["account"] as? String
                self.name = user["name"] as? String
                //프로필 이미지 처리
                if let path = user["profile_path"] as? String {
                    if let imageData = try? Data(contentsOf: URL(string: path)!) {
                        self.profile = UIImage(data: imageData)
                    }
                }
                //인자값으로 입력된 success 클로저 블록 실행
                success?()
                
            } else { //로그인 실패
                let msg = (jsonObject["error_msg"] as? String) ?? "로그인이 실패했습니다."
                fail?(msg)
            }
        }
    }
    
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}
