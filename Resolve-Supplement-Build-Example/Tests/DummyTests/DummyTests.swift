import Testing
@testable import GenOne

@Test func `gen one loads 151 results from JSON`() throws {
    #expect(try loadGenOne().count == 151)
}
