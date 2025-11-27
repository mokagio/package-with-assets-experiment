import Testing
import GenOne

@Test func example() async throws {
    #expect(1 == 2 - 1)
}

@Test func `Method from XCFramework->GenOne works`() throws {
    #expect(try loadGenOne().count == 151)
}
