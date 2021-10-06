//
//  MemoListVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/07/22.
//

import UIKit

class MemoListVC: UITableViewController {
    
    //앱 델리게이트 객체의 참조 정보를 읽어온다.
    //UIApplication 에서 delegate 를 불러와, 이 앱을 만들 때 AppDelegate.swift 에서 정의한 AppDelegate 로 타입캐스팅
    //이래야 미리 memolist에 접근 가능
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //뷰 컨트롤러가 디바이스의 스크린에 출력될때 마다 호출되는 함수.
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
    }
    
    /*
    override func viewDidLoad() {
        self.tableView.register(MemoCell.self, forCellReuseIdentifier: "memoCell")
        self.tableView.register(MemoCell.self, forCellReuseIdentifier: "memoCellWithImage")
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SWRevealViewController 라이브러리의 revealVeiwController 객체를 읽어온다.
        if let revealVC = self.revealViewController() {
            
            //바 버튼 아이템 객체를 정의한다.
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png")
            btn.target = revealVC
            btn.action = #selector(revealVC.revealToggle(_:))
            
            self.navigationItem.leftBarButtonItem = btn
            
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
    
    // MARK: - Table view

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = self.appDelegate.memoList.count
        return count
    }

    //개별 행을 어떻게 구상할지 결정하는 역할.
    //시스템이 필요한 값을 얻기 위해 호출함.
    //왜 호출이 안 되지? => 스토리보드에서 클래스를 지정안했었음
    //어떤 tableview(tableView)의 어느번째 cell(indexPath)에 들어가야 하는지 파라미터로 보내줌.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //1 memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memoList[indexPath.row]
        
        //2 이미지 속성이 비어 있을 경우 memoCell 아니면 memoCellWithImage
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        //tableView.register(MemoCell.self, forCellReuseIdentifier: cellId)
        
        //3 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다.
        //nil 을 반납하고 터짐: , for: IndexPath 를 추가하여 해결
        //'unable to dequeue a cell with identifier memoCell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'
        //이라는 에러를받음
        //viewdidload() 에 레지스터 시켰더니 에러는 나오지 않지만 저장한 셀도 뜨지 않음.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        //4 memoCell 의 내용을 구성한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        //5 Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포멧에 맞게 변형한다.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        //6 cell 객체를 반환한다.
        return cell
    }
    
    //테이블뷰의 셀을 선택했을때 호출되는 함수.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //indexpath.row 와 memoList 의 row 는 인덱스 번호가 같게 해놓았음을 이용.
        let row = self.appDelegate.memoList[indexPath.row]
        
        //MemoRead 스토리보드 identifier 를 가진 뷰 컨트롤러를 MemoReadVC로 인스턴스화.
        //실패할 경우 그냥 리턴.
        guard let vc = self.storyboard?.instantiateViewController(identifier: "MemoRead") as? MemoReadVC else {
            return
        }
        
        //MemoReadVC가 된 vc의 param에 값을 전달.
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
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
