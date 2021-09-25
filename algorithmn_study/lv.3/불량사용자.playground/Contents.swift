//https://programmers.co.kr/learn/courses/30/lessons/64064
//Swift

import Foundation

func solution(_ user_id:[String], _ banned_id:[String]) -> Int {
    
    //banned_id 하나 당 걸러지는 user_id는 여러개 있을 수 있음.
    //그 중에 하나를 선택하여 밴함.
    //그렇게 조합이 여러개 나올 수 있음.
    //주의: 제제된 id를 빼고 남은 id 중에서 새로 제제할 id를 골라야 함.
        //따라서 두 개 이상의 banned_id에 걸리는 경우 하나의 선택이 다른 banned_id 의 선택 풀에 영향을 줌.
        //그래프? 탐색? 아니야.
        //다이나믹 프로그래밍? 아니야.
        //user_id 의 개수는 최대 8개
        //결론은 그냥 복잡하고 우직한 하드코딩
    //제제 아이디 목록의 경우의 수를 출력.
    
    //banned_id 하나 당 걸러지는 user_id들의 리스트로 가짐.
    //들어맞는 조합을 찾는 데 dfs 의 원리를 응용할 수 있다.
    let n = banned_id.count
    var banned_list: [[String]] = Array(repeating: [], count: n)
    let user_arr = user_id.map({$0.map({String($0)})})
    var ans_Set: Set = Set<[String]>()
    
    for b_i in 0 ..< n {
        let b_arr = banned_id[b_i].map( {String($0)} )
        for i_u in 0 ..< user_arr.count {
            guard user_arr[i_u].count == b_arr.count else {
                continue
            }
            var flag = true
            for i in 0 ..< b_arr.count {
                if b_arr[i] != "*" && b_arr[i] != user_arr[i_u][i] {
                    flag = false
                }
            }
            if flag {
                banned_list[b_i].append(user_id[i_u])
            }
        }
    }
    //print("banned list: ")
    for i in 0 ..< n {
        print(banned_list[i])
    }
    //print()
    
    var tempSet = Set<String>()
    //banned_list 의 각 원소마다 다음 줄을 재귀호출 해야 함.
    //만약 들어가지 않으면? list의 다음 원소를 시도.
    //호출 이후 넣었던 id를 지워야 깔끔.
    func dfs(depth: Int) {
        for i in 0 ..< banned_list[depth].count {
            let id = banned_list[depth][i]
            if tempSet.insert(id).inserted == false {
                continue
            }
            if depth < n-1 {
                //print("at depth: \(depth), \(tempSet)")
                dfs(depth: depth+1)
            } else {
                //depth == n-1
                //print("inserting: \(tempSet)")
                ans_Set.insert(tempSet.sorted())
            }
            tempSet.remove(id)
        }
    }
    
    dfs(depth: 0)
    //print("\nans set: ")
    //print(ans_Set)
    return ans_Set.count
}

//solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "abc1**"])
//solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["*rodo", "*rodo", "******"])
//solution(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "*rodo", "******", "******"])
