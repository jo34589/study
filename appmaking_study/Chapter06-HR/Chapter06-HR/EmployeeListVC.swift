//
//  EmployeeListVC.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/10/28.
//

import UIKit

class EmployeeListVC: UITableViewController {
    //데이터 소스를 저장할 멤버 변수
    var empList: [EmployeeVO]!
    //sqlite 처리를 담당할 DAO 클래스
    var empDAO = EmployeeDAO()
    
    //새로고침 컨트롤레 들어갈 이미지 뷰
    var loadingImg: UIImageView!
    //충분히 당겼을때 더 안 당겨도 된다고 표시하기 위한 큰 원
    var bgCircle: UIView!
    
    //UI 초기화 함수
    func initUI() {
        //네비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "사원 목록 \n" + " 총 \(self.empList.count) 명"
        
        self.navigationItem.titleView = navTitle
    }
    
    override func viewDidLoad() {
        //순서가 바뀌면 안됨.
        self.empList = self.empDAO.find()
        initUI()
        
        self.loadingImg = UIImageView(image: UIImage(named: "refresh"))
        self.loadingImg.center.x = (self.refreshControl?.frame.width)!/2
        
        //당겨서 새로고침 기능
        self.refreshControl = UIRefreshControl()
        //self.refreshControl?.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        self.refreshControl?.tintColor = .clear
        self.refreshControl?.addSubview(self.loadingImg)
        self.refreshControl?.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
        
        self.bgCircle = UIView()
        self.bgCircle.backgroundColor = UIColor.yellow
        self.bgCircle.center.x = (self.refreshControl?.frame.width)!/2
        
        self.refreshControl?.addSubview(self.bgCircle)
        self.refreshControl?.bringSubviewToFront(self.loadingImg)
    }
    
    @objc func pullToRefresh(_ sender: Any) {
        //새로고침 시 갱신되어야 할 내용들
        self.empList = self.empDAO.find()
        self.tableView.reloadData()
        
        //원이 이미지를 중심으로 커지는 애니메이션
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        UIView.animate(withDuration: 0.5) {
            self.bgCircle.frame.size.width = 80
            self.bgCircle.frame.size.height = 80
            self.bgCircle.center.x = (self.refreshControl?.frame.width)!/2
            self.bgCircle.center.y = distance/2
            self.bgCircle.layer.cornerRadius = (self.bgCircle?.frame.size.width)!/2
        }
        
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.empList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = self.empList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EMP_CELL")
        
        //사원명 + 재직 상태 출력
        var cellconf = cell?.defaultContentConfiguration()
        
        cellconf?.text = rowData.empName + "(\(rowData.stateCd.desc()))"
        cellconf?.textProperties.font = UIFont.systemFont(ofSize: 14)
        
        cellconf?.secondaryText = rowData.departTitle
        cellconf?.secondaryTextProperties.font = UIFont.systemFont(ofSize: 12)
        
        cell?.contentConfiguration = cellconf
        
        return cell!
    }
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "사원 등록", message: "등록할 사원 정보를 입력해 주세요", preferredStyle: .alert)
        
        alert.addTextField() { (tf) in
            tf.placeholder = "사원명"
        }
        
        //contentViewController 영역에 부서 선택 피커 뷰 삽입
        let pickervc = DepartPickerVC()
        alert.setValue(pickervc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default) {
            (_) in
            //사원 등록 처리 로직이 들어갈 영역
            //알림창의 입력 필드에서 값을 읽어온다.
            var param = EmployeeVO()
            param.departCd = pickervc.selectedDepartCd
            param.empName = (alert.textFields?[0].text)!
            
            //가입일은 오늘로
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            param.joinDate = df.string(from: Date())
            
            //재직 상태는 재직중
            param.stateCd = EmpStateType.ING
            
            //db 처리
            if self.empDAO.create(param: param) {
                //결과가 성공이면 데이터를 다시 읽어들여 테이블 뷰를 갱신
                self.empList = self.empDAO.find()
                self.tableView.reloadData()
                
                //그리고 네비게이션 타이틀도 갱신
                if let navTitle = self.navigationItem.titleView as? UILabel {
                    navTitle.text = "사원 목록 \n" + " 총 \(self.empList.count) 명"
                }
            }
        })
        
        self.present(alert, animated: false)
    }
    
    @IBAction func editing(_ sender: Any) {
        if self.isEditing == false {
            self.setEditing(true, animated: true)
            (sender as? UIBarButtonItem)?.title = "Done"
        } else {
            self.setEditing(false, animated: true)
            (sender as? UIBarButtonItem)?.title = "Edit"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //삭제할 행의 empCd를 구함
        let empCd = self.empList[indexPath.row].empCd
        
        //db, 데이터 소스, 테이블 뷰에서 삭제
        if empDAO.remove(empCd: empCd) {
            self.empList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //스크롤이 발생할 때마다 처리할 내용
        let distance = max(0.0, -(self.refreshControl?.frame.origin.y)!)
        
        //y 좌표를 당긴 거리만큼 수정
        self.loadingImg.center.y = distance/2
        //당긴 거리만큼 로딩 이미지가 회전하도록 해줌
        let ts = CGAffineTransform(rotationAngle: CGFloat(distance/20))
        self.loadingImg.transform = ts
        
        //배경 뷰의 중심 좌표 설정
        self.bgCircle.center.y = distance / 2
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //스크롤 뷰의 드래그가 끝났을 때 호출되는 메소드
        //원 초기화.
        self.bgCircle.frame.size.width = 0
        self.bgCircle.frame.size.height = 0
    }
}
