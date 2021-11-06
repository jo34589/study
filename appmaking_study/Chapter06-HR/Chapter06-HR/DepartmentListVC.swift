//
//  DepartmentListVC.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/10/28.
//

import UIKit

class DepartmentListVC: UITableViewController {
    //데이터 소스용 멤버 변수
    var departList: [(departCd: Int, departTitle: String, departAddr: String)]!
    //SQLite 처리를 담당할 DAO 객체
    let departDAO = DepartmentDAO()
    
    func initUI() {
        //네비게이션 타이틀용 레이블 속성 설정
        let navTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
        
        //네비게이션 바 UI 설정
        self.navigationItem.titleView = navTitle
        self.navigationItem.leftBarButtonItem = self.editButtonItem //편집 버튼 추가
        
        //셀을 스와이프 했을 때 편집 모드가 되도록 설정
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewDidLoad() {
        //기존에 저장된 부서 정보를 가져온다.
        self.departList = self.departDAO.find()
        self.initUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //indexPath 매개변수가 가리키는 행에 대한 데이터를 읽어온다.
        let rowData = self.departList[indexPath.row]
        
        //셀 객체를 생성하고 데이터를 배치한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "DEPART_CELL")
        
        var cellconf = cell?.defaultContentConfiguration()
        cellconf?.text = rowData.departTitle
        cellconf?.textProperties.font = UIFont.systemFont(ofSize: 14)
        
        cellconf?.secondaryText = rowData.departAddr
        cellconf?.secondaryTextProperties.font = UIFont.systemFont(ofSize: 12)
        
        cell?.contentConfiguration = cellconf
        
        return cell!
    }
    
    //일괄 편집 모드에서 특정 줄의 셀 마다 다른 편집옵션을 제공할 때 Switch 구문으로 사용
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    //편집 모드에서 INSERT/DELETE 버튼을 클릭했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /*
         if editingStyle == .insert {
         
         } else if editingStyle == .delete {
         
         }
         */
        //삭제할 행의 departCd 를 구한다.
        let departCd = self.departList[indexPath.row].departCd
        
        //db, 데이터소스, 테이블 뷰에서 삭제한다.
        if departDAO.remove(departCd: departCd) {
            self.departList.remove(at: departCd)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        //비즈니스 로직이 들어갈 예정.
        let alert = UIAlertController(title: "신규 부서 등록",
                                      message: "신규 부서를 등록해 주세요", preferredStyle: .alert)
        
        //부서명 및 주소 입력용 텍스트 필드 추가
        alert.addTextField() {(tf) in tf.placeholder = "부서명"}
        alert.addTextField() {(tf) in tf.placeholder = "주소"}
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { (_) in
            
            let title = alert.textFields?[0].text
            let addr = alert.textFields?[1].text
            
            if self.departDAO.create(title: title!, addr: addr!) {
                //신규 부서 등록이 성공하면
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                
                //네이게이션 타이틀에도 변경된 부서 정보를 반영한다.
                let navTitle = self.navigationItem.titleView as! UILabel
                navTitle.text = "부서 목록 \n" + " 총 \(self.departList.count) 개"
            }
        })
        
        self.present(alert, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //화면 이동 시 함께 전달할 부서 코드
        let departCd = self.departList[indexPath.row].departCd
        
        //이동할 대상 뷰 컨트롤러의 인스턴스
        let infoVC = self.storyboard?.instantiateViewController(withIdentifier: "DEPART_INFO")
        if let _infoVC = infoVC as? DepartmentInfoVC {
            //부서 코드를 전달한 다음 푸시 방식으로 화면 이동
            _infoVC.departCd = departCd
            self.navigationController?.pushViewController(_infoVC, animated: true)
        }
    }
}
