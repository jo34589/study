//
//  DepartmentInfoVC.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/11/04.
//

import UIKit

class DepartmentInfoVC: UITableViewController {
    //부서 정보를 저장할 데이터 타입
    typealias DepartRecord = (departCd: Int, departTitle: String, departAddr: String)
    
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
        
        self.navigationItem.title = "\(self.departInfo.departTitle)"
    }
    
    //섹션(2개 구현)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    //섹션 헤더 뷰
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //헤더에 들어갈 레이블 객체 정의
        let textHeader = UILabel(frame: CGRect(x: 35, y: 5, width: 200, height: 30))
        textHeader.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(2.5))
        textHeader.textColor = UIColor(red: 0.03, green: 0.28, blue: 0.71, alpha: 1.0)
        
        //헤더에 들어갈 이미지 뷰 객체 정의
        let icon = UIImageView()
        icon.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        
        //섹션에 따라 타이틀과 이미지 다르게 설정
        if section == 0 {
            textHeader.text = "부서 정보"
            icon.image = UIImage(imageLiteralResourceName: "depart")
        } else {
            textHeader.text = "소속 사원"
            icon.image = UIImage(imageLiteralResourceName: "employee")
        }
        
        //레이블과 이미지 뷰를 담을 컨테이너용 뷰 객체 정의
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        v.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.99, alpha: 1.0)
        
        //뷰에 레이블과 이미지 뷰 추가
        v.addSubview(textHeader)
        v.addSubview(icon)
        
        return v
    }
    //섹션 헤더 뷰 높이
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //섹션 당 cell 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return self.empList.count
        }
    }
    
    //cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cell의 section 정보는 indexPath 의 .section 으로 확인 가능
        if indexPath.section == 0 {
            //부서 정보 목록을 구성하기
            let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
            var cellconf = cell?.defaultContentConfiguration()
            //공통속성
            cellconf?.textProperties.font = UIFont.systemFont(ofSize: 13)
            cellconf?.secondaryTextProperties.font = UIFont.systemFont(ofSize: 12)
            
            switch indexPath.row {
            case 0:
                cellconf?.text = "부서 코드"
                cellconf?.secondaryText = "\(self.departInfo.departCd)"
            case 1:
                cellconf?.text = "부서명"
                cellconf?.secondaryText = self.departInfo.departTitle
            case 2:
                cellconf?.text = "부서 주소"
                cellconf?.secondaryText = self.departInfo.departAddr
            default:
                () //작성할게 없을때 쓰는 더미
            }
            
            cell?.contentConfiguration = cellconf
            
            return cell!
        } else {
            //소속 사원 목록을 구성하기
            let row = self.empList[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL")
            var cellconf = cell?.defaultContentConfiguration()
            
            cellconf?.textProperties.font = UIFont.systemFont(ofSize: 12)
            cellconf?.text = "\(row.empName) (입사일: \(row.joinDate))"
            
            //재직 상태를 나타내는 세그먼트 컨트롤
            let state = UISegmentedControl(items: ["재직중", "휴직", "퇴사"])
            state.frame.origin.x = self.view.frame.width - state.frame.width - 10
            state.frame.origin.y = 10
            //DB에 저장된 상태값으로 설정
            state.selectedSegmentIndex = row.stateCd.rawValue
            
            //엑션 메소드에서 참조할 수 잇도록 사원 코드를 저장.
            //.tag 를 이용한 것, 정수만 전달 가능.
            state.tag = row.empCd
            state.addTarget(self, action: #selector(self.changeState(_:)), for: .valueChanged)
            
            cell?.contentView.addSubview(state)
            
            cell?.contentConfiguration = cellconf
            
            return cell!
        }
    }
    @objc func changeState(_ sender: UISegmentedControl) {
        //사원 코드
        let empCd = sender.tag
        //재직 상태
        let stateCd = EmpStateType(rawValue: sender.selectedSegmentIndex)
        
        //재직 상태 업데이트
        if self.empDAO.editState(empCd: empCd, stateCd: stateCd!) {
            let alert = UIAlertController(title: nil, message: "재직 상태가 변경되었습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        }
    }
    
}
