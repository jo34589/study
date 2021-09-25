import Foundation

func solution(_ numbers:String) -> Int {
    
    var ans = 0
    
    var num = numbers.map {String($0)}
    num.sort(by: {$0 > $1})
    //print(num)
    let maxn = Int(num.joined())!
    let n = num.count
    
    var prime = [Bool](repeating: true, count: maxn+1)
    prime[0] = false
    prime[1] = false

    for i in 1 ... maxn/2+1 {
        if prime[i] == true {
            var x = i
            while x <= maxn {
                prime[x] = false
                x += i
            }
            prime[i] = true
        }
    }
    //number: ["7", "2", "1", "0"], depth:number.count
    func permute(_ number:[String], _ depth:Int) -> [String] {
        guard depth > 1 else {
            return number
        }

        var rtn:[String] = []
        for i in 0 ..< number.count {
            var arr = number
            let pick = arr[i]
            arr.remove(at: i)
            let rest = permute(arr, depth-1)
            rtn += rest
            for n in rest {
                rtn.append([pick, n].joined())
            }
        }
        
        return rtn
    }
    
    let check = Array(Set(permute(num, n).map {Int($0)!}))
    //print(check.sorted())
    //[0, 1, 2, 7, 10, 12, 17, 20, 21, 27, 70, 71, 72, 102, 107, 120, 127, 170, 172, 201, 207, 210, 217, 270, 271, 701, 702, 710, 712, 720, 721, 1027, 1072, 1207, 1270, 1702, 1720, 2017, 2071, 2107, 2170, 2701, 2710, 7012, 7021, 7102, 7120, 7201, 7210]
    
    for number in check {
        if prime[number] == true {
            ans += 1
        }
    }
    
    return ans
    
}

print(solution("1720"))
print("")
print(solution("224"))
