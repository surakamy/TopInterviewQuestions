//
//  TwoSumTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 07.12.2020.
//
//  https://leetcode.com/problems/two-sum/

import XCTest

/*
 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 You can return the answer in any order.

 Constraints:
     2 <= nums.length <= 103
     -109 <= nums[i] <= 109
     -109 <= target <= 109
     Only one valid answer exists.
 */


// Time complexity: O(n)
// Space complexity: O(n)
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    if nums.count < 2 { return [] }

    // 1. Note to consider:
    // Reserving a capacity takes up space even for cases when it is not necesary.
    var processed = Dictionary<Int, Int>(minimumCapacity: nums.count - 1)
    // 2. Note to consider:
    // Swift Enumerator is slower than a simple for loop.
    for (idx, value) in nums.enumerated() {
        let aPairValue = target - value
        if let aPairIndex = processed[aPairValue] {
            return [aPairIndex, idx]
        }
        processed[value] = idx
    }

    return []
}

class TwoSumTests: XCTestCase {

    func test_input_breaksConstraints_retursEmptyIndices() throws {
        XCTAssertEqual(twoSum([], 0), [], "Too few nums")
        XCTAssertEqual(twoSum([1], 0), [], "Too few nums")
        XCTAssertEqual(twoSum([1, 2], 1), [], "No valid pair matches target")
        XCTAssertEqual(twoSum([3, 3], 3), [], "No valid pair matches target")
    }

    func test_input_valid_returnsIndices() {
        XCTAssertEqual(twoSum([3, 5, 7, 8, 9, 3], 6), [0, 5])
        XCTAssertEqual(twoSum([2, 7, 11, 15], 9), [0, 1])
        XCTAssertEqual(twoSum([3, 2, 4], 6), [1, 2])
        XCTAssertEqual(twoSum([3, 3], 6), [0, 1])
    }

}
