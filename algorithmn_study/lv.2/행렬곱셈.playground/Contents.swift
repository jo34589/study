import Foundation

func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    let n = arr1.count
    let k = arr1[0].count
    let m = arr2[0].count
    var ans:[[Int]] = Array(repeating:Array(repeating:0, count:m), count: n)
    for i in 0 ..< n {
        for j in 0 ..< m {
            for x in 0 ..< k {
                ans[i][j] += arr1[i][x]*arr2[x][j]
            }
        }
    }
    return ans
}
