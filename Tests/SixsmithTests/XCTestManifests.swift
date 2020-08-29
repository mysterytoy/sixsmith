import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SixsmithTests.allTests),
        testCase(DirectionTests.allTests),
        testCase(HexArithmeticTests.allTests),
        testCase(HexConversionTests.allTests),
        testCase(HexEqualityTests.allTests),
        testCase(HexRelationalTests.allTests),
        testCase(PartialHexTests.allTests)
    ]
}
#endif
