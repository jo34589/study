//https://programmers.co.kr/learn/courses/30/lessons/42861
//Swift

//base idea
//1. 가장 작은 cost 를 가진 걸 하나 뽑아 짓는다.
//2. 연결된 섬들, 아직 연결되지 않은 섬들의 목록을 만든다.
//3. 연결된 섬들에서 이을 수 있는 다리들의 리스트를 가져온다.
//4. 이미 연결된 섬들을 제외하고 가장 작은 코스트를 가진 다리를 짓는다.
//5. 2~4를 모든 섬들이 다 이어질때 까지 반복.
//한다면? 이게 최소가 보장이 될까?

import Foundation

func solution(_ n:Int, _ costs:[[Int]]) -> Int {
    
    var ans = 0
    //연결된 섬
    var connected: [Int] = []
    //연결되지 않은 섬
    var isolated: [Int] = Array(repeating: 0, count: n)
    for i in 1 ..< n {
        isolated[i] = i
    }
    
    while connected.count < n {
        //find all bridges to build that matches the condition
        var bridges:[[Int]] = []
        if connected.isEmpty {
            bridges = costs
        } else {
            bridges = costs.filter({
                (connected.contains($0[0]) && isolated.contains($0[1]))
                ||
                (connected.contains($0[1]) && isolated.contains($0[0]))
            })
        }
        //find the least cost
        let mincost = bridges.min(by: { $0[2] < $1[2] })!
        //renew connected and isolated
        if connected.isEmpty {
            connected.append(mincost[0])
            connected.append(mincost[1])
            isolated.removeAll(where: { $0 == mincost[0] })
            isolated.removeAll(where: { $0 == mincost[1] })
        } else {
            if connected.contains(mincost[0]) {
                connected.append(mincost[1])
                isolated.removeAll(where: { $0 == mincost[1] })
            } else {
                connected.append(mincost[0])
                isolated.removeAll(where: { $0 == mincost[0] })
            }
        }
        //add cost to ans
        ans += mincost[2]
        /*
        print("bridge: \(bridges)")
        print("selected: \(mincost)")
        print("isolated: \(isolated)")
        print("connected: \(connected)")
        print("cost: \(ans)")
        */
    }
    
    return ans
}

solution(5, [[0, 1, 5], [1, 2, 3], [2, 3, 3], [3, 1, 2], [3, 0, 4], [2, 4, 6], [4, 0, 7]]) //15
solution(5, [[0, 1, 1], [3, 4, 1], [1, 2, 2], [2, 3, 4]]) //8
solution(4, [[0, 1, 5], [1, 2, 3], [2, 3, 3], [1, 3, 2], [0, 3, 4]]) //9
solution(5, [[0, 1, 1], [3, 1, 1], [0, 2, 2], [0, 3, 2], [0, 4, 100]]) //104
solution(6, [[0, 1, 5], [0, 3, 2], [0, 4, 3], [1, 4, 1], [3, 4, 10], [1, 2, 2], [2, 5, 3], [4, 5, 4]]) //11
solution(5, [[0, 1, 1], [2, 3, 1], [3, 4, 2], [1, 2, 2], [0, 4, 100]]) //6
solution(5, [[0, 1, 1], [0, 4, 5], [2, 4, 1], [2, 3, 1], [3, 4, 1]]) //8
solution(5, [[0, 1, 1], [0, 2, 2], [0, 3, 3], [0, 4, 4], [1, 3, 1]]) //8
