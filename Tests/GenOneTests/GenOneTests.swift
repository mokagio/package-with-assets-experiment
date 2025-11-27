import Testing
@testable import GenOne

@Test func `gen one loads 151 results from JSON`() throws {
    #expect(try loadGenOne().count == 151)
}

@Test func `get root node name returns root node name`() {
    let html = "<p>Hello, <strong>world</strong>!</p>"
    #expect(getRootNodeName(htmlString: html) == "p")
}
