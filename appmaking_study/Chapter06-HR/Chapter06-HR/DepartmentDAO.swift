//
//  DepartmentDAO.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/10/28.
//

import Foundation

class DepartmentDAO {
    //부서정보를 담을 튜플
    typealias DepartRecord = (Int, String, String)
    
    //SQLite 연결 및 초기화
    lazy var fmdb: FMDatabase! = {
        //1. 파일 매니저 객체를 생성
        let fileMgr = FileManager.default
        //2. 샌드박스 내 문서 디렉토리에서 데이터베이스 파일 경로르르 확인
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        //3. 샌드박스 경로에 파일이 없다면 메인 번들에 만들어 둔 hr.sqlite를 가져와 복사
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        //4. 준비된 데이터베이스 파일을 바탕으로 FMDatabase 객체를 생성
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    
    // MARK: - Methods: find, get, create, remove
    func find() -> [DepartRecord] {
        //반환할 데이터를 담을 [DepartRecord] 타입의 객체 정의
        var departList = [DepartRecord]()
        
        do {
            //부서 정보 목록을 가져올 SQL 작성 및 쿼리 실행
            let sql = """
                SELECT depart_cd, depart_title, depart_addr
                FROM department
                ORDER BY depart_cd ASC
            """
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            //결과 집합 추출
            while rs.next() {
                let departCd = rs.int(forColumn: "depart_cd")
                let departTitle = rs.string(forColumn: "depart_title")
                let departAddr = rs.string(forColumn: "depart_addr")
                //튜플 타입으로 추가할것
                //Int()로 감싼 이유는 rs.int 가 int32 로 반환하기 때문.
                departList.append( (Int(departCd), departTitle!, departAddr!) )
            }
        }
        catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return departList
    }
    
    func get(departCd: Int) -> DepartRecord? {
        //질의 실행
        let sql = """
            SELECT depart_cd, depart_title, depart_addr
            FROM department
            WHERE depart_cd = ?
        """
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [departCd])
        
        //결과 집합 처리
        if let _rs = rs {
            _rs.next()
            
            let departId = _rs.int(forColumn: "depart_cd")
            let departTitle  = _rs.string(forColumn: "depart_title")
            let departAddr = _rs.string(forColumn: "depart_addr")
            
            return (Int(departId), departTitle!, departAddr!)
        } else {
            //결과 집합이 없으면 nil 반환
            return nil
        }
    }
    
    func create(title: String!, addr: String!) -> Bool {
        //인자값 체크
        guard title != nil && title?.isEmpty == false else {
            return false
        }
        guard addr != nil && addr?.isEmpty == false else {
            return false
        }
        
        do {
            let sql =
"""
INSERT INTO department (depart_title, depart_addr)
VALUES (?, ?)
"""
            //fmdb 라이브러리에 해당
            //업데이트 구문이라 executeQuery 대신 executeUpdate 를 사용
            try self.fmdb.executeUpdate(sql, values: [title!, addr!])
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(departCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM department WHERE depart_cd = ?"
            try self.fmdb.executeUpdate(sql, values: [departCd])
            return true
        } catch let error as NSError {
            print("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
}
