//
//  PrintZeroEvenOddTests.swift
//  TopInterviewQuestionsTests
//
//  Created by Dmytro Kholodov on 08.12.2020.
//
// https://leetcode.com/problems/print-zero-even-odd/

import XCTest
import Foundation

/*
 Suppose you are given the following code:
 class ZeroEvenOdd {
   public ZeroEvenOdd(int n) { ... }      // constructor
   public void zero(printNumber) { ... }  // only output 0's
   public void even(printNumber) { ... }  // only output even numbers
   public void odd(printNumber) { ... }   // only output odd numbers
 }

 The same instance of ZeroEvenOdd will be passed to three different threads:

 Thread A will call zero() which should only output 0's.
 Thread B will call even() which should only ouput even numbers.
 Thread C will call odd() which should only output odd numbers.
 Each of the threads is given a printNumber method to output an integer. Modify the given program to output the series 010203040506... where the length of the series must be 2n.

 */

final class ZeroEvenOdd {
    let n: Int

    private let lock = NSCondition()
    private var step = 0

    init(_ n: Int) {
        self.n = n
        lock.broadcast()
    }

    func zero(_ printNumber: (Int) -> Void) {
        lock.lock()

        for i in 1...n {

            while step != 0 {
                lock.wait()
            }

            printNumber(step)

            step = i
            lock.broadcast()

        }

        lock.unlock()
    }

    func even(_ printNumber: (Int) -> Void) {
        lock.lock()

        let evens = n/2

        (0..<evens).forEach {
            _ in

            while step == 0 || step % 2 != 0 {
                lock.wait()
            }

            printNumber(step)

            step = 0
            lock.signal()

        }

        lock.unlock()
    }

    func odd(_ printNumber: (Int) -> Void) {
        lock.lock()

        let odds = n % 2 == 0 ?
            n/2 :
            n/2 + 1

        (0..<odds).forEach {
            _ in

            while step == 0 || step % 2 == 0 {
                lock.wait()
            }

            printNumber(step)

            step = 0
            lock.signal()
        }

        lock.unlock()
    }
}

class PrintZeroEvenOddTests: XCTestCase {
    override func setUp() {
        Printer.reset()
    }

    override func tearDown() {
        Printer.reset()
    }

    func test_for_1() {
        assertOrderOfExecution(1, expected: "01")
    }

    func test_for_2() {
        assertOrderOfExecution(2, expected: "0102")
    }

    func test_for_3() {
        assertOrderOfExecution(3, expected: "010203")
    }

    func test_for_4() {
        assertOrderOfExecution(4, expected: "01020304")
    }

    func test_for_5() {
        assertOrderOfExecution(5, expected: "0102030405")
    }

    private func assertOrderOfExecution(_ n: Int, expected: String, file: StaticString = #filePath, line: UInt = #line) {
        let exp1 = XCTestExpectation(description: "1")
        let exp2 = XCTestExpectation(description: "2")
        let exp3 = XCTestExpectation(description: "3")

        DispatchQueue.global(qos: .default).async {

            let sut = ZeroEvenOdd(n)

            let t0 = Thread {
                sut.even(Printer.printNumber(_:))
                exp2.fulfill()
            }
            t0.name = "Printing Even Numbers"
            t0.start()


            let t1 = Thread {
                sut.zero(Printer.printNumber(_:))
                exp1.fulfill()
            }
            t1.name = "Printing just Zero"
            t1.start()


            let t2 = Thread {
                sut.odd(Printer.printNumber(_:))
                exp3.fulfill()
            }
            t2.name = "Printing Odd Numbers"
            t2.start()

        }

        wait(for: [exp1, exp2, exp3], timeout: 0.01)
        XCTAssertEqual(Printer.console, expected, file: file, line: line)
    }
}


// MARK: - Helpers

private class Printer {
    static var console = ""

    static let lock = NSLock()

    static func reset() {
        lock.lock()
        console = ""
        lock.unlock()
    }

    static func printNumber(_ x: Int) {
        lock.lock()
        console.append(String(describing: x))
        lock.unlock()
    }
}

class PrinterTests: XCTestCase {

    override func setUp() {
        Printer.reset()
    }

    override func tearDown() {
        Printer.reset()
    }

    func test_console_printsNumbers() {
        Printer.printNumber(1)
        XCTAssertEqual(Printer.console, "1")
        Printer.printNumber(2)
        XCTAssertEqual(Printer.console, "12")
    }

    func test_console_reset() {
        Printer.printNumber(1)
        Printer.printNumber(2)
        XCTAssertEqual(Printer.console, "12")
        Printer.reset()
        XCTAssertEqual(Printer.console, "")
    }
}

