import Foundation

func solution(_ s:String) -> Int {
    let str = s.map() {String($0)}
    var ans = str.count+1
    
    if str.count == 1 {
        return 1
    }
    
    for d in 1 ... str.count/2 {
        var arr = [String]()
        var minimum = 0
        var x = 0
        for i in 0 ..< str.count/d {
            arr.append(str[i*d ..< (i+1)*d].joined())
            x = (i+1)*d
        }
        if x < str.count {
            arr.append(str[x ..< str.count].joined())
        }
        print(arr , terminator: " ")
        
        var count = 1
        for i in 0 ..< arr.count-1 {
            if arr[i] == arr[i+1] {
                count += 1
            } else {
                minimum += arr[i].count
                if count > 1 {
                    minimum += String(count).map() {String($0)}.count
                }
                count = 1
            }
            if i == arr.count-2 {
                if arr[i] == arr[i+1] {
                    minimum += arr[i+1].count + String(count).map() {String($0)}.count
                } else {
                    minimum += arr[i+1].count
                }
            }
        }
        print(minimum)
        if ans > minimum {
            ans = minimum
        }
    }
    
    return ans
}

solution("zxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxz")
