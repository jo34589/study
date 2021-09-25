import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    
    let n = id_list.count
    var rep_set: [String:Set<String>] = [:]
    id_list.forEach({rep_set[$0] = Set<String>()})
    report.forEach({
        let line = $0.split(separator: " ").map({String($0)})
        //line[0] 신고한 사람
        //line[1] 신고당한 사람
        rep_set[line[1]]?.insert(line[0])
    })
    var id_idx: [String:Int] = [:]
    for i in 0  ..< n {
        id_idx[id_list[i]] = i
    }
    
    var mail = Array(repeating: 0, count: id_list.count)
    for (key, value) in rep_set {
        //key 신고받은 사람
        //value 신고한 사람의 리스트
        if value.count >= k {
            for name in value {
                let idx = id_idx[name]!
                mail[idx] += 1
            }
        }
    }
    
    return mail
}
