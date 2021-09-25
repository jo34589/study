import Foundation

func solution(_ s:String) -> Bool
{
    var ans:Bool = false
    var count = 0
    
    for i in s.indices {
        if s[i] == "(" {
            count += 1
        }
        else {
            if count == 0 {
                return ans
            }
            count -= 1
        }
    }
    if count == 0 {
        ans = true
    }
    
    return ans
}
