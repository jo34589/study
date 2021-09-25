import Foundation

func solution(_ brown:Int, _ yellow:Int) -> [Int] {
    
    var ans:[Int] = []
    for i in 1 ... yellow {
        if yellow%i == 0 {
            let y = i + 2
            let x = yellow/i + 2
            if 2*(x+y-2) == brown {
                ans = [x, y]
                break
            }
        }
    }
    
    return ans
}

solution(10, 2)
solution(8, 1)
solution(24, 24)
