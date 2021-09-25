//
//  main.swift
//  10816
//
//  Created by 조선우 on 2021/02/03.
//

//방법1: 위치를 찾고 주변을 탐색(정렬되어있으니까.)
// worst case: 모두 같은 숫자 (O(MNlogN) <= 시간초과
//방법2: 숫자를 하나 찾을 때 마다 arr 에서 제거. 더 이상 나오지 않을 때 까지 반복
// wrong case: 같은 숫자를 두 번 찾을 때
//방법3: 어떻게든 찾을 때 범위를 찾아 반납 가능하도록 만들기
// MlogN 사이에 해결해야만.

func binary_range_search(_ arr: [Int], _ val: Int) -> Int {
    let lower_bound: Int
    let upper_bound: Int
    var low = 0
    var high = arr.count
    
    while low < high {
        let mid = (low + high) / 2
        if arr[mid] < val {
            low = mid + 1
        } else {
            high = mid
        }
    }
    lower_bound = low
    high = arr.count
    while low < high {
        let mid = (low + high) / 2
        if arr[mid] > val {
            high = mid
        } else {
            low = mid + 1
        }
    }
    upper_bound = high
    //return [upper_bound, lower_bound]
    return upper_bound - lower_bound
}

let n = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").compactMap() {Int($0)!}
let m = Int(readLine()!)!
let line = readLine()!.split(separator: " ").compactMap() {Int($0)!}

arr.sort()

for num in line {
    print(binary_range_search(arr, num), separator: "", terminator: " ")
}
