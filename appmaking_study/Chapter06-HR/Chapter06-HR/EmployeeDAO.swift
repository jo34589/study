//
//  EmployeeDAO.swift
//  Chapter06-HR
//
//  Created by 엔나루 on 2021/11/01.
//

import Foundation

//"재직중" 이라는 문자열 대신에 EmpStateType.ING 를 사용하도록.
enum EmpStateType: Int {
    case ING = 0, STOP, OUT //순서대로 재직0, 휴직1, 퇴사2
    
    //재직 상태를 문자열로 반환해주는 메소드.
    //description.
    func desc() -> String {
        switch self {
        case .ING:
            return "재직중"
        case .STOP:
            return "휴직"
        case .OUT:
            return "퇴사"
        }
    }
    //Int가 필요하면
    //let stateCd = EmpStateType.ING
    //stateCd.rawValue 로 불러올 수 있다.
}

struct EmployeeVO {
    var empCd = 0
    var empName = ""
    var joinDate = ""
    var stateCd = EmpStateType.ING
    var departCd = 0
    var departTitle = ""
}

class EmployeeDAO {
    //FMDatabase 객체 생성 및 초기화
    lazy var fmdb: FMDatabase! = {
        //파일 매니저 객체를 생성한다.
        let fileMgr = FileManager.default
        
        //샌드박스 내 문서 디렉토리 경로에서 데이터베이스 파일을 읽어온다.
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("hr.sqlite").path
        
        //없다면 메인번들에서 복사해온다.
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "hr", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
        }
        
        let db = FMDatabase(path: dbPath)
        return db
    }()
    
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    
    func find(departCd: Int = 0) -> [EmployeeVO] {
        //반환할 데이터를 담을 EmployeeVO 타입의 객체 정의
        var employeeList = [EmployeeVO]()
        
        do {
            let condition = departCd == 0 ? "" : "WHERE Employee.depart_cd = \(departCd)"
            
            let sql = """
SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
FROM employee JOIN department ON department.depart_cd = employee.depart_cd
\(condition)
ORDER BY employee.depart_cd ASC
"""
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)
            
            while rs.next() {
                var record = EmployeeVO()
                
                record.empCd = Int(rs.int(forColumn: "emp_cd"))
                record.empName = rs.string(forColumn: "emp_name")!
                record.joinDate = rs.string(forColumn: "join_date")!
                record.departTitle = rs.string(forColumn: "depart_title")!
                
                let cd = Int(rs.int(forColumn: "state_cd"))
                record.stateCd = EmpStateType(rawValue: cd)!
                
                employeeList.append(record)
            }
        } catch let error as NSError {
            print("failed: \(error.localizedDescription)")
        }
        return employeeList
    }
    
    func get(empCd: Int) -> EmployeeVO? {
        let sql = """
SELECT emp_cd, emp_name, join_date, state_cd, department.depart_title
FROM employee JOIN department ON department.depart_cd = employee.depart_cd
WHERE emp_cd = ?
"""
        
        let rs = self.fmdb.executeQuery(sql, withArgumentsIn: [empCd])
        
        if let _rs = rs {
            _rs.next()
            
            var record = EmployeeVO()
            
            record.empCd = Int(_rs.int(forColumn: "emp_cd"))
            record.empName = _rs.string(forColumn: "emp_name")!
            record.joinDate = _rs.string(forColumn: "join_date")!
            record.departTitle = _rs.string(forColumn: "depart_title")!
            
            let cd = Int(_rs.int(forColumn: "state_cd"))
            record.stateCd = EmpStateType(rawValue: cd)!
            
            return record
        } else {
            return nil
        }
    }
    
    func create(param: EmployeeVO) -> Bool {
        
        //
        do {
            let sql = """
INSERT INTO employee (emp_name, join_date, state_cd, depart_cd)
VALUES (?, ?, ?, ?)
"""
            
            //prepared Statement 를 위한 인자값.
            var params = [Any]()
            params.append(param.empName)
            params.append(param.joinDate)
            params.append(param.stateCd.rawValue)
            params.append(param.departCd)
            
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("Insert Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func remove(empCd: Int) -> Bool {
        do {
            let sql = "DELETE FROM employee WHERE depart_cd = ?"
            try self.fmdb.executeUpdate(sql, values: [empCd])
            return true
        } catch let error as NSError {
            print("DELETE Error : \(error.localizedDescription)")
            return false
        }
    }
    
    func editState(empCd: Int, stateCd: EmpStateType) -> Bool {
        do {
            let sql = "UPDATE Employee SET state_cd = ? WHERE emp_cd = ?"
            var params = [Any]()
            
            params.append(stateCd.rawValue)
            params.append(empCd)
            
            //업데이트 실행
            try self.fmdb.executeUpdate(sql, values: params)
            return true
        } catch let error as NSError {
            print("Update Error: \(error.localizedDescription)")
            return false
        }
    }
}
