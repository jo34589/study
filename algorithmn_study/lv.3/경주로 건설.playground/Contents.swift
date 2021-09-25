//https://programmers.co.kr/learn/courses/30/lessons/67259
//Swift

//bfs 를 이용한 완전탐색 문제...?
//라곤해도 잘 상상이 안 간단 말이지.
//잠깐, 이거 dfs가 더 적절하지 않나?
//아냐 둘다 아니다 이거 dp가 더 맞는거같다.
//그런데 이 방식으로 하려면 메모라이즈 할 때 어떤 방향으로 들어왔는지도 저장해야 하지 않아?
//결론: 안해도 괜찮을것같다.
//자기가 최소이면 갱신하고 지나가고
//아니라면 갱신없이 리턴당할 것.

import Foundation

func solution(_ board:[[Int]]) -> Int {
    
    let n = board.count
    let right = 0
    let left = 1
    let up = 2
    let down = 3
    
    var cost:[[Int]] = Array(repeating: Array(repeating: 30260000, count: n), count: n)
    cost[0][0] = 0
    
    func get_dir(from:(Int, Int), at:(Int, Int)) -> Int {
        if at.0 - from.0 == 0 && at.1 - from.1 == 1 {
            return up
        } else if at.0 - from.0 == 1 && at.1 - from.1 == 0 {
            return right
        } else if at.0 - from.0 == 0 && at.1 - from.1 == -1 {
            return down
        } else if at.0 - from.0 == -1 && at.1 - from.1 == 0 {
            return left
        } else {
            return 0
        }
    }
    
    func dp(prev:(Int, Int), to:(Int, Int), prev_dir: Int? = nil) {
        //prev는 계산되어 있을 것.
        let dir = get_dir(from: prev, at: to)
        let prev_c = cost[prev.0][prev.1]
        
        //현재 코스트 계산
        if prev_dir != nil {
            if prev_dir == dir {
                let c = prev_c + 100
                if c > cost[to.0][to.1] {
                    return
                } else {
                    cost[to.0][to.1] = c
                }
            } else {
                let c = prev_c + 600
                if c > cost[to.0][to.1] {
                    return
                } else {
                    cost[to.0][to.1] = c
                }
            }
        } else {
            let c = prev_c + 100
            if c > cost[to.0][to.1] {
                return
            } else {
                cost[to.0][to.1] = c
            }
        }
        
        //뻗어나갈 수 있는 곳들 계산
        var cand:[(Int,Int)] = []
        if to.0 == 0 {
            if to.1 == 0 {
                cand = [(to.0+1, to.1), (to.0, to.1+1)]
            } else if to.1 == n-1 {
                cand = [(to.0+1, to.1), (to.0, to.1-1)]
            } else {
                cand = [(to.0, to.1-1), (to.0+1, to.1), (to.0, to.1+1)]
            }
        } else if to.0 == n-1 {
            if to.1 == 0 {
                cand = [(to.0-1, to.1), (to.0, to.1+1)]
            } else if to.1 == n-1 {
                cand = []
            } else {
                cand = [(to.0, to.1-1), (to.0-1, to.1), (to.0, to.1+1)]
            }
        } else {
            if to.1 == 0 {
                cand = [(to.0+1, to.1), (to.0, to.1+1), (to.0-1, to.1)]
            } else if to.1 == n-1 {
                cand = [(to.0+1, to.1), (to.0-1, to.1), (to.0, to.1-1)]
            } else {
                cand = [(to.0+1, to.1), (to.0-1, to.1), (to.0, to.1+1), (to.0, to.1-1)]
            }
        }
        cand.removeAll(where: {$0 == prev})
        cand.removeAll(where: {board[$0.0][$0.1] == 1})
        
        for pos in cand {
            dp(prev: to, to: pos, prev_dir: dir)
        }
    }
    
    if board[0][1] != 1 {
        dp(prev: (0, 0), to: (0, 1))
        for i in 0 ..< n {
            print(cost[i])
        }
    }
    print()
    if board[1][0] != 1 {
        dp(prev: (0, 0), to: (1, 0))
        for i in 0 ..< n {
            print(cost[i])
        }
    }

    return cost[n-1][n-1]
}

//solution([[0,0,0],[0,0,0],[0,0,0]])//900
//solution([[0,0,0,0,0,0,0,1],[0,0,0,0,0,0,0,0],[0,0,0,0,0,1,0,0],[0,0,0,0,1,0,0,0],[0,0,0,1,0,0,0,1],[0,0,1,0,0,0,1,0],[0,1,0,0,0,1,0,0],[1,0,0,0,0,0,0,0]])//3800
//solution([[0,0,1,0],[0,0,0,0],[0,1,0,1],[1,0,0,0]])//2100
//solution([[0,0,0,0,0,0],[0,1,1,1,1,0],[0,0,1,0,0,0],[1,0,0,1,0,1],[0,1,0,0,0,1],[0,0,0,0,0,0]])//3200
//solution([
//    [0, 0, 0, 0, 0],
//    [0, 1, 1, 1, 0],
//    [0, 0, 1, 0, 0],
//    [1, 0, 0, 0, 1],
//    [0, 1, 1, 0, 0]
//    ]) //3000


//자 이 케이스를 잘 처리하려면 dp를 이용하되 매우 잘 써야 함.

solution([[0,0,0,0,0,0,0,0],
         [1,0,1,1,1,1,1,0],
         [1,0,0,1,0,0,0,0],
         [1,1,0,0,0,1,1,1],
         [1,1,1,1,0,0,0,0],
         [1,1,1,1,1,1,1,0],
         [1,1,1,1,1,1,1,0],
         [1,1,1,1,1,1,1,0]])
