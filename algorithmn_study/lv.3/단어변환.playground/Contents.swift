//https://programmers.co.kr/learn/courses/30/lessons/43163
//Swift

//begin 에서 한 글자씩 바꿔 가며 words 를 통해 target 으로 닿는 것.
//리턴하는 건 최소 거리 => 중간과정이 다소 복잡할 뿐 그냥 bfs다.
//결론은 인접 리스트를 만들기만 하면 끝.
//고민거리1 : 인접 리스트를 뭘로 만들지? String? dict [String: [Int]] 로 할까.

import Foundation

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    guard words.contains(target) else {
        return 0
    }
    //words 배열의 각 요소가 방문됐는지 안 됐는지 확인할 배열
    var visited: [Bool] = Array(repeating: false, count: words.count)
    // 인접리스트용 딕셔너리
    var adj_dict: [String:[Int]] = [:]
    adj_dict[begin] = []
    words.forEach({adj_dict[$0] = []})
    
    func comp(_ base: String, _ target: String) -> Int {
        let b = base.map({String($0)})
        let t = target.map({String($0)})
        var rtn = 0
        for i in 0 ..< b.count {
            if b[i] != t[i] {
                rtn += 1
            }
        }
        return rtn
    }
    
    //begin
    for i in 0 ..< words.count {
        if comp(begin, words[i]) == 1 {
            adj_dict[begin]?.append(i)
        }
        for j in 0 ..< words.count {
            guard i != j else {
                continue
            }
            if comp(words[i], words[j]) == 1 {
                adj_dict[words[i]]?.append(j)
            }
        }
    }
    
    //print(adj_dict) //works well
    var length = 1
    var q:[Int] = adj_dict[begin]!
    while !q.isEmpty {
        for ind in q {
            if words[ind] == target {
                return length
            }
            visited[ind] = true
        }
        var next_set: Set<Int> = []
        for word_i in q {
            let w = words[word_i]
            let arr = adj_dict[w]!
            arr.forEach({ if !visited[$0] {
                next_set.insert($0)
            } })
        }
        q = Array(next_set)
        length += 1
    }
    
    return 0
}

solution("hit","cog",["hot", "dot", "dog", "lot", "log", "cog"])
