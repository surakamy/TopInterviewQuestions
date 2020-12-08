//
//  ClibmingStairsTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 08.12.2020.
//
// https://leetcode.com/problems/climbing-stairs/

import XCTest

/*
 You are climbing a staircase. It takes n steps to reach the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 Constraints:
    1 <= n <= 45
 */

func climbStairs(_ n: Int) -> Int {
    var steps: [Int: Int] = [:]

    func _climbStairs(_ n: Int) -> Int {
        if let calculated = steps[n] {
            return calculated
        }
        if n <= 2 {
            return n
        }

        let result = _climbStairs(n - 1) + _climbStairs(n - 2)
        steps[n] = result
        return result
    }

    return _climbStairs(n)
}




class ClibmingStairsTests: XCTestCase {

    func test_input_one_returns_one() {
        XCTAssertEqual(climbStairs(1), 1)
        XCTAssertEqual(climbStairs(2), 2)
        XCTAssertEqual(climbStairs(3), 3)
        XCTAssertEqual(climbStairs(4), 5)
        XCTAssertEqual(climbStairs(5), 8)
        XCTAssertEqual(climbStairs(6), 13)
    }
}

/*

 1 1         2
 2

 1  1 1       3
 1  2
 2 1

 1  1 1 1     4
 1  1 2
 1  2 1
 2 2
 2 1 1

 1  1 1 1 1     5
 1  1 1 2
 1  1 2 1
 1  2 2
 1  2 1 1
 2 1 1 1
 2 2 1
 2 1 2


 n = 2 s = 1
 n = 3 s = 1
 n = 4 s = 2
 n = 5 s = 3


 */
