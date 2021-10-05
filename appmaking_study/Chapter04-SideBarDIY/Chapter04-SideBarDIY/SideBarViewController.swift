//
//  SideBarViewController.swift
//  Chapter04-SideBarDIY
//
//  Created by 엔나루 on 2021/10/04.

import UIKit

class SideBarViewController: UITableViewController {
    
    let titles = [
    "메뉴 01",
    "메뉴 02",
    "메뉴 03",
    "메뉴 04",
    "메뉴 05"
    ]
    
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 계정 정보를 표시할 레이블 객체를 정의한다.
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        
        accountLabel.text = "jo34589@naver.com"
        accountLabel.textColor = .white
        accountLabel.font = UIFont.systemFont(ofSize: 15)
        
        // 테이블 뷰 상단에 표시될 뷰를 정의한다.
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        
        self.tableView.tableHeaderView = v
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //줄 개수
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //재사용 큐로부터 테이블 셀을 꺼낸다.
        //재사용 큐에 menucell키로 등록된 테이블 뷰 셀이 없다면 새로 추가한다.
        let id = "menucell" //재사용큐에 등록할 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        //재사용큐를 사용하지 않는다면
            //화면에서 한번에 표현할수 있는 셀보다 표현해야 할 셀이더 많다면 재사용 큐를 사용해야 함.
            //그렇지 않으면 스크롤할때마다 끊기는 앱이 나옴.
        //매번 셀을 새로 생성한다.
        // let cell = UITableViewCell()
        
        //타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        //폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
}
