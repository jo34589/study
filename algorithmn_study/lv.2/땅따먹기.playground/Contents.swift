import Foundation

func solution(_ land:[[Int]]) -> Int{
    
    let n = land.count //n <= 100,000
    var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: 4), count: n)
    dp[0] = land[0]
    for i in 1 ..< n {
        for j in 0 ..< 4 {
            dp[i][j] = land[i][j] + max(dp[i-1][(j+1)%4], max(dp[i-1][(j+2)%4], dp[i-1][(j+3)%4]))
        }
    }
    
    return dp[n-1].max()!
}
