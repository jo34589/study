/*
 operations는 길이가 1 이상 1,000,000 이하인 문자열 배열입니다.
 operations의 원소는 큐가 수행할 연산을 나타냅니다.
 원소는 “명령어 데이터” 형식으로 주어집니다.- 최댓값/최솟값을 삭제하는 연산에서 최댓값/최솟값이 둘 이상인 경우, 하나만 삭제합니다.
 빈 큐에 데이터를 삭제하라는 연산이 주어질 경우, 해당 연산은 무시합니다.
 
 요구조건:
 1. Int 형 정수를 저장하는 자료구조
 2. 삽입, 삭제 과정이 log n 안에 이루어져야 함.(명령어가 n개임)
 3. 대신 삭제는 최댓값과 최솟값에서만 이루어짐.
    즉, 찾아서(최대 log n), O(1)만에 없앨 수 있어야 함.
 > 배열로 한다면?
    if 최솟값을 제일 앞에, 최댓값을 제일 뒤에 둘 수 있다면,
        최솟값 삭제에 n, 최댓값 삭제에 1 : 망
 > 최소 트리여야 함.
    힙(우선순위큐)의 경우엔 최소값만, 혹은 최대값만 되기에 쓸 수 없다. 그래서 이 문제가 이중우선순위큐 인 거겠지.
 > 기본을 이진트리로 잡고 가보자.
    자동으로 균형을 잡는 이진트리라면, 위 조건을 충족할 수 있긴 할텐데
    RB트리? 로 해 보자.
 https://zeddios.tistory.com/237
*/

import Foundation

let red = false
let black = true
//null node 는 black

struct rbnode {
    let val:Int
    var color:Bool = red
    var parent:UnsafeMutablePointer<rbnode>?
    var left:UnsafeMutablePointer<rbnode>?
    var right:UnsafeMutablePointer<rbnode>?
}

struct rbtree {
    var root:UnsafeMutablePointer<rbnode>?
    var size:Int = 0
    
    func check_doublered(node: UnsafeMutablePointer<rbnode>) -> Bool {
        if node.pointee.parent?.pointee.color == red && node.pointee.color == red {
            return true
        } else {
            return false
        }
    }
    
    func check_uncle(node: UnsafeMutablePointer<rbnode>) -> Bool {
        //double red 일 때만 실행: doublered 라 함은 gpnode 가 null 이 아님을 보장함
        let pnode = node.pointee.parent!
        let gpnode = pnode.pointee.parent!
        var uncle: UnsafeMutablePointer<rbnode>?
        if gpnode.pointee.left == pnode {
            uncle = gpnode.pointee.right
        } else {
            uncle = gpnode.pointee.left
        }
        if uncle == nil {
            return black
        } else {
            return uncle!.pointee.color
        }
    }
    
    mutating func recolor(at node: UnsafeMutablePointer<rbnode>) {
        //확실하게 recolor 해야 하는 순간에만 쓸 것.
        //uncle and parent and self is red(initially)
        let pnode = node.pointee.parent!
        let gpnode = pnode.pointee.parent!
        var uncle:UnsafeMutablePointer<rbnode>?
        if gpnode.pointee.left == pnode {
            uncle = gpnode.pointee.right
        } else if gpnode.pointee.right == pnode {
            uncle = gpnode.pointee.left
        }
        pnode.pointee.color = black
        uncle!.pointee.color = black
        gpnode.pointee.color = red
        if gpnode == root {
            gpnode.pointee.color = black
        }
    }
    
    mutating func restructure(at node: UnsafeMutablePointer<rbnode>) {
        //확실하게 restructure 해야 하는 순간에만 쓸 것.
        //uncleis black or null / parent and self is red(initially)
        //1. gp의 부모는 새로 만들어진 부모노드를 자식으로 삼음.
        //2. 왼쪽의 자식 노드들은 왼쪽에
        //3. 오른쪽의 자식 노드들은 오른쪽에 붙여 주면 됨.
        
        let pnode = node.pointee.parent!
        let gpnode = pnode.pointee.parent!
        if pnode == gpnode.pointee.right && node == pnode.pointee.right {
            //case1: gp < p < n
            let zero = gpnode.pointee.parent
            let one = gpnode.pointee.left
            let two = pnode.pointee.left
            let three = node.pointee.left
            let four = node.pointee.right
            
            gpnode.pointee.parent = pnode
            node.pointee.parent = pnode
            pnode.pointee.right = node
            pnode.pointee.left = gpnode
            
            pnode.pointee.parent = zero
            gpnode.pointee.left = one
            gpnode.pointee.right = two
            node.pointee.left = three
            node.pointee.right = four
            
            pnode.pointee.color = black
            gpnode.pointee.color = red
            node.pointee.color = red
            
        } else if pnode == gpnode.pointee.left && node == pnode.pointee.right {
            //caes2: p < n < gp
            let zero = gpnode.pointee.parent
            let one = pnode.pointee.left
            let two = node.pointee.left
            let three = node.pointee.right
            let four = pnode.pointee.right
            
            node.pointee.right = gpnode
            node.pointee.left = pnode
            pnode.pointee.parent = node
            gpnode.pointee.parent = node
            
            node.pointee.parent = zero
            pnode.pointee.left = one
            pnode.pointee.right = two
            gpnode.pointee.left = three
            gpnode.pointee.right = four
            
            node.pointee.color = black
            pnode.pointee.color = red
            gpnode.pointee.color = red
            
        } else if pnode == gpnode.pointee.right && node == pnode.pointee.left {
            //case3: gp < n < p
            let zero = gpnode.pointee.parent
            let one = gpnode.pointee.left
            let two = node.pointee.left
            let three = node.pointee.right
            let four = pnode.pointee.right
            
            node.pointee.right = pnode
            node.pointee.left = gpnode
            gpnode.pointee.parent = node
            pnode.pointee.parent = node
            
            node.pointee.parent = zero
            gpnode.pointee.left = one
            gpnode.pointee.right = two
            pnode.pointee.left = three
            pnode.pointee.right = four
            
            node.pointee.color = black
            pnode.pointee.color = red
            gpnode.pointee.color = red
            
        } else if pnode == gpnode.pointee.left && node == pnode.pointee.left {
            //case4: n < p < gp
            let zero = gpnode.pointee.parent
            let one = node.pointee.left
            let two = node.pointee.right
            let three = pnode.pointee.right
            let four = gpnode.pointee.right
            
            pnode.pointee.left = node
            pnode.pointee.right = gpnode
            node.pointee.parent = pnode
            gpnode.pointee.parent = pnode
            
            pnode.pointee.parent = zero
            node.pointee.left = one
            node.pointee.right = two
            gpnode.pointee.left = three
            gpnode.pointee.right = four
            
            pnode.pointee.color = black
            node.pointee.color = red
            gpnode.pointee.color = red
            
        } else {
            print("error")
            return
        }
    }
    
