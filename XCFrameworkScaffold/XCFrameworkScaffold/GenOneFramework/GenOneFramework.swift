import GenOne

public struct SwiftPackageWrapper {

    public static func genOneCount() throws -> Int {
        try loadGenOne().count
    }
}
public struct GenOneFrameworkDummy {

    public init() {}

    public func dummy() -> Int { 42 }
}
