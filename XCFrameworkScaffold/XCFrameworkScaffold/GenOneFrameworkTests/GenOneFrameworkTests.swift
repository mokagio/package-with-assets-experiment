import Testing
@testable import GenOneFramework

struct `Integration Tests` {

    @Test func `dummy`() {
        #expect(GenOneFrameworkDummy().dummy() == 42)
    }
}
