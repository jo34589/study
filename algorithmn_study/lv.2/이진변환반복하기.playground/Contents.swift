import Foundation

func solution(_ s:String) -> [Int] {
    let arr = s.map({String($0)})
    func recurv(_ arr:[String], depth: Int) -> ([String], Int) {
        guard arr != ["1"] else {
            return (arr, depth)
        }
        var n = arr.filter({$0 != "0"}).count
        var str:[String] = []
        while n > 0 {
            str.append(String(n%2))
            n/=2
        }
        str.reverse()
        return recurv(str, depth: depth+1)
    }
    
    
    return []
}
