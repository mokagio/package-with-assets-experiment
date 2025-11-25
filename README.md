Experiment in distributing a Swift package that consumes static files that are not tracked in the source.

- [x] Build a demo Swift package that reads a JSON from file system
- [x] Add a test to verify the behavior
- [ ] Add a build plugin that downloads the JSON from a remote source & remove JSON from source

## Current Status

The `curl` command that runs in the plugin during `swift build` fails to fetch from the given URL with `curl: (6) Could not resolve host:`.

This is, unfortunately, the expected behavior.

From [Meet Swift Package Plugins (WWDC2022)](https://developer.apple.com/videos/play/wwdc2022/110359/?time=388):

> A plugin runs in a sandbox that prevents network access and that only allows writing to a few places in the file system, such as the build outputs directory.
> But command plugins can ask for permission to also modify files in the package source directory.
> If the user approves, the sandbox is configured to allow writing to those locations.

The [`PluginCapability`](https://developer.apple.com/documentation/packagedescription/target/plugincapability-swift.enum) `enum` also clearly shows that build plugins cannot accept additional permission:

> **Creating a Plugin Capability**
>
> `static func buildTool() -> Target.PluginCapability`
> The plug-in is a build tool.
>
> `case command(intent: PluginCommandIntent, permissions: [PluginPermission])`
> Specifies that the plug-in provides a user command capability.

The limitation is known to the community and there is at least [one pitch](https://forums.swift.org/t/pitch-swiftpm-plugins-explicit-buildtool-sandbox-permissions/68963/10) for adding a networking permission to build tool plugins.
