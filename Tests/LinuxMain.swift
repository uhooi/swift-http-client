import XCTest

import HTTPClientTests

var tests = [XCTestCaseEntry]()
tests += HTTPClientTests.allTests()
XCTMain(tests)
