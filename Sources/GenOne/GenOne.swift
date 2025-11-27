import Foundation
import HTMLParser

struct Response: Decodable {
    let results: [Resource]
}

public struct Resource: Decodable {
    public let name: String
    public let url: URL
}

// Private class for bundle lookup (needed for Bundle(for:))
private class BundleLocator {}

public func getRootNodeName(htmlString: String) -> String? {
    let parser = HTMLParser()
    let rootNode = parser.parse(htmlString)
    return rootNode.children.first?.name
}

public func loadGenOne() throws -> [Resource] {
    // Convoluted logic for this example, but lifted from
    // GutenbergKit which we're building toward.

    // Try to find the resource bundle - works for both SPM and XCFramework
    let bundle: Bundle = {
        // First try Bundle.module (works for SPM)
        if let url = Bundle.module.resourceURL?.appendingPathComponent("GenOne_GenOne.bundle"),
           let bundle = Bundle(url: url) {
            return bundle
        }
        // Fallback for XCFramework: bundle is nested in the framework
        if let url = Bundle(for: BundleLocator.self).resourceURL?.appendingPathComponent("GenOne_GenOne.bundle"),
           let bundle = Bundle(url: url) {
            return bundle
        }
        // Last resort: use Bundle.module
        return Bundle.module
    }()

    guard let assetsURL = bundle.url(
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
