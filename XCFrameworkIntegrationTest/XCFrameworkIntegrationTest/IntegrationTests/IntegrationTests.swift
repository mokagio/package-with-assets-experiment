import Testing
import GenOne

@Test func example() async throws {
    #expect(1 == 2 - 1)
}

@Test func `Method from XCFramework->GenOne works`() throws {
    #expect(try loadGenOne().count == 151)
}

@Test func `HTMLParser dependency works in XCFramework`() {
    let html = "<p>Hello, <strong>world</strong>!</p>"
    #expect(getRootNodeName(htmlString: html) == "p")
}
