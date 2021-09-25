import Foundation

func solution(_ rows:Int, _ columns:Int, _ queries:[[Int]]) -> [Int] {
    var board:[[Int]] = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    var ans:[Int] = []
    for i in 0 ..< rows {
        for j in 0 ..< columns {
            board[i][j] = (i*columns)+j+1
        }
    }
    
    for q in queries {
        var lowest = rows*columns
        var temp1 = board[q[0]-1][q[1]-1]
        
        for i in q[1] ..< q[3] {
            if temp1 < lowest {
                lowest = temp1
            }
            let temp2 = board[q[0]-1][i]
            board[q[0]-1][i] = temp1
            temp1 = temp2
        }
        
        for i in q[0] ..< q[2] {
            if temp1 < lowest {
                lowest = temp1
            }
            let temp2 = board[i][q[3]-1]
            board[i][q[3]-1] = temp1
            temp1 = temp2
        }

        for j in 0 ..< q[3] - q[1] {
            if temp1 < lowest {
                lowest = temp1
            }
            let i = q[3] - j - 2
            let temp2 = board[q[2]-1][i]
            board[q[2]-1][i] = temp1
            temp1 = temp2
        }
        
        for j in 0 ..< q[2] - q[0] {
            if temp1 < lowest {
                lowest = temp1
            }
            let i = q[2] - j - 2
            let temp2 = board[i][q[1]-1]
            board[i][q[1]-1] = temp1
            temp1 = temp2
        }
        //print(board)
        if temp1 < lowest {
                lowest = temp1
        }
        
        ans.append(lowest)
    }
    
    return ans
}
