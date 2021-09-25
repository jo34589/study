import Foundation

func solution(_ n:Int) -> [Int] {
    var rtn_arr = [Int]()
    var arr = [[Int]]()
    for i in 1 ... n {
        arr.append(Array(repeating: 0, count: i))
    }
    func fill (_ x:Int, _ y:Int, _ start:Int, _ num:Int) {
        for i in 0 ..< num {
            arr[i+x][0+y] = i+1+start
            arr[num-1+x][i+y] = num+i+start
            if i < num-1 {
                arr[num-1-i+x][num-1-i+y] = 2*num-1+i+start
            }
        }
        if num >= 4 {
            fill(x+2, y+1, 3*num-3+start, num-3)
        }
    }
    
    fill(0, 0, 0, n)
    
    for i in 0 ..< n {
        print(arr[i])
    }
    rtn_arr = Array(arr.joined())
    
    return rtn_arr
}

solution(20)
