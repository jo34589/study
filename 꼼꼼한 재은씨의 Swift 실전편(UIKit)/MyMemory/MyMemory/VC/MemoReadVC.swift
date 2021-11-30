//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/07/22.
//

import UIKit

class MemoReadVC: UIViewController {
    
    //MemoListVC.swift 에서 tableView(_ , didSelectRowAt indexPath: IndexPath)
    //함수를 통해 param에 값을 전달함.
    var param: MemoData?
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        
        //값을 집어넣음
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        //날짜를 작성
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        //날짜를 제목에 표시
        self.navigationItem.title = dateString
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