    mutating func insert(node: UnsafeMutablePointer<rbnode>) {
        if size == 0 {
            root = node
            root!.pointee.color = black
        } else {
            var comp = root!
            while node.pointee.parent == nil {
                if comp.pointee.val > node.pointee.val {
                    if comp.pointee.left == nil {
                        node.pointee.parent = comp
                        comp.pointee.left = node
                    } else {
                        comp = comp.pointee.left!
                    }
                } else {
                    if comp.pointee.right == nil {
                        node.pointee.parent = comp
                        comp.pointee.right = node
                    } else {
                        comp = comp.pointee.right!
                    }
                }
            }
        }
        size += 1
    }
    
    func find_replacement(of node: UnsafeMutablePointer<rbnode>) -> UnsafeMutablePointer<rbnode>? {
        //inorder traversal from node
        //평범한 bst 라면 replace 할 node 는 일단 지금 지울 노드보다 아래에 위치해야 한다.
        //그냥 root 부터 순회시켜라.
        //자 이걸 어떻게 짠담.
        //일단 시작은 가장 왼쪽 노드
        var arr: [(UnsafeMutablePointer<rbnode>, Int)] = []
        
        func inorder(at current: UnsafeMutablePointer<rbnode>, depth: Int) {
            //left
            if current.pointee.left != nil {
                inorder(at: current.pointee.left!, depth: depth+1)
            }
            //current
            arr.append((current, depth))
            //right
            if current.pointee.right != nil {
                inorder(at: current.pointee.right!, depth: depth+1)
            }
        }
        
        inorder(at: root!, depth: 0)
        
        if arr[0].0 == node {
            return arr[1].0
        } else if arr[arr.count-1].0 == node {
            return arr[arr.count-2].0
        }
        for i in 1 ..< arr.count-1 {
            if arr[i].0 == node {
                if arr[i+1].1 > arr[i].1 {
                    return arr[i-1].0
                } else {
                    return arr[i+1].0
                }
            }
        }
        
        return nil
    }
    
    mutating func delete(mode: Int) -> Bool{
        guard size >= 1 else {
            return false
        }
        guard size != 1 else {
            root = nil
            size -= 1
            return true
        }
        
        var node_to_delete:UnsafeMutablePointer<rbnode> = root!
        
        //finding node to delete
        if mode == 1 {
            while node_to_delete.pointee.right != nil {
                node_to_delete = node_to_delete.pointee.right!
            }
        } else if mode == -1 {
            while node_to_delete.pointee.left != nil {
                node_to_delete = node_to_delete.pointee.left!
            }
        } else {
            print("error at deletion: wrong parameter")
            return false
        }
        
        //finding replacement (BST deletion)
        var replacement:UnsafeMutablePointer<rbnode>?
        var x:UnsafeMutablePointer<rbnode>?
        //case1: no child
        if node_to_delete.pointee.left == nil && node_to_delete.pointee.right == nil {
            replacement = nil
        //case2: one child
        } else if node_to_delete.pointee.left == nil && node_to_delete.pointee.right != nil {
            replacement = find_replacement(of: node_to_delete)
        } else if node_to_delete.pointee.left != nil && node_to_delete.pointee.right == nil {
            replacement = find_replacement(of: node_to_delete)
        //case3: two children
        } else {
            replacement = find_replacement(of: node_to_delete)
            x = replacement!.pointee.right
            
        }
        
        size -= 1
        return true
    }
}

func solution(_ operations:[String]) -> [Int] {
    
    for str in operations {
        let num = Int(str[str.index(str.startIndex, offsetBy: 2) ..< str.endIndex])
        if str.first == "I" {
            
        } else if str.first == "D" {
            if num == -1 {
                
            } else if num == 1 {
                
            } else {
                print("error")
                return []
            }
        } else {
            print("error")
            return []
        }
    }
    return []
}

solution(["I 87"])
