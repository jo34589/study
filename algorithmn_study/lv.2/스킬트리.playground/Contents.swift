import Foundation

func solution(_ skill:String, _ skill_trees:[String]) -> Int {
    var rtn = 0
    let sk = skill.map() {String($0)}
    for st in skill_trees {
        let skt = st.map() {String($0)}
        var index = [Int]()
        for i in 0 ..< skt.count {
            for k in sk {
                if k == skt[i] {
                    index.append(sk.firstIndex(of: k)!)
                    continue
                }
            }
            index.append(-1)
        }
        //print(index)
        if Set(index) == [-1] {
            rtn += 1
            continue
        } else {
            index.removeAll(where: {$0 == -1})
            //print(index)
            if index[0] != 0 {
                continue
            } else {
                if index.count > 1 {
                    var flag = true
                    for i in 0 ..< index.count-1 {
                        if index[i]+1 != index[i+1] {
                            flag = false
                            break
                        }
                    }
                    if flag {
                       rtn += 1
                    }
                } else {
                    rtn += 1
                }
            }
        }
    }
    //print("")
    return rtn
}
