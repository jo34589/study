import Foundation

func solution(_ numbers:[Int]) -> String {
    let str = numbers.map {String($0)}
    var arr:[[String]] = [[]]
    var ans:[String] = []
    for num in str {
        arr.append(num.map{String($0)})
    }
    arr.removeFirst()
    //print(arr)
    arr.sort(by: {
        let a = ($0 + $1).joined()
        let b = ($1 + $0).joined()
        if a > b {
            return true
        } else {
            return false
        }
    })
    
    //print(arr)
    for i in 0 ..< arr.count {
        ans.append(arr[i].joined())
    }
    //exception: testcase 11 : [0, 0, 0, 0 ... ]
    //ans : already sorted
    if ans.first == "0" {
        return "0"
    }
    
    return ans.joined()
}

solution([3, 30, 34, 5, 9, 92]) // 9 92 5 34 3 30
solution([3, 30, 34, 344, 320, 326])
solution([322, 32]) // 32 322
solution([0, 0, 0, 0])
