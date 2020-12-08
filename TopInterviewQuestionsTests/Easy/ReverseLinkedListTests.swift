//
//  ReverseLinkedListTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 08.12.2020.
//
// https://leetcode.com/problems/reverse-linked-list/

import XCTest

/*
 Reverse a singly linked list.

 Input: 1->2->3->4->5->NULL
 Output: 5->4->3->2->1->NULL

 A linked list can be reversed either iteratively or recursively. Could you implement both?
 */

public class ListNode: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        if lhs.val != rhs.val {
            return false
        }

        var leftNode = lhs
        var rightNode = rhs

        while leftNode.next != nil && rightNode.next != nil
        {

            let left = leftNode.next?.val
            let right = rightNode.next?.val

            switch (left, right) {
            case let (l, r) where l != r:
                return false
            default:
                leftNode = leftNode.next!
                rightNode = rightNode.next!
            }
        }

        return true
    }

    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

extension ListNode: CustomDebugStringConvertible {
    public var debugDescription: String {
        var values: [Int] = [val]
        var current = self
        while let next = current.next {
            values.append(next.val)
            current = next
        }

        return String(describing: values)
    }
}

func reverseList(_ head: ListNode?) -> ListNode? {
    var head = head
    var previous: ListNode? = nil
    while let node = head {
        head = node.next
        node.next = previous
        previous = node
    }
    return previous
}

class ListNodeTests: XCTestCase {

    func test_debugDescription() {
        XCTAssertEqual(String(describing: ListNode(1)), "[1]")
        XCTAssertEqual(String(describing: ListNode(1, ListNode(2))), "[1, 2]")
        XCTAssertEqual(String(describing: ListNode(1, ListNode(2, ListNode(3)))), "[1, 2, 3]")
    }

    func test_Equatable_protocol() {
        XCTAssertEqual(ListNode(1), ListNode(1))
        XCTAssertEqual(ListNode(1, ListNode(2)), ListNode(1, ListNode(2)))
        XCTAssertEqual(ListNode(1, ListNode(2, ListNode(3))), ListNode(1, ListNode(2, ListNode(3))))

        XCTAssertNotEqual(ListNode(2, ListNode(1)), ListNode(1, ListNode(2)))
        XCTAssertEqual(ListNode(1, ListNode(2, ListNode(3))), ListNode(1, ListNode(2)))
        XCTAssertEqual(ListNode(1, ListNode(2, ListNode(3))), ListNode(1))
    }
}

class ReverseLinkedListTests: XCTestCase {

    func test_one_node() {
        let input = ListNode(1)
        let result = ListNode(1)
        XCTAssertEqual(reverseList(input), result)
    }

    func test_two_nodes() {
        let input = ListNode(1, ListNode(2))
        let result = ListNode(2, ListNode(1))
        XCTAssertEqual(reverseList(input), result)
    }

    func test_three_nodes() {
        let input = ListNode(1, ListNode(2, ListNode(3)))
        let result = ListNode(3, ListNode(2, ListNode(1)))
        XCTAssertEqual(reverseList(input), result)
    }
}
