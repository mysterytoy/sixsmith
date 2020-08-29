import XCTest

import SixsmithTests

var tests = [XCTestCaseEntry]()
tests += DirectionTests.allTests()
tests += HexArithmeticTests.allTests()
tests += HexConversionTests.allTests()
tests += HexEqualityTests.allTests()
tests += HexRelationalTests.allTests()
tests += PartialHexTests.allTests()
XCTMain(tests)
