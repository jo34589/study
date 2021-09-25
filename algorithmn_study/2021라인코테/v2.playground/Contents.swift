import Foundation

//대소문자 검사용 정규표현식 extession
extension String {
    var isAlphabet: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
}

func solution(_ program:String, _ flag_rules:[String], _ commands:[String]) -> [Bool] {
    
    var ans = [Bool]()          //정답배열
    
    struct Flag {
        
        let name: String        //flag 이름
        let arg_type: String    //flag_rule 에 따른 argument 의 타입
        
        init(_ flag_name: String, _ arg_type: String) {
            self.name = flag_name
            self.arg_type = arg_type
        }
        
        func check_Str(_ f_type: String, _ params: String) -> Bool {
            if f_type == "STRINGS" {
                let p = params.split(separator: " ").map() {String($0)}
                for str in p {
                    if !str.isAlphabet {
                        return false
                    }
                }
            }
             else {
                if f_type == "STRING" {
                    // 알파벳 대소문자로만 이루어지지 않은 경우
                    if !params.isAlphabet {
                        //print("false at #7")
                        return false
                    }
                }
            }
            return true
        }
        
        func check_Num (_ f_type: String, _ params: String) -> Bool {
           if f_type == "NUMBERS" {
            let p = params.split(separator: " ").map() {String($0)}
            for a in p {
                guard Int(a) != nil else {
                //print("false at #6")
                    return false
                }
            }
           } else {
                if f_type == "NUMBER" {
                // number 타입이 아닌 경우
                    guard Int(params) != nil else {
                    //print("false at #6")
                        return false
                    }
                }
           }
            return true
        }
    }
    
    struct Prog {
        
        let name: String        //program 이름
        var flags = [Flag]()    //program 이 가진 flag들
        
        init(_ prog_name: String, _ rules:[String]) {
            self.name = prog_name
            for rule in rules {
                let l = rule.split(separator: " ").map() {String($0)}
                self.flags.append(Flag(l[0], l[1]))
            }
        }
        
        //해당 flag 를 검색해줌
        func hasFlag(_ name: String) -> Int {
            for i in 0 ..< flags.count {
                if flags[i].name == name {
                    return i
                }
            }
            return -1
        }
    }
    
    //프로그램을 받아 커맨드가 정확한지 테스트 할 클래스
    class Command {
        
        let p:Prog
        
        init(_ prog: Prog) {
            self.p = prog
        }
        
        func check_validity (_ line: String) -> Bool {
            let l = line.split(separator: " ").map {String($0)}
            var idx = [Int]()
            //이름이 다른 경우
            if l[0] != self.p.name {
                //print("false at #1")
                return false
            }
            //flag 만 건져 내기
            for i in 1 ..< l.count {
                if l[i].hasPrefix("-") {
                    idx.append(i)
                }
            }
            //flag 숫자가 맞는지 확인
            if idx.count != p.flags.count {
                //print("false at #2")
                return false
            }
            //flag 숫자가 맞아떨어지므로 이름과 파라미터 확인
            for i in idx {
                let flag_Idx_In_p = p.hasFlag(l[i])
                if flag_Idx_In_p == -1 {
                    //print("false at #3")
                    return false
                } else {
                    let f_type = p.flags[flag_Idx_In_p].arg_type
                    //strings 와 numbers 따로 취급.
                    if f_type == "STRINGS" || f_type == "NUMBERS" {
                        if i == l.count-1 {
                            return false
                        } else {
                            let params = l[idx[i] ..< idx[i+1]].joined(separator: " ")
                            if f_type == "STRINGS" {
                                return p.flags[flag_Idx_In_p].check_Str(f_type, params)
                            } else if f_type == "NUMBERS" {
                                return p.flags[flag_Idx_In_p].check_Num(f_type, params)
                            }
                        }
                    } else {
                        if f_type == "NULL" {
                            // null 타입인데 뒤에 파라미터가 오는 경우
                            if !idx.contains(i+1) || i != l.count-1{
                                //print("false at #4")
                                return false
                            }
                        } else {
                            if i == l.count-1 || idx.contains(i+1){
                                return false
                            }
                            let params = l[i+1]
                            if f_type == "NUMBER" {
                                return p.flags[flag_Idx_In_p].check_Num(f_type, params)
                            } else if f_type == "STRING" {
                                return p.flags[flag_Idx_In_p].check_Str(f_type, params)
                            }
                        }
                    }
                }
            }
            return true
        }
    }
    
    let p = Prog(program, flag_rules)
    let c = Command(p)
    for cmd in commands {
        ans.append(c.check_validity(cmd))
    }

    return ans
}
