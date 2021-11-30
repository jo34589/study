//
//  ControlViewController.swift
//  Chapter03-Alert
//
//  Created by 엔나루 on 2021/08/19.
//

import UIKit

class ControlViewController: UIViewController {

    //이후 메소드 외부에서 슬라이더를 참조하기 위해 viewdidload 바깥에 정의.
    private let slider = UISlider()
    //연산 프로퍼티 본래는 get/set 구문을 이용하지만 이건 set 구문이 없어 set 예약어가 사라졌고
    //따라서 get 예약어도 생략할 수 있다.
    var sliderValue: Float {
        return self.slider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        
        self.slider.frame = CGRect(x: 0, y: 0, width: 170, height: 30)
        self.view.addSubview(self.slider)
        
        self.preferredContentSize = CGSize(width: self.slider.frame.width, height: self.slider.frame.height)
        
        // Do any additional setup after loading the view.
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
