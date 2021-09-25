import Foundation

func solution(_ board:[[Int]]) -> Int
{
    //효율성 타임아웃.
    /*
    var answer:Int = 0
    let y = board.count
    let x = board[0].count
    
    for i in 0 ..< y {
        for j in 0 ..< x {
            let maxsize = min(x-j, y-i)
            guard maxsize > answer else {
                continue
            }
            for size in answer ... maxsize {
                var sum = 0
                for k in 0 ..< size {
                    for l in 0 ..< size {
                        sum += board[i+k][j+l]
                    }
                }
                if sum == size*size {
                    if size > answer {
                        answer = size
                    }
                }
            }
        }
    }
    return answer*answer
    */
    
    var answer:Int = 0
    let y = board.count
    let x = board[0].count
    var dp:[[Int]] = Array(repeating: Array(repeating: 0, count: x), count: y)
    for i in 0 ..< x {
        if board[0][i] == 1 {
            dp[0][i] = 1
            answer = 1
        } else {
            dp[0][i] = 0
        }
    }
    for i in 0 ..< y {
        if board[i][0] == 1 {
            dp[i][0] = 1
            answer = 1
        } else {
            dp[i][0] = 0
        }
    }
    guard y > 1 && x > 1 else {
        return answer
    }
    for i in 1 ..< y {
        for j in 1 ..< x {
            if board[i][j] == 1 {
                dp[i][j] = min(dp[i-1][j-1], min(dp[i][j-1], dp[i-1][j])) + 1
                if dp[i][j] > answer {
                    answer = dp[i][j]
                }
            } else {
                dp[i][j] = 0
            }
        }
    }
    
    return answer * answer
}

/*
[0, 1, 1, 1] [1, 1, 0, 1]
[1, 1, 1, 1] [1, 1, 1, 2]
[1, 1, 1, 1] [0, 0, 2, 3]
[1, 1, 1, 0] [1, 2, 3, 0]
*/
