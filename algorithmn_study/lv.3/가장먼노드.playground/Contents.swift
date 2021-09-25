import Foundation

var distances = [Int:Int]()
var visited = [Bool]()
var edges = [[Int]]()

func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    
    visited = Array(repeating: false, count: n+1)
    edges = Array(repeating:[], count: n+1)
    edge.forEach() {
        edges[$0[0]].append($0[1])
        edges[$0[1]].append($0[0])
    }
    var q:Set<Int> = [1]
    var d = 1
    while !q.isEmpty {
        q.forEach() {visited[$0] = true}
        print(d, q)
        var nodestovisit:Set<Int> = []
        for node in q {
            for e in edges[node] {
                if !visited[e] {
                    distances[e] = d
                    nodestovisit.insert(e)
                }
            }
        }
        q = nodestovisit
        d += 1
    }
    
    let maxd = distances.values.max()!
    return distances.filter({$0.value == maxd}).count
}
print(solution(6, [[3, 6], [4, 3], [3, 2], [1, 3], [1, 2], [2, 4], [5, 2]]), 3)

//https://fomaios.tistory.com/entry/Swift-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EC%8A%A4-%EA%B0%80%EC%9E%A5-%EB%A8%BC-%EB%85%B8%EB%93%9C
/*
import Foundation

var connection:[[Int]] = [[Int]]()
var visited:[Bool] = [Bool]()
var answerDic:[Int:Int] = [Int:Int]()

func solution(_ n:Int, _ edge:[[Int]]) -> Int {
    
    connection = Array(repeating: [Int](), count: n+1)
    visited = Array(repeating: false, count: n+1)
    
    edge.forEach() {
        connection[$0[0]].append($0[1])
        connection[$0[1]].append($0[0])
    }
    //여기까지는 별 차이 없던데.

    var currentNodes:Set<Int> = [1]
    var distance = 1
    
    //요점
    //currentNode 가 아니라 currentNodes 로 한꺼번에 묶어서 처리.
    //처리하는 노드들은 모두 같인 거리를 가지게 함.
    //방문체크를 통해 더 방문할 곳이 없으면 while문 밖으로 나오게 함.
    //ㅇㄴ ㅅㅂ 대체 왜 내 건 통과가 안 되는 건데 그럼?
    //어디서 차이가 나는 거지.
    
    while !currentNodes.isEmpty {
        var nodes = Set<Int>()
        //currentnodes 에 있는 것들을 모두 방문한 상태로 바꿈.
        currentNodes.forEach { visited[$0] = true }
        
        for node in currentNodes {
            
            //다음 currentNodes 가 될 node들을 모아놓는 곳.
                //Set<Int>를 통해 중복을 방지.
                //하지만 그걸로 부족하니까 들어갈 조건에 visitied 로 더블체크
            var numbers = Set<Int>()
            
            for number in connection[node] {
                //currentNodes 에 있는 각각의 node 에 연결된 다른 노드들(number)마다
                if !visited[number] {
                    //number를 방문하지 않았다면
                    //방문체크
                    visited[number] = true
                    //거리 측정
                    answerDic[number] = distance
                    //다음 단계에 집어넣음
                    numbers.insert(number)
                }
            }
            //nodes에 집어넣어서 이미 방문한 노드들은 안 가게 만듬
            numbers.forEach { nodes.insert($0) }
        }
        //numbers 가 비어 있어서 nodes 에 새로운 게들어가지 않으면
        //nodes 는 그냥 초기화된 상태로 가만히 있게 되고
        //currentnodes 도 비게 된다
        currentNodes = nodes
        //거리 + 1
        distance += 1
    }
    
    let maxd = answerDic.values.max()!
    
    return answerDic.filter({$0.value == maxd}).count
}
*/
