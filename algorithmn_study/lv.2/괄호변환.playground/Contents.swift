import Foundation

func solution(_ p:String) -> String {
    guard p != "" else {
        return ""
    }
    
    func check (_ a:[String]) -> Bool {
        var st:[Int] = []
        for i in 0 ..< a.count {
            if a[i] == "(" {
                st.append(i)
            } else {
                if st.isEmpty {
                    return false
                }
                st.removeLast()
            }
        }
        if !st.isEmpty {
            return false
        }
        
        return true
    }
    
    let arr = p.map() {String($0)}
    var count = 0
    var mid = 0
    var rtn: String = ""
    var u: [String] = []
    var v: [String] = []
    
    if arr[0] == "(" {
        count += 1
    } else {
        count -= 1
    }
    for i in 1 ..< arr.count {
        if arr[i] == "(" {
            count += 1
        } else {
            count -= 1
        }
        
        if count == 0 {
            mid = i
            break
        }
    }
    if mid == arr.count - 1 {
        u = arr
    } else {
        u = Array(arr[0 ... mid])
        v = Array(arr[mid+1 ..< arr.count])
    }
    if check(u) {
        let tail = solution(v.joined())
        rtn = "\(u.joined())\(tail)"
    } else {
        let head = "(\(solution(v.joined())))"
        u.removeFirst()
        u.removeLast()
        var tail: [String] = []
        if u.count > 0 {
            for i in 0 ..< u.count {
                if u[i] == "(" {
                    tail.append(")")
                } else {
                    tail.append("(")
                }
            }
        }
        
        rtn = "\(head)\(tail.joined())"
    }
    
    return rtn
}

//print(solution("(()())()"))
//print(solution(")("))
//print(solution("()))((()"))
