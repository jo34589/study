import Foundation

func solution(_ name:String) -> Int {
    
    var cost = 0
    let dict: [String : Int] = ["A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6, "H":7, "I":8,
                                "J":9, "K":10, "L":11, "M":12, "N":13, "O":12, "P":11, "Q":10,
                                "R":9, "S":8, "T":7, "U":6, "V":5, "W":4, "X":3, "Y":2, "Z":1]
    let name = name.map() {dict[String($0)]!}
    
    class Node<T> {
        let value: T
        var edges = [Edge<T>]()
        var visited = false
        
        init(value: T) {
            self.value = value
        }
        
        func appendEdgeTo(_ node: Node<T>, _ weight: Int) {
            let edge = Edge<T>(from: self, to: node, weight: weight)
            self.edges.append(edge)
        }
    }
    
    class Edge<T> {
        weak var source: Node<T>?
        let destination: Node<T>
        let weight: Int
        
        init(from source: Node<T>, to destination: Node<T>, weight:Int) {
            self.source = source
            self.destination = destination
            self.weight = weight
        }
    }
    
    if name.count == 1 {
        cost = name[0]
        return cost
    }
    
    var G = [Node<Int>]()
    G.append(Node(value: name[0]))
    var count = 1
    var ind = 0
    for i in 1 ..< name.count {
        if name[i] > 0 {
            G.append(Node(value:name[i]))
            G.last!.appendEdgeTo(G[ind], count)
            G[ind].appendEdgeTo(G.last!, count)
            ind += 1
            count = 1
        } else {
            count += 1
        }
    }
    G.last!.appendEdgeTo(G.first!, count)
    G.first!.appendEdgeTo(G.last!, count)
    
    
    
    return cost
}

solution("JEROEN")
solution("JAN")
solution("J")
solution("JAAN")
solution("KAANAAAO")

//graph? maybe yse?
    //A의 개수를 edge 의 cost 로 치환하면?
    //그럼 첫번째 문자가 A 이면 root 노드를 어쩔거임?
    //"AABACAAAEA"
        //cost 0 자리 루트노드 로 하면 되지않을까?
    //그래프 구축: O(n)
    
