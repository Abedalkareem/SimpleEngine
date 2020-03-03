import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(SimpleEngineTests.allTests),
  ]
}
#endif
