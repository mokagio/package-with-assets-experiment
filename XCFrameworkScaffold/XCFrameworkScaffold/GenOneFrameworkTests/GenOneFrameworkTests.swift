import Testing
@testable import GenOneFramework

struct `Integration Tests` {

    @Test func `dummy`() {
        #expect(GenOneFrameworkDummy().dummy() == 42)
    }

    // For this to work, the GenOne library from the Swift package
    // needs to be a dependency of the test target, too.
    @Test func `method wrapped from Swift package`() throws {
        #expect(try SwiftPackageWrapper.genOneCount() == 151)
    }
}
