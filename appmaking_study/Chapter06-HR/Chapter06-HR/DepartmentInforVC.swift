//
//  DepartmentInforVC.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/11/04.
//

import UIKit

class DepartmentInfoVC: UITableViewController {
    //부서 정보를 저장할 데이터 타입
    typealias DepartRecord = (depratCd: Int, departTitle: String, departAddr: String)
    
    //부서 목록으로부터 넘겨 받을 부서 코드
    var departCd: Int!
    
    //DAO 객체
    let departDAO = DepartmentDAO()
    let empDAO = EmployeeDAO()
    
    //부서 정보와 사원 목록을 담을 멤버 변수
    var departInfo: DepartRecord!
    var empList: [EmployeeVO]!
    
    
    override func viewDidLoad() {
        self.departInfo = self.departDAO.get(departCd: self.departCd)
        self.empList = self.empDAO.find(departCd: self.departCd)
    }
}
