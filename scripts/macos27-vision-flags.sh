#!/bin/zsh
# Prints the extra Swift flags this machine's macOS SDK needs, on one line (empty when there are none).
#
# SceneTags.describe() asks Apple's on-device model to describe video frames, which needs the image-aware
# Foundation Models API that shipped in the macOS 27 SDK. Built with an older SDK that code cannot compile,
# so the source keeps it behind EDITROOM_VISION_CAPTIONS and this script turns the flag on only when the
# installed SDK really has the API. Everything else in the app builds with any Xcode 26 or later.
#
# The check type-checks a small probe rather than grepping headers: SDK frameworks match those words in
# unrelated places, and only the compiler knows for sure.
set -euo pipefail

probe_dir=$(mktemp -d)
trap 'rm -rf "$probe_dir"' EXIT

cat > "$probe_dir/probe.swift" <<'SWIFT'
import CoreGraphics
import FoundationModels

@available(macOS 27, *)
func probe(_ model: SystemLanguageModel, _ image: CGImage) async throws {
    guard model.capabilities.contains(.vision) else { return }
    let session = LanguageModelSession(instructions: "probe")
    _ = try await session.respond(to: Prompt { "probe"; Attachment(image) })
}
SWIFT

if xcrun --sdk macosx swiftc -typecheck -swift-version 5 "$probe_dir/probe.swift" >/dev/null 2>&1; then
  print -r -- "-D EDITROOM_VISION_CAPTIONS"
fi
