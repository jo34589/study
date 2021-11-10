//
//  LogVC.swift
//  Chapter07-CoreData
//
//  Created by 엔나루 on 2021/11/10.
//

import UIKit
import CoreData

public enum LogType: Int16 {
    case create = 0
    case edit = 1
    case delete = 2
}

extension Int16 {
    func toLogType() -> String {
        switch self {
        case 0: return "생성"
        case 1: return "수정"
        case 2: return "삭제"
        default : return ""
        }
    }
}

class LogVC: UITableViewController {
    var board: BoardMO!//전달받은 값
    
    //원 게시글이 참조하는 로그 데이터 목록을 LogMO타입으로 가져온다.
    lazy var list: [LogMO]! = {
        return self.board.logs?.array as! [LogMO]
    }()
    
    override func viewDidLoad() {
        self.navigationItem.title = self.board.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell")!
        var cellconf = cell.defaultContentConfiguration()
        
        cellconf.text = "\(row.regdate!)에 \(row.type.toLogType()) 되었습니다."
        cellconf.textProperties.font = UIFont.systemFont(ofSize: 12)
        
        cell.contentConfiguration = cellconf
        
        return cell
    }
    
}
