//
//  main.swift
//  10809
//
//  Created by 조선우 on 2020/11/26.
//

import Foundation

var word = readLine()!

var ans = [Int](repeating: -1, count: 26)
var count = 0
for character in word {
    switch String(character) {
    case "a":
        if ans[0] >= 0 {
            count = count + 1
            continue
        } else {
            ans[0] = count
        }
    case "b":
        if ans[1] >= 0 {
            count = count + 1
            continue
        } else {
            ans[1] = count
        }
    case "c":
        if ans[2] >= 0 {
            count = count + 1
            continue
        } else {
            ans[2] = count
        }
    case "d":
        if ans[3] >= 0 {
            count = count + 1
            continue
        } else {
            ans[3] = count
        }
    case "e":
        if ans[4] >= 0 {
            count = count + 1
            continue
        } else {
            ans[4] = count
        }
    case "f":
        if ans[5] >= 0 {
            count = count + 1
            continue
        } else {
            ans[5] = count
        }
    case "g":
        if ans[6] >= 0 {
            count = count + 1
            continue
        } else {
            ans[6] = count
        }
    case "h":
        if ans[7] >= 0 {
            count = count + 1
            continue
        } else {
            ans[7] = count
        }
    case "i":
        if ans[8] >= 0 {
            count = count + 1
            continue
        } else {
            ans[8] = count
        }
    case "j":
        if ans[9] >= 0 {
            count = count + 1
            continue
        } else {
            ans[9] = count
        }
    case "k":
        if ans[10] >= 0 {
            count = count + 1
            continue
        } else {
            ans[10] = count
        }
    case "l":
        if ans[11] >= 0 {
            count = count + 1
            continue
        } else {
            ans[11] = count
        }
    case "m":
        if ans[12] >= 0 {
            count = count + 1
            continue
        } else {
            ans[12] = count
        }
    case "n":
        if ans[13] >= 0 {
            count = count + 1
            continue
        } else {
            ans[13] = count
        }
    case "o":
        if ans[14] >= 0 {
            count = count + 1
            continue
        } else {
            ans[14] = count
        }
    case "p":
        if ans[15] >= 0 {
            count = count + 1
            continue
        } else {
            ans[15] = count
        }
    case "q":
        if ans[16] >= 0 {
            count = count + 1
            continue
        } else {
            ans[16] = count
        }
    case "r":
        if ans[17] >= 0 {
            count = count + 1
            continue
        } else {
            ans[17] = count
        }
    case "s":
        if ans[18] >= 0 {
            count = count + 1
            continue
        } else {
            ans[18] = count
        }
    case "t":
        if ans[19] >= 0 {
            count = count + 1
            continue
        } else {
            ans[19] = count
        }
    case "u":
        if ans[20] >= 0 {
            count = count + 1
            continue
        } else {
            ans[20] = count
        }
    case "v":
        if ans[21] >= 0 {
            count = count + 1
            continue
        } else {
            ans[21] = count
        }
    case "w":
        if ans[22] >= 0 {
            count = count + 1
            continue
        } else {
            ans[22] = count
        }
    case "x":
        if ans[23] >= 0 {
            count = count + 1
            continue
        } else {
            ans[23] = count
        }
    case "y":
        if ans[24] >= 0 {
            count = count + 1
            continue
        } else {
            ans[24] = count
        }
    case "z":
        if ans[25] >= 0 {
            count = count + 1
            continue
        } else {
            ans[25] = count
        }
    default:
        continue
    }
    count = count + 1
}
for i in ans {
    print(i, separator: "", terminator: " ")
}
