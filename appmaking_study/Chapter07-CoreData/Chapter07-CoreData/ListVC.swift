//
//  ListVC.swift
//  Chapter07-CoreData
//
//  Created by 엔나루 on 2021/11/08.
//

import UIKit
import CoreData

class ListVC: UITableViewController {
    
    //데이터 소스 역할을 할 배열 변수
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    //데이터를 읽어올 메소드
    func fetch() -> [NSManagedObject] {
        //1. 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //2. 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        //3. 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        //3-1. 정렬 속성 설정
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        //4. 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    //데이터를 저장할 메소드
    func save(title: String, contents: String) -> Bool {
        //앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        //관리 객체 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        //또는 다음 두 줄의 코드
        //let entity = NSEntityDescription.entity(forEntityName: "Board", in: context)
        //let object = NSManagedObject(entity: "Board", insertInto: context)
        
        //관리 객체 값을 설정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        //영구 저장소에 커밋되고 나면 list 프로퍼티에 추가
        do {
            try context.save()
            self.list.insert(object, at: 0)
            return true
        } catch {
            //마지막 동기화 시점 이후의 모든 변경 내역을 원래대로 되돌리는 역할
            context.rollback()
            return false
        }
    }
    
    func delete(object: NSManagedObject) -> Bool {
        //앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        //컴텍스트로부터 해당 객체 삭제
        context.delete(object)
        
        //영구 저장소에 커밋한다.
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    //데이터 저장 버튼에 대한 액션 메소드
    @objc func add(_ sender: Any) {
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        
        //입력 필드 추가
        alert.addTextField() {$0.placeholder = "제목"}
        alert.addTextField() {$0.placeholder = "내용"}
        
        //버튼 추가
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default) {
            (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            
            if self.save(title: title, contents: contents) == true {
                self.tableView.reloadData()
            }
        })
        self.present(alert, animated: false)
        
    }
    
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool {
        //앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        //관리 객체의 값을 수정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        //영구 저장소에 반영
        do {
            try context.save()
            self.list = self.fetch()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    //화면 및 로직 초기화 메소드
    override func viewDidLoad() {
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    //테이블 뷰 데이터 소스용 프로토콜 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //해당되는 데이터 가져오기
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        //셀을 생성하고 값을 대입한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        var cellconf = cell.defaultContentConfiguration()
        cellconf.text = title
        cellconf.secondaryText = contents
        cell.contentConfiguration = cellconf
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row]//삭제할 대상 객체
        
        if self.delete(object: object) {
            //코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //셀 선택하면 창이 뜨도록
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택된 행에 해당하는 데이터 가져오기
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        
        //입력 필드 추가
        alert.addTextField() {$0.text = title}
        alert.addTextField() {$0.text = contents}
        
        //버튼 추가
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default) {
            (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            //값을 수정하는 메소드를 부르고 성공하면 테이블을 reload
            if self.edit(object: object, title: title, contents: contents) == true {
                //self.tableView.reloadData()
                let cell = self.tableView.cellForRow(at: indexPath)
                var cellconf = cell?.defaultContentConfiguration()
                //셀의 내용을 직접 수정
                cellconf?.text = title
                cellconf?.secondaryText = contents
                cell?.contentConfiguration = cellconf
                //순서를 변경해줌
                let firstIndexpath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexpath)
            }
        })
        self.present(alert, animated: false)
    }
}
