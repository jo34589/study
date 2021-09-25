//https://programmers.co.kr/learn/courses/30/lessons/72413
//Swift

/*
 n개 노드
 s에서 출발
 a,b의 도착점
 합계 요금 최소화
 weighted bidirectional graph
 노드 번호는 1부터 시작.
 
 생각난 솔루션 1.
 각 노드에서 다른 노드로 갈 수 있는 최소 비용을 모두 계산해서 저장 갈 수 없으면 -1
 > 모든 노드에서 다른 노드로 가는 최소 비용: 플로이드 와샬
 s 에서 갈 수 있는 노드들에서 a 와 b 가 각자 떨어져 갔을 때의 합계비용 계산
 최소를 도출
 */

import Foundation

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    let no_path = 60000001
    let s = s-1
    let a = a-1
    let b = b-1
    var cost_list: [[Int]] = Array(repeating: Array(repeating: no_path, count: n), count: n)
    for i in 0 ..< n {
        cost_list[i][i] = 0
    }
    fares.forEach({
        cost_list[$0[0]-1][$0[1]-1] = $0[2]
        cost_list[$0[1]-1][$0[0]-1] = $0[2]
    })
    
    //플로이드-와샬: 모든 노드에서 모든 노드로 최단거리
    for k in 0 ..< n {
        for i in 0 ..< n {
            for j in 0 ..< n {
                cost_list[i][j] = min(cost_list[i][j], cost_list[i][k] + cost_list[k][j])
            }
        }
    }
    
    //for i in 0 ..< n {
    //    print(cost_list[i])
    //}
    
    var min_cost = no_path
    for i in 0 ..< n {
        var cost_sum = 0
        cost_sum += cost_list[s][i]
        cost_sum += cost_list[i][a]
        cost_sum += cost_list[i][b]
        if cost_sum < min_cost {
            min_cost = cost_sum
        }
    }
    
    return min_cost
}


//solution(6,4,6,2,[[4, 1, 10], [3, 5, 24], [5, 6, 2], [3, 1, 41], [5, 1, 24], [4, 6, 50], [2, 4, 66], [2, 3, 22], [1, 6, 25]])
//solution(7,3,4,1,[[5, 7, 9], [4, 6, 4], [3, 6, 1], [3, 2, 3], [2, 1, 6]])
//solution(6,4,5,6,[[2,6,6], [6,3,7], [4,6,7], [6,5,11], [2,5,12], [5,3,20], [2,4,8], [4,3,9]])
