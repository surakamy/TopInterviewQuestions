//
//  FirstBadVersionTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 07.12.2020.
//
// https://leetcode.com/problems/first-bad-version/

import XCTest

/*
 You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

 Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.

 You are given an API bool isBadVersion(version) which returns whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

 Constraints:
    1 <= bad <= n <= 231 - 1
 */

class VersionControl {
    let bad: Int

    init(bad: Int) {
        self.bad = bad
    }

    func isBadVersion(_ version: Int) -> Bool {
        version >= bad
    }
}

class FirstBadVersionSolution : VersionControl {
    // Time complexity: O(log n)
    // Space complexity: O(1)
    func firstBadVersion(_ n: Int) -> Int {
        var start = 1
        var end = n

        while start != end {
            let mid = start + (end - start) / 2
            if isBadVersion(mid) {
                end = mid
            } else {
                start = mid + 1
            }
        }
        return end
    }
}


class FirstBadVersionTests: XCTestCase {

    func test_isBadVersion_returnTrue_whenVersionGreaterOrEqualThanBad() {
        let sut = VersionControl(bad: 4)
        XCTAssertTrue(sut.isBadVersion(5))
    }

    func test_isBadVersion_returnFalse_whenVersionLessThanBad() {
        let sut = VersionControl(bad: 4)
        XCTAssertFalse(sut.isBadVersion(3))
    }

    func test_Sample1() {
        let sut = FirstBadVersionSolution(bad: 4)
        XCTAssertEqual(sut.firstBadVersion(5), 4)
    }

    func test_Sample2() {
        let sut = FirstBadVersionSolution(bad: 1)
        XCTAssertEqual(sut.firstBadVersion(1), 1)
    }

    func test_Sample3() {
        let sut = FirstBadVersionSolution(bad: 2)
        XCTAssertEqual(sut.firstBadVersion(7), 2)
    }


    func test_Performance() {
        let sut = FirstBadVersionSolution(bad: 4)

        measure {
            _ = sut.firstBadVersion(5)
        }
    }
}
