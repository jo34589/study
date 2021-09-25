import Foundation

func solution(_ n:Int, _ k:Int) -> Int {
    
    func prime_check(n: Int) -> Bool {
        guard n > 1 else {
            return false
        }
        guard n != 2 && n != 3 else {
            return true
        }
        var i = 2
        while i * i <= n {
            if n % i != 0 {
                return false
            }
            i += 1
        }
        return true
    }
    
    var count = 0
    var base_k:[String] = []
    
    var n = n
    while n > 0 {
        base_k.append(String(n%k))
        n /= k
    }
    base_k.reverse()
    
    let str = base_k.joined()
    let nums = str.split(separator: "0").map({String($0)})
    nums.forEach({
        if prime_check(n: Int($0)!) {
            count += 1
        }
    })
    
    return count
}
