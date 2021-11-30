//
//  ReadViewController.swift
//  Chapter02-InputForm
//
//  Created by 엔나루 on 2021/08/03.
//

import UIKit

class ReadViewController: UIViewController {

    var pEmail: String?
    var pUpdate: Bool?
    var pInterval: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //스토리보드를 쓰지 않기 때문에 지정해야 함.
        self.view.backgroundColor = .white
        
        // 레이블 객체들 정의
        let email = UILabel()
        let update = UILabel()
        let interval = UILabel()
        
        email.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
        update.frame = CGRect(x: 50, y: 150, width: 300, height: 30)
        interval.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
        
        //전달받은 값을 레이블들에 표시한다.
        email.text = "전달받은 이메일 : \(self.pEmail!)"
        update.text = "업데이트 여부 : \(self.pUpdate == true ? "업데이트 함":"업데이트 안 함")"
        interval.text = "업데이트 주기 : \(self.pInterval!)분마다"
        
        //레이블들을 루트 뷰에 추가.
        self.view.addSubview(email)
        self.view.addSubview(update)
        self.view.addSubview(interval)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
