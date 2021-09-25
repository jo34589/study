import Foundation

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    
    var visited:[Bool] = Array(repeating: false, count: n)
    var ans = 0
    
    func dfs(node: Int) {
        guard !visited[node] else {
            return
        }
        visited[node] = true
        for con in 0 ..< n {
            if computers[node][con] == 1 {
                dfs(node: con)
            }
        }
    }
    while visited.contains(false) {
        if let i = visited.firstIndex(of: false) {
            ans += 1
            dfs(node: i)
        }
    }
    
    return ans
}
print(solution(3, [[1, 1, 0], [1, 1, 1], [0, 1, 1]]), 1)

print(solution(3, [[1, 1, 0], [1, 1, 0], [0, 0, 1]]), 2)
