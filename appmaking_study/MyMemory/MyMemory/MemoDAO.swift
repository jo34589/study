//
//  MemoDAO.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/11/11.
//

import UIKit
import CoreData

class MemoDAO {
    //관리 객체 컨텍스트
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    //저장된 데이터 전체를 가져오기.
    func fetch(keyword text: String? = nil) -> [MemoData] {
        var memolist = [MemoData]()
        //요청 객체 생성
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        //최신 글 순으로 정렬하도록 정렬 객체 생성
        let regdataDesc = NSSortDescriptor(key: "regdate", ascending: false)
        
        //추가
        //검색 키워드가 있을 경우 검색 조건 추가
        //format 에 관해서는
        //https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html#//apple_ref/doc/uid/TP40001795-CJBDBHCB
        //참고
        if let t = text, t.isEmpty == false {
            fetchRequest.predicate = NSPredicate(format: "contents CONTAINS[c] %@", t)
        }
        
        fetchRequest.sortDescriptors = [regdataDesc]
        
        do {
            let resultset = try self.context.fetch(fetchRequest)
            //읽어온 결과 집합을 순회하면서 [MemoData]타입으로 변환
            for record in resultset {
                //MemoData 객체를 생서한다.
                let data = MemoData()
                
                //MemoMO 프로퍼티 값을 MemoData의 프로퍼티로 복사한다.
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate! as Date
                data.objectID = record.objectID
                
                //이미지가 있을 때만 복사
                //이미지를 직접 데이터베이스에 저장하는건 상당히 무거운 작업이라
                //실무에서는 이미지를 문서 디렉토리에 파일로 저장하고
                //파일의 주소만 데이터베이스에 저장하는 방식으로 로직을 구현하는 경우가 있음
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                //MemoData 객체를 memolist 배열에 추가
                memolist.append(data)
            }
        } catch let error as NSError {
            NSLog("An error has occured: %s", error.localizedDescription)
        }
        return memolist
    }
    
    //새 메모를 저장하는데 쓸 메소드
    func insert(_ data: MemoData) {
        //관리 객체 인스턴스 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as! MemoMO
        
        //MemoData로부터 값을 복사한다.
        object.title = data.title
        object.contents = data.contents
        object.regdate = data.regdate!
        
        if let image = data.image {
            object.image = image.pngData()!
        }
        
        //영구 저장소에 변경 사항을 반영한다.
        do {
            try self.context.save()
        } catch let error as NSError {
            NSLog("An error has occured: %s", error.localizedDescription)
        }
    }
    
    
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        //삭제할 객체를 찾아, 컨텍스트에서 삭제한다.
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        
        do {
            //삭제된 내역을 영구저장소에 반영한다.
            try self.context.save()
            return true
        } catch let error as NSError {
            NSLog("An error has occured: %s", error.localizedDescription)
            return false
        }
    }
}
