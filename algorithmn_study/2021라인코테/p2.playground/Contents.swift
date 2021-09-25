import Foundation
//주어진 패스워드가 어떤 규칙들(1~4)를 위반했는지 배열로 리턴
//없으면 0만 담아서 리턴
func solution(_ inp_str:String) -> [Int] {
    
    let g1:[UInt8] = [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90]
    let g2:[UInt8] = [97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118,119, 120, 121, 122]
    let g3:[UInt8] = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57]
    let g4:[UInt8] = [126, 33, 64, 35, 36, 37, 38, 94, 42]
    var ans = [Int]()
    
    //1
    if inp_str.count < 8 || inp_str.count > 15 {
        ans.append(1)
    }
    
    //2, 3
    let str_arr = inp_str.map() {String($0)}
    var arr = [0, 0, 0, 0]
    for ch in str_arr {
        let val = Character(ch).asciiValue
        if val == nil {
            if !ans.contains(2) {
                ans.append(2)
            }
        } else {
            if g1.contains(val!) {
                arr[0] = 1
            } else if g2.contains(val!) {
                arr[1] = 1
            } else if g3.contains(val!) {
                arr[2] = 1
            } else if g4.contains(val!) {
                arr[3] = 1
            } else {
                if !ans.contains(2) {
                    ans.append(2)
                }
            }
        }
    }
    var sum = 0
    for i in arr {
        sum += i
    }
    if sum < 3 {
        ans.append(3)
    }
    
    //4
    if str_arr.count >= 4 {
        for i in 0 ..< str_arr.count-4 {
            if Set(str_arr[i ... i+3]).count == 1 {
                ans.append(4)
                break
            }
        }
    }
    
    //5
    for i in 0 ..< str_arr.count {
        var count = 0
        for j in 0 ..< str_arr.count {
            if str_arr[i] == str_arr[j] {
                count += 1
            }
        }
        if count >= 5 {
            ans.append(5)
            break
        }
    }
    
    Set(ans)
    if ans.isEmpty {
        ans.append(0)
    }
    
    return ans
}
