import Foundation

func solution(_ n:Int, _ info:[Int]) -> [Int] {
    
    var least = info
    for i in 0 ..< 11 {
        least[i] += 1
    }
    
    let point = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    
    var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: 12), count: n+1)
    
    for i in 1 ... n {
        for j in 1 ... 11 {
            if i >= least[j-1] {
                dp[i][j] = max(dp[i][j-1], dp[i-least[j-1]][j-1] + point[j-1])
            } else {
                dp[i][j] = dp[i][j-1]
            }
        }
    }
    
    for i in 1 ... n {
        print(dp[i])
    }
    
    return []
}

solution(5,[2,1,1,1,0,0,0,0,0,0,0])
