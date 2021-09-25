//https://programmers.co.kr/learn/courses/30/lessons/77486
//Swift

import Foundation

func solution(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {
    
    let n = enroll.count
    var rev = Array(repeating: 0, count: n)
    var name_index_dict: [String:Int] = [:]
    for i in 0 ..< n {
        name_index_dict[enroll[i]] = i
    }
    
    for i in 0 ..< seller.count {
        let name = seller[i]
        let index_enroll = name_index_dict[name]!
        rev[index_enroll] += amount[i]*90
        var rest = amount[i]*10
        var referral_name = referral[index_enroll]
        while (referral_name != "-" && rest != 0) {
            let ref_index = name_index_dict[referral_name]!
            let pass_up = rest/10
            rev[ref_index] += rest - pass_up
            rest = pass_up
            referral_name = referral[ref_index]
        }
    }
    
    return rev
}

solution(["john", "mary", "edward", "sam", "emily", "jaimie", "tod", "young"],
         ["-", "-", "mary", "edward", "mary", "mary", "jaimie", "edward"],
         ["young", "john", "tod", "emily", "mary"],
         [12, 4, 2, 5, 10])
