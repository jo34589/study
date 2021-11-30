//
//  PickerController.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/11/03.
//

import UIKit

class DepartPickerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //DAO 객체
    let departDAO = DepartmentDAO()
    var departList: [(departCd: Int, departTitle: String, departAddr: String)]! //피커 뷰의 데이터 소스
    var pickerView: UIPickerView!
    
    var selectedDepartCd: Int {
        let row = self.pickerView.selectedRow(inComponent: 0)
        return self.departList[row].departCd
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.departList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var titleView = view as? UILabel
        if titleView == nil {
            titleView = UILabel()
            titleView?.font = UIFont.systemFont(ofSize: 14)
            titleView?.textAlignment = .center
        }
        
        titleView?.text = "\(self.departList[row].departTitle) (\(self.departList[row].departAddr))"
        
        return titleView!
    }
    
    override func viewDidLoad() {
        //초기화 코드
        // db에서 부서 목록을 가져와 튜플 배열을 초기화한다.
        self.departList = self.departDAO.find()
        
        // 피커 뷰 객체를 초기화하고, 최상위 뷰의 서브 뷰로 추가한다.
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.view.addSubview(self.pickerView)
        
        // 외부에서 뷰 컨트롤러를 참조할 때를 위한 사이즈를 지정한다.
        let pWidth = self.pickerView.frame.width
        let pHeight = self.pickerView.frame.height
        
        self.preferredContentSize = CGSize(width: pWidth, height: pHeight)
    }
}
