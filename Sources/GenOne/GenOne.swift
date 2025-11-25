import Foundation

struct Response: Decodable {
    let results: [Resource]
}

public struct Resource: Decodable {
    public let name: String
    public let url: URL
}

public func loadGenOne() throws -> [Resource] {
    // Convoluted logic for this example, but lifted from
    // GutenbergKit which we're building toward.
    guard let assetsURL = Bundle.module.url(
        forResource: "Assets",
        withExtension: nil
    ) else {
        throw NSError(domain: "GenOne", code: 1)
    }

    let assetsDirectory = assetsURL
        .appendingPathComponent("Subfolder")

    let files = try FileManager
        .default
        .contentsOfDirectory(
            at: assetsDirectory,
            includingPropertiesForKeys: nil
        )

    guard let genOne = files.first(
        where: {
            $0.lastPathComponent.hasPrefix("gen_")
            && $0.lastPathComponent.hasSuffix(".json")
        }
    ) else {
        throw NSError(domain: "GenOne", code: 2)
    }

    let data = try Data(contentsOf: genOne)
    let response = try JSONDecoder()
        .decode(Response.self, from: data)

    return response.results
}
