//https://programmers.co.kr/learn/courses/30/lessons/42888
//Swift

import Foundation
//timed out

func solution(_ record:[String]) -> [String] {
    
    var ans: [[String]] = []
    var rtn: [String] = []
    var name_dict: [String : String] = [:]
    for line in record {
        let l = line.split(separator: " ").map({String($0)})
        if l[0] == "Enter" {
            name_dict[l[1]] = l[2]
            ans.append([l[2], "님이 들어왔습니다.", l[1]])
        } else if l[0] == "Leave" {
            ans.append([name_dict[l[1]]!, "님이 나갔습니다.", l[1]])
        } else if l[0] == "Change" {
            name_dict[l[1]] = l[2]
        } else {
            print("command Error")
            break
        }
    }
    
    for i in 0 ..< ans.count {
        ans[i][0] = name_dict[ans[i][2]]!
        rtn.append(ans[i][0...1].joined())
    }
    
    return rtn
}

solution(["Enter uid1234 Muzi",
          "Enter uid4567 Prodo",
          "Leave uid1234",
          "Enter uid1234 Prodo",
          "Change uid4567 Ryan"])
//["Prodo님이 들어왔습니다.", "Ryan님이 들어왔습니다.", "Prodo님이 나갔습니다.", "Prodo님이 들어왔습니다."]
