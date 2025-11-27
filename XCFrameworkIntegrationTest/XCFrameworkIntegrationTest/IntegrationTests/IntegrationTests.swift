import Testing
import GenOneFramework

@Test func example() async throws {
    #expect(1 == 2 - 1)
}

@Test func `Method directly from XCFramework works`() {
    #expect(GenOneFrameworkDummy().dummy() == 42)
}
