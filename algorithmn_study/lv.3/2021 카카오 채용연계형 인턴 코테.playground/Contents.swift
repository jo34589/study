import Foundation
/*
func solution(_ n:Int, _ k:Int, _ cmd:[String]) -> String {
    
    var ans:[String] = Array(repeating: "O", count: n)
    var stack_deleted_i:[Int] = []
    var selected_i = k
    var top = n - 1
    for c in cmd {
        //print("\(selected_i) //", terminator: " ")
        //print(c, terminator: "   ")
        if c == "Z" {
            let last = stack_deleted_i.removeLast()
            ans[last] = "O"
            if last > top {
                top = last
            }
        }
        else if c == "C" {
            stack_deleted_i.append(selected_i)
            ans[selected_i] = "X"
            if selected_i == top {
                while ans[selected_i] == "X" {
                    selected_i -= 1
                }
                top = selected_i
            } else {
                while selected_i < top && ans[selected_i] == "X" {
                    selected_i += 1
                }
                /*if selected_i == n {
                    selected_i = stack_deleted_i.last!
                    while ans[selected_i] == "X" {
                        selected_i -= 1
                    }
                }*/
            }
        } else {
            let l = c.split(separator: " ").map({String($0)})
            if l[0] == "D" {
                var x = Int(l[1])!
                while x > 0 {
                    if ans[selected_i] == "X" {
                        selected_i += 1
                    } else {
                        selected_i += 1
                        x -= 1
                    }
                    //print("D", terminator: " ")
                }
                while ans[selected_i] == "X" {
                    selected_i += 1
                }
            } else if l[0] == "U" {
                var x = Int(l[1])!
                while x > 0 {
                    if ans[selected_i] == "X" {
                        selected_i -= 1
                    } else {
                        selected_i -= 1
                        x -= 1
                    }
                    //print("U", terminator: " ")
                }
                while ans[selected_i] == "X" {
                    selected_i -= 1
                }
            }
        }
        //print("=> \(selected_i)")
        //print(ans)
    }
    
    return ans.joined()
}
*/
//solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z"])
//solution(8, 2, ["D 2","C","U 3","C","D 4","C","U 2","Z","Z","U 1","C"])

func solution(_ k:Int, _ num:[Int], _ links:[[Int]]) -> Int {
    if k == num.count {
        return num.max()!
    } else if k == 1 {
        return num.reduce(0, +)
    } else {
        var n:[Int] = [-1]
        for i in 0 ..< num.count {
            n.append(i)
        }
        for l in links {
            for x in l {
                n.removeAll(where: {$0 == x})
            }
        }
    }
    return 0
}


import Foundation

