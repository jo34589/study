import Foundation

func solution1(_ number:String, _ k:Int) -> String {
    
    func is_a_bigger(_ a:[String], _ b:[String]) -> Bool {
        for i in 0 ..< a.count {
            if Int(a[i])! > Int(b[i])! {
                return true
            }
        }
        return false
    }
    
    var n = number.map() {String($0)}
    for _ in 0 ..< k {
        var a = n
        a.remove(at: 0)
        for x in 1 ..< n.count {
            var b = n
            b.remove(at: x)
            if !is_a_bigger(a, b) {
                a = b
            }
        }
        n = a
    }
    
    return n.joined()
}//시간초과

func solution(_ number:String, _ k:Int) -> String {
    let str = number.map() {String($0)}
    
    func check(_ st:Int, _ ed:Int, _ str:[String]) -> Int {
        var ind = st
        var max = -1
        for i in st ..< ed {
            if Int(str[i])! > max {
                max = Int(str[i])!
                ind = i
            }
        }
        return ind
    }
    
    var start = 0
    var end = k+1
    var ans = [String]()
    for _ in 0 ..< str.count-k {
        //print("\(start), \(end)")
        let ind = check(start, end, str)
        ans.append(str[ind])
        start = ind+1
        end += 1
        //print(ans)
    }
    return ans.joined()
}

print(solution("1924", 2))
print(solution("123454321", 4)) //54321
print(solution("1231234", 3))
print(solution("4177252841", 4))
