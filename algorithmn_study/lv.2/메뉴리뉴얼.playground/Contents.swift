import Foundation

extension Array {
    //O(n^2) //n : # of element
    var powerset: [[Element]] {
        guard count > 0 else {
            return [[]]
        }

        // tail contains the whole array BUT the first element
        let tail = Array(self[1..<endIndex])

        // head contains only the first element
        let head = self[0]

        // computing the tail's powerset
        let withoutHead = tail.powerset

        // mergin the head with the tail's powerset
        let withHead = withoutHead.map { $0 + [head] }

        // returning the tail's powerset and the just computed withHead array
        return withHead + withoutHead
    }
}

func solution(_ orders:[String], _ course:[Int]) -> [String] {
    //return 형식: cand_menu 에서 뽑는걸로
    //cand_menu: 메뉴가 될 수 있는 것들
    //메뉴의 구성품 숫자를 cand_menu, cand_count 이중배열의 첫번째 인덱스로 활용
    
    var cand_menu:[[String]] = Array(repeating: [], count: course.last! + 1)
    var cand_count:[[Int]] = Array(repeating: [], count: course.last! + 1)
    let n = orders.count
    for i in 0 ..< n {
        let arr = orders[i].map() {String($0)}.powerset
        for k in course {
            let arr_k = arr.filter() {$0.count == k}
            for comb_menu in arr_k {
                for j in 0 ..< n {
                    guard j != i else {
                        continue
                    }
                    var c = 0
                    let comp = orders[j].map() {String($0)}
                    for m in comb_menu {
                        if comp.contains(m) {
                            c += 1
                        }
                    }
                    if c == comb_menu.count {
                        //print("hit!")
                        let candidate = comb_menu.sorted().joined()
                        if !cand_menu[k].contains(candidate) {
                            cand_menu[k].append(candidate)
                            cand_count[k].append(1)
                        } else {
                            let i = cand_menu[k].firstIndex(of: candidate)!
                            cand_count[k][i] += 1
                        }
                        //print(candidate)
                        //print(cand_menu)
                        //print(cand_count)
                    }
                }
            }
        }
    }
    
    var ans:[String] = []
    for i in 0 ..< cand_count.count {
        guard !cand_count[i].isEmpty else {
            continue
        }
        let intarr = cand_count[i]
        let m = intarr.max()!
        for j in 0 ..< intarr.count {
            if intarr[j] == m {
                ans.append(cand_menu[i][j])
            }
        }
    }
    ans.sort()
    
    return ans
    
}

//solution(["XYZ", "XWY", "WXA"], [2,3,4])
solution(["ABCDE", "AB", "CD", "ADE", "XYZ", "XYZ", "ACD"], [2,3,5])
