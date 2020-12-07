//
//  ValidPalintromeTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 07.12.2020.
//
// https://leetcode.com/problems/valid-palindrome/

import XCTest

/*
 Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
 Note: For the purpose of this problem, we define empty string as valid palindrome.

 Constraints:
 s consists only of printable ASCII characters.

 */

func isPalindrome(_ s: String) -> Bool {

    if s.count < 1 {
        return true
    }

    let input = Array(
        s.filter { $0.isLetter || $0.isNumber }
        .lowercased()
        .utf8
    )

    if input.count < 1 {
        return true
    }

    var i = 0
    while i <= input.count / 2 {
        let head = input[i]
        let tail = input[input.count - i - 1]
        if head != tail {
            return false
        }
        i += 1
    }

    return true
}

class ValidPalintromeTests: XCTestCase {

    func test_noPalindomeCases() {
        XCTAssertFalse(isPalindrome("race a car"))
    }

    func test_palindrome_whenEmpty() {
        XCTAssertTrue(isPalindrome(""))
        XCTAssertTrue(isPalindrome("."))
    }

    func test_palindrome_whenOneCharacter() {
        XCTAssertTrue(isPalindrome("A"))
    }

    func test_palindrome_whenOnlyUpperCaseLetters() {
        XCTAssertTrue(isPalindrome("ABCBA"))
    }

    func test_palindrome_whenOnlyLowerCaseLetters() {
        XCTAssertTrue(isPalindrome("abcba"))
    }

    func test_palindrome_whenCasesMixed() {
        XCTAssertTrue(isPalindrome("aBcbA"))
    }

    func test_palindrome_whenLettersAndNumbers() {
        XCTAssertTrue(isPalindrome("a2Bcb2A"))
    }

    func test_palindrome_whenLettersAndNumbersPlusIgnoredCharacters() {
        XCTAssertTrue(isPalindrome("a.bcb-a"))
    }
}
