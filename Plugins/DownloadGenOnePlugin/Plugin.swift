import Foundation
import PackagePlugin

@main
struct DownloadGenOnePlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        // TODO: Implement download logic for gen_one.json

        let outputDirectory = context.pluginWorkDirectoryURL
        let outputPath = outputDirectory.appending(component: "gen_one.json")

        return [
            .prebuildCommand(
                displayName: "Download Gen One Pokemon Data",
                executable: URL(fileURLWithPath: "/usr/bin/curl"),
                arguments: [
                    "--silent",
                    "--show-error",
                    "--output",
                    outputPath.path(),
                    "https://pokeapi.co/api/v2/pokemon?limit=151"
                ],
                outputFilesDirectory: outputDirectory
            )
        ]
    }
}
