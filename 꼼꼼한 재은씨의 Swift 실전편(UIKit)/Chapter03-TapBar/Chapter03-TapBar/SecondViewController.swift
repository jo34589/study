//
//  SecondViewController.swift
//  Chapter03-TapBar
//
//  Created by 엔나루 on 2021/08/04.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //title 레이블 생성
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        //title 레이블 속성 설정
        title.text = "두번째 탭"
        title.textColor = UIColor.red
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 14)
        
        //콘텐츠 내용에 맞게 레이블 크기 변경
        title.sizeToFit()
        
        //x축의 중앙에 오게 설정
        title.center.x = self.view.frame.width / 2
        
        //수퍼뷰에 추가
        self.view.addSubview(title)
        
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
