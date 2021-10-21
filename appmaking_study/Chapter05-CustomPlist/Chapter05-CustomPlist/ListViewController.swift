//
//  ListViewController.swift
//  Chapter05-CustomPlist
//
//  Created by 엔나루 on 2021/10/12.
//

import UIKit

class ListViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - PickerViewDelegate functions

    //생성할 컴포넌트의 개수를 정의.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //지정된 컴포넌트가 가질 목록의 길이
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.accountlist.count
    }
    //지정된 컴포넌트의 목록 각 행에 출력될 내용을 정의합니다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.accountlist[row]
    }
    //지정된 컴포넌트의 목록 각 행을 사용자가 선택했을 대 실행할 액션을 정의합니다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //선택된 계정값을 텍스트 필드에 입력
        let account = self.accountlist[row] //선택된 계정
        self.account.text = account
        
        //입력 뷰를 닫음
        //self.view.endEditing(true)
        
        //사용자가 계정을 생성하면 이 계정을 선택한 것으로 간주하고 저장
        let plist = UserDefaults.standard
        plist.set(account, forKey: "selectedAccount")
        plist.synchronize()
    }
    
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    //더미
    //var accountlist = ["sqlpro@naver.com",
                       //"webmaster@rubypaper.co.kr",
                       //"abc1@gmail.com",
                       //"abc2@gmail.com",
                       //"abc3@gmail.com"]
    //실제
    var accountlist = [String]()

    //메인 번들에 정의된 Plist 내용을 저장할 딕셔너리
    var defaultPlist: NSDictionary!
    
    // MARK: - vidwDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //메인 번들에 UserInfo.plist 가 포함되어 있으면 이를 읽어와 딕셔너리에 담는다.
        if let defaultPlistPath = Bundle.main.path(forResource: "UserInfo", ofType: "plist") {
            self.defaultPlist = NSDictionary(contentsOf: URL(fileURLWithPath: defaultPlistPath))
        }
        let picker = UIPickerView()
        
        //피커 뷰의 델리게이트 객체 지정
        picker.delegate = self
        //account 텍스트 필드 입력 방식을 가상 키보드 대신 피커 뷰로 설정
        self.account.inputView = picker
        
        //툴바 객체 정의
        let toolbar = UIToolbar()
        //툴 바를 프로그래밍 방식으로 설정할 때는 높이만 설정해주면 된다.
        toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        toolbar.barTintColor = .lightGray
        
        //액세서리 뷰 영역에 툴 바를 표시
        //악세사리 뷰 영역이란 키보드나 피커 뷰 위에 높지 않게 등장하는 바.
        self.account.inputAccessoryView = toolbar
        
        // 툴 바에 들어갈 닫기 버튼
        let done = UIBarButtonItem()
        done.title = "Done"
        done.target = self
        done.action = #selector(pickerDone)
        
        //가변 폭 정의
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //툴바에 들어갈 new 버튼
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        toolbar.setItems([new, flexSpace, done], animated: true)
        
        //기본 저장소 객체 불러오기
        let plist = UserDefaults.standard
        
        //불러온 값을 설정
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
        
        //저장된 계정목록을 불러오기.
        let accountlist = plist.array(forKey: "accountlist") as? [String] ?? [String]()
        self.accountlist = accountlist
        //저장된 '선택된 계정'을 불러오기
        if let account = plist.string(forKey: "selectedAccount") {
            self.account.text = account
            
            let customPlist = "\(account).plist"
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let url = URL(fileURLWithPath: clist)
            let data = NSDictionary(contentsOf: url)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
        
        //사용자의 계정의 값이 비어 있다면 값을 설정하는 것을 막는다.
        if (self.account.text?.isEmpty)! {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled = false
            self.married.isEnabled = false
        }
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
        
    }
    // MARK: - vidwDidLoad_END

    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex //0 이면 남 1이면 여
        
        //UserDefaults 사용시
        //기본 저장소 객체를 가져와 키로 값을 저장하고 동기화 처리
        //let plist = UserDefaults.standard
        //plist.set(value, forKey: "gender")
        //plist.synchronize()
        
        //커스텀 plist 사용시
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let url = URL(fileURLWithPath: plist)
        let data = NSMutableDictionary(contentsOf: url) ?? NSMutableDictionary(dictionary: self.defaultPlist)
        
        data.setValue(value, forKey: "gender")
        do {
            try data.write(to: url)
        }
        catch {
            NSLog("gender data writing failed")
        }
    }
    
    @IBAction func chengeMarried(_ sender: UISwitch) {
        let value = sender.isOn // true 이면 기혼, false 이면 미혼
        
        //UserDefaults 사용
        //let plist = UserDefaults.standard
        //plist.set(value, forKey: "married")
        //plist.synchronize()
        
        //커스텀 plist 사용
        let customPlist = "\(self.account.text!).plist"
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = paths[0] as NSString
        let plist = path.strings(byAppendingPaths: [customPlist]).first!
        let url = URL(fileURLWithPath: plist)
        let data = NSMutableDictionary(contentsOf: url) ?? NSMutableDictionary(dictionary: self.defaultPlist)
        
        data.setValue(value, forKey: "married")
        do {
            try data.write(to: url)
        }
        catch {
            NSLog("married data writing failed")
        }
        
        print("custom plist = \(plist)")
        print("url = \(url)")
    }
    
    @objc func pickerDone(_ sender: Any) {
        self.view.endEditing(true)
        if let _account = self.account.text {
            let customPlist = "\(_account).plist"
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let path = paths[0] as NSString
            let clist = path.strings(byAppendingPaths: [customPlist]).first!
            let url = URL(fileURLWithPath: clist)
            let data = NSDictionary(contentsOf: url)
            
            self.name.text = data?["name"] as? String
            self.gender.selectedSegmentIndex = data?["gender"] as? Int ?? 0
            self.married.isOn = data?["married"] as? Bool ?? false
        }
    }
    
    @objc func newAccount(_ sender: Any) {
        //열려 있는 입령용 뷰를 닫는다.
        self.view.endEditing(true)
        
        //알림창 객체 생성
        let alert = UIAlertController(title: "새 계정을 입력하세요", message: nil, preferredStyle: .alert)
        
        //입력폼 추가
        alert.addTextField(configurationHandler: {
            $0.placeholder = "ex) abc@gmail.com"
        })
        
        //버튼 및 액션 정의
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            (_) in
            if let account = alert.textFields?[0].text {
                self.accountlist.append(account)
                self.account.text = account
                
                //컨트롤의 값을 초기화
                self.name.text = ""
                self.gender.selectedSegmentIndex = 0
                self.married.isOn = false
                
                //계정 목록을 통째로 저장한다.
                let plist = UserDefaults.standard
                
                plist.set(self.accountlist, forKey: "accountlist")
                plist.set(account, forKey: "selectedAccount")
                plist.synchronize()
                
                self.gender.isEnabled = true
                self.married.isEnabled = true
            }
        }))
        
        //알림창 오픈
        self.present(alert, animated: false, completion: nil)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        //첫번째 행: 이름
        if indexPath.row == 1 && !(self.account.text?.isEmpty)! {
            //입력이 가능한 알림창을 띄워 이름을 수정할 수 있도록 해준다.
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: {
                $0.text = self.name.text
            })
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: {
                (_) in
                let value = alert.textFields?[0].text
                
                //커스텀 plist를 사용하기 위해 userdefaults 삭제
                //let plist = UserDefaults.standard
                //plist.set(value, forKey: "name")
                //plist.synchronize()
                
                //커스텀 plist 저장로직
                let customPlist = "\(self.account.text!).plist"
                
                let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = paths[0] as NSString
                let plist = path.strings(byAppendingPaths: [customPlist]).first!
                let url = URL(fileURLWithPath: plist)
                let data = NSMutableDictionary(contentsOf: url) ?? NSMutableDictionary(dictionary: self.defaultPlist)
                
                data.setValue(value, forKey: "name")
                do {
                    try data.write(to: url)
                }
                catch {
                    NSLog("name data writing failed.")
                }
                
                self.name.text = value
            })
            
            alert.addAction(ok)
            
            self.present(alert, animated: false, completion: nil)
        }
    }
    
}
