//
//  ShuffleAnArrayTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 11.12.2020.
//
// https://leetcode.com/problems/shuffle-an-array/

import XCTest

/*Given an integer array nums, design an algorithm to randomly shuffle the array.
Implement the Solution class:

Solution(int[] nums) Initializes the object with the integer array nums.
int[] reset() Resets the array to its original configuration and returns it.
int[] shuffle() Returns a random shuffling of the array.

Constraints:
    1 <= nums.length <= 200
    -106 <= nums[i] <= 106
    All the elements of nums are unique.
    At most 5 * 104 calls will be made to reset and shuffle.*/


class Solution {
    var values: [Int]
    init(_ nums: [Int]) {
        self.values = nums
    }

    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        values
    }

    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        var _shuffled = values
        for i  in 0..<values.count {
            _shuffled.swapAt(i, nextRand(i, values.count))
        }
        return _shuffled
    }

    func shuffle2() -> [Int] { values.shuffled() }

    @inline(__always) func nextRand(_ i: Int, _ n: Int) -> Int {
        Int.random(in: min(i, n-1)...n-1)
    }
}



class ShuffleAnArrayTests: XCTestCase {

    func test_Solution_reset_restoresValues() {
        let input = [1, 2, 3, 4, 5]
        let sut = Solution(input)
        XCTAssertEqual(sut.reset(), input)
    }

    func test_Solution_shuffle_one() {
        let input = [1]
        let sut = Solution(input)
        let result = sut.shuffle()

        XCTAssertEqual(result, input)
    }

    func test_Solution_shuffle_two() {
        let input = [1, 2]
        let sut = Solution(input)
        let result = sut.shuffle()
        let changedPositions = result.enumerated().map { (idx, val) -> Int in
            let resultIdx = input.firstIndex(of: val)
            return idx != resultIdx ? 1 : 0
        }.reduce(0, +)

        XCTAssertNotEqual(result, input)
        XCTAssertGreaterThan(changedPositions, input.count / 2 - 1, "Shuffled but not as good as possible")
    }


    func test_Solution_shuffle_rearrangesValues() {
        let input = [1, 2, 3, 4, 5]
        let sut = Solution(input)
        let result = sut.shuffle()
        let changedPositions = result.enumerated().map { (idx, val) -> Int in
            let resultIdx = input.firstIndex(of: val)
            return idx != resultIdx ? 1 : 0
        }.reduce(0, +)

        XCTAssertNotEqual(result, input)
        XCTAssertGreaterThan(changedPositions, input.count / 2 - 1, "Shuffled but not as good as possible")
    }

    func test_Solution_shuffle_manyTimes() {
        let input = [-6, 10, 184]
        let sut = Solution(input)

        let count = (1...100).map { _ in
            sut.shuffle() != input ? 1 : 0
        }.reduce(0, +)


        XCTAssertGreaterThanOrEqual(count, 50)
    }

    func test_Solution_shuffle_100times() {
        let input = [-6,10,184]
        let sut = Solution(input)

        for _ in 1...100 {
            print(sut.reset())
            print(sut.shuffle2())
        }
    }
}