func solution(_ places:[[String]]) -> [Int] {
    var ans:[Int] = []
    
    func check(_ grid:[[String]]) -> Int {
        // 오른쪽+아래 방향
        for i in 0 ..< 3 {
            for j in 0 ..< 3 {
                if grid[i][j] == "P" {
                    if grid[i+1][j] == "P" || grid[i][j+1] == "P" {
                        return 0
                    }
                    if grid[i+2][j] == "P" && grid[i+1][j] != "X" {
                        return 0
                    }
                    if grid[i][j+2] == "P" && grid[i][j+1] != "X" {
                        return 0
                    }
                    if grid[i+1][j+1] == "P" && (grid[i][j+1] != "X" || grid[i+1][j] != "X") {
                        return 0
                    }
                }
            }
        }
        // i = 3
        for j in 0 ..< 3 {
            if grid[3][j] == "P" {
                if grid[4][j] == "P" || grid[3][j+1] == "P" {
                    return 0
                }
                if grid[3][j+2] == "P" && grid[3][j+1] != "X" {
                    return 0
                }
                if grid[4][j+1] == "P" && (grid[3][j+1] != "X" || grid[4][j] != "X") {
                    return 0
                }
            }
        }
        //j = 3
        for i in 0 ..< 3 {
            if grid[i][3] == "P" {
                if grid[i+1][3] == "P" || grid[i][4] == "P" {
                    return 0
                }
                if grid[i+2][3] == "P" && grid[i+1][3] != "X" {
                    return 0
                }
                if grid[i+1][4] == "P" && (grid[i][4] != "X" || grid[i+1][3] != "X") {
                    return 0
                }
            }
        }
        //i = 4
        for j in 0 ..< 3 {
            if grid[4][j] == "P" {
                if grid[4][j+1] == "P" {
                    return 0
                }
                if grid[4][j+2] == "P" && grid[4][j+1] != "X" {
                    return 0
                }
            }
        }
        //j = 4
        for i in 0 ..< 3 {
            if grid[i][4] == "P" {
                if grid[i+1][4] == "P" {
                    return 0
                }
                if grid[i+2][4] == "P" && grid[i+1][4] != "X" {
                    return 0
                }
            }
        }
        //i = 3, j = 3
        if grid[3][3] == "P" {
            if grid[3][4] == "P" || grid[4][3] == "P" {
                return 0
            }
            if grid[4][4] == "P" && (grid[3][4] != "X" || grid[4][3] != "X") {
                return 0
            }
        }
        // / 방향
        for j in 1 ..< 5 {
            if grid[1][j-1] == "P" && grid[0][j] == "P" {
                if grid[0][j-1] != "X" || grid[1][j] != "X" {
                    return 0
                }
            }
        }
        for i in 1 ..< 5 {
            if grid[i][0] == "P" && grid[i-1][1] == "P" {
                if grid[i][1] != "X" || grid[i-1][0] != "X" {
                    return 0
                }
            }
        }
        for i in 1 ..< 4 {
            for j in 1 ..< 4 {
                if grid[i][j] == "P" && grid[i-1][j+1] == "P" {
                    if grid[i-1][j] != "X" || grid[i][j+1] != "X" {
                        return 0
                    }
                }
                if grid[i][j] == "P" && grid[i+1][j-1] == "P" {
                    if grid[i+1][j] != "X" || grid[i][j-1] != "X" {
                        return 0
                    }
                }
            }
        }
        if grid[3][4] == "P" && grid[4][3] == "P" {
            if grid[4][4] != "X" || grid[3][3] != "X" {
                return 0
            }
        }
        return 1
    }
    
    for str in places {
        let grid = str.map({$0.map({String($0)})})
        ans.append(check(grid))
    }
    
    return ans
}


import Foundation

func solution(_ s:String) -> Int {
    let sam = ["one", "two", "six"]
    let sa = ["zero", "four", "five", "nine"]
    let o = ["three", "seven", "eight"]
    let num = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    var arr = s.map({String($0)})
    var ans:[String] = []
    var st:[String] = []
    var i = 0
    while i < arr.count {
        if num.contains(arr[i]) {
            ans.append(arr[i])
        } else {
            st.append(arr[i])
            let w = st.joined()
            var matchflag = false
            if st.count == 3 && sam.contains(w) {
                matchflag = true
                if arr[i] == "e" {
                    ans.append("1")
                } else if arr[i] == "o" {
                    ans.append("2")
                } else {
                    ans.append("6")
                }
            }
            if st.count == 4 && sa.contains(w) {
                matchflag = true
                if arr[i] == "e" {
                    if arr[i-1] == "n" {
                        ans.append("9")
                    } else {
                        ans.append("5")
                    }
                } else if arr[i] == "o" {
                    ans.append("0")
                } else {
                    ans.append("4")
                }
            }
            if st.count == 5 {
                matchflag = true
                if arr[i] == "e" {
                    ans.append("3")
                } else if arr[i] == "n" {
                    ans.append("7")
                } else {
                    ans.append("8")
                }
            }
            if matchflag {
                st = []
            }
        }
        i += 1
    }
    
    return Int(ans.joined())!
}
