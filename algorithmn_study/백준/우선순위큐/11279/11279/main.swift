//
//  main.swift
//  11279
//
//  Created by 조선우 on 2021/02/08.
//

class MaxHeap {
    var arr = [Int](repeating: 0, count: 1)
    var size = 0
    
    func insert(_ n: Int) {
        arr.append(n)
        size += 1
        var i = size
        while i > 1 {
            let parent = i/2
            if arr[parent] < arr[i] {
                let temp = arr[parent]
                arr[parent] = arr[i]
                arr[i] = temp
                i = i/2
            } else {
                break
            }
        }
    }
    
    func remove() -> Int {
        if size == 0 {
            return 0
        } else {
            let rtn = arr[1]
            arr[1] = arr[size]
            arr.removeLast()
            size -= 1
            var i = 1
            while (i*2) <= size {
                let left = i*2
                let right = i*2+1
                if right > size {
                    if arr[i] < arr[left] {
                        let temp = arr[left]
                        arr[left] = arr[i]
                        arr[i] = temp
                        i = left
                    }
                } else {
                    if arr[i] < arr[left] && arr[i] < arr[right] {
                        break
                    } else {
                        if arr[left] > arr[right] {
                            let temp = arr[left]
                            arr[left] = arr[i]
                            arr[i] = temp
                            i = left
                        } else {
                            let temp = arr[right]
                            arr[right] = arr[i]
                            arr[i] = temp
                            i = right
                        }
                    }
                }
            }
            return rtn
        }
    }
}

let n = Int(readLine()!)!
let mh = MaxHeap()
for _ in 0 ..< n {
    let x = Int(readLine()!)!
    if x == 0 {
        print(mh.remove())
    } else {
        mh.insert(x)
    }
}
