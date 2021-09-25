import Foundation

func solution(_ arr:[[Int]]) -> [Int] {
    
    var count = [0, 0]
    func recur(x:Int, y:Int, n:Int) {
        var sum = 0
        for i in 0 ..< n {
            for j in 0 ..< n {
                sum += arr[x+i][y+j]
            }
        }
        if sum == 0 {
            count[0] += 1
        } else if sum == n*n {
            count[1] += 1
        } else {
            recur(x:x, y:y, n:n/2)
            recur(x:x+n/2, y:y, n:n/2)
            recur(x:x, y:y+n/2, n:n/2)
            recur(x:x+n/2, y:y+n/2, n:n/2)
        }
    }
    let n = arr.count
    recur(x: 0, y: 0, n: n)
    return count
}

//solution([[1,1,0,0],[1,0,0,0],[1,0,0,1],[1,1,1,1]])
/*solution([[1,1,1,1,1,1,1,1],
          [0,1,1,1,1,1,1,1],
          [0,0,0,0,1,1,1,1],
          [0,1,0,0,1,1,1,1],
          [0,0,0,0,0,0,1,1],
          [0,0,0,0,0,0,0,1],
          [0,0,0,0,1,0,0,1],
          [0,0,0,0,1,1,1,1]])
*/
