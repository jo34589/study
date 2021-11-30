//
//  ListViewController.swift
//  Chapter05-UserDefaults
//
//  Created by 엔나루 on 2021/10/07.
//

import UIKit

class ListViewController: UITableViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex //0 이면 남, 1 이면 여
        
        let plist = UserDefaults.standard //기본 저장소 객체를 불러온다.
        plist.set(value, forKey: "gender") //"gender" 라는 키 값으로 객체를 저장
        plist.synchronize() //동기화 처리
        
    }
    
    @IBAction func changeMarried(_ sender: UISwitch) {
        let value = sender.isOn
        
        let plist = UserDefaults.standard
        plist.setValue(value, forKey: "married")
        plist.synchronize()
    }
    
    @IBAction func edit(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
        //알림에 텍스트 필드 추가
        alert.addTextField(configurationHandler: {$0.text = self.name.text})
        //알림 완료로 쓸 액션 추가. 이름 변경할 로직은 비워둔 상태.
        alert.addAction((UIAlertAction(title: "OK", style: .default) {
            (_) in
            let value = alert.textFields?[0].text //textFields 를 ! 해도 .text 가 옵셔널
            
            //UserDefaults 에서 불러오기.
            let plist = UserDefaults.standard
            plist.set(value, forKey: "name")
            plist.synchronize()
            
            self.name.text = value
        }))
        //알림 띄우기.
        self.present(alert, animated: true, completion: nil)
    }
    
    //메모리에서 제거되었다가 돌아올때는 다시 viewdidload 를 호출할 것이기 때문에
    //이번 실습에서는 여기 작성해도 괜찮다.
    override func viewDidLoad() {
        let plist = UserDefaults.standard
        
        //저장된 값을 꺼내어 각 컨트롤에 설정
        self.name.text = plist.string(forKey: "name")
        self.married.isOn = plist.bool(forKey: "married")
        self.gender.selectedSegmentIndex = plist.integer(forKey: "gender")
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {//제스처 인식을 통한 edit 함수를 들여왔기 때문에 사실 필요 없어짐.
        //다만 영역은 다름.
        /*
        if indexPath.row == 0 {
            //알림 컨트롤러 생성
            let alert = UIAlertController(title: nil, message: "이름을 입력하세요", preferredStyle: .alert)
            //알림에 텍스트 필드 추가
            alert.addTextField(configurationHandler: {$0.text = self.name.text})
            //알림 완료로 쓸 액션 추가. 이름 변경할 로직은 비워둔 상태.
            alert.addAction((UIAlertAction(title: "OK", style: .default) {
                (_) in
                let value = alert.textFields?[0].text //textFields 를 ! 해도 .text 가 옵셔널
                
                let plist = UserDefaults.standard
                plist.set(value, forKey: "name")
                plist.synchronize()
                
                //수정된 값을 이름 레이블에도 수정
                self.name.text = value
            }))
            //알림 띄우기.
            self.present(alert, animated: true, completion: nil)
         */
    }
    
    //사실 가장 좋은 방법은 아래 두 함수를 부르지 않는 것. 따라서 주석처리.
    //객체지향의 특성에 따라 자식클래스에서 호출되지 않으면 부모클래스에서 호출하기 때문.
    /*
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 3 static cell 에서는 NG
        //하드코딩으로 셀 개수를 지정하는 방법이기 때문
        //변경할때마다 값을 바꿔줘야 함
        //ListViewController 가 아니라 그냥 UITableViewController 일 때는 아무런 문제가 없었음.
        //따라서 부모의 함수를 그대로 가져옴.
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    //아래 함수도 마찬가지.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return super.numberOfSections(in: tableView)
    }
    */
}
