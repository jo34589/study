/*
 //1, 4 번 제외 모두 실패
 
 import Foundation
     
 func solution(_ n:Int, _ results:[[Int]]) -> Int {
     
     var rank:[Int:Int] = [:]
     var wins:[[Int]] = Array(repeating: [Int](), count: n+1)
     var loses:[[Int]] = Array(repeating: [Int](), count: n+1)
     results.forEach() {
         wins[$0[0]].append($0[1])
         loses[$0[1]].append($0[0])
     }
     
     //win 수와 lose 수의 합이 n-1 이면 순위를 알 수 있음.
     for i in 1 ... n {
         if wins[i].count + loses[i].count == n-1 {
             rank[i] = loses[i].count + 1
         }
     }
     for _ in 0 ..< n {
         for i in 1 ... n {
             guard rank[i] == nil else {
                 continue
             }
             var lower_bound = 0
             var higher_bound = n+1
             //내가 이긴 애들 중에서 랭크숫자가 가장 높은(랭크가 낮은) 애 또는 끝값(n)
             //내가 진 애들 중에서 랭크 숫자가 가장 낮은(랭크가 높은) 애 또는 처음값(1)
             for node in wins[i] {
                 if let h = rank[node] {
                     if h < higher_bound {
                         higher_bound = h
                     }
                 }
             }
             for node in loses[i] {
                 if let l = rank[node] {
                     if l > lower_bound {
                         lower_bound = l
                     }
                 }
             }
             
             if higher_bound - lower_bound == 2 {
                 rank[i] = (higher_bound+lower_bound)/2
             }
         }
     }

     //print(rank)
     
     return rank.count
 }
 
 */

//플로이드-와샬 알고리즘 이용.

import Foundation
    
func solution(_ n:Int, _ results:[[Int]]) -> Int {
    
    var graph:[[Bool]] = Array(repeating: Array(repeating: false, count: n+1), count: n+1)
    var answer = 0
    
    for r in results {
        graph[r[0]][r[1]] = true
    }
    //j에서 i를 거쳐 k로 가는 길이 있는가?
        //자기자신은 모순된 연결이 없고, false 인 점에서 불발.
    //왜 i 에서 j 를 거쳐 k 로 가는 길로 구하면 몇몇 케이스에서 틀리는가?
    
    for i in 1 ... n {
        for j in 1 ... n {
            for k in 1 ... n {
                if (graph[j][i] && graph[i][k]) {
                    graph[j][k] = true
                }
            }
        }
    }
    //이렇게 할 필요 없이 graph 내에서 숫자를 이용해 할 방법이 없을까 했는데
    //생각이 안남
    for i in 1 ... n {
        var c = 0
        for j in 1 ... n {
            if graph[i][j] || graph[j][i] {
                c += 1
            }
        }
        if c == n-1 {
            answer += 1
        }
    }
    
    return answer
}

//print(solution(5,[[4, 3], [4, 2], [3, 2], [1, 2], [2, 5]]), 2)
print(solution(5, [[1, 4], [4, 2], [2, 5], [5, 3]]))
