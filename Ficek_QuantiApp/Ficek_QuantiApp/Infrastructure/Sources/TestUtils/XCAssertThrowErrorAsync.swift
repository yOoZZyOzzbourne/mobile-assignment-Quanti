import Foundation
import XCTest

public func XCTAssertThrowsErrorAsync<T>(
  _ expression: @autoclosure () async throws -> T,
  _ message: @autoclosure () -> String = "This method should fail",
  file: StaticString = #filePath,
  line: UInt = #line
) async  {
  do {
    let _ = try await expression()
    XCTFail(message(), file: file, line: line)
  } catch { }
}

public func XCTAssertThrowsErrorAsyncErrorComparable<T, R>(
  _ expression: @autoclosure () async throws -> T,
  _ errorThrown: @autoclosure () -> R,
  _ message: @autoclosure () -> String = "This method should fail",
  file: StaticString = #filePath,
  line: UInt = #line
) async where R: Equatable, R: Error  {
  do {
    let _ = try await expression()
    XCTFail(message(), file: file, line: line)
  } catch {
    XCTAssertEqual(error as? R, errorThrown())
  }
}
