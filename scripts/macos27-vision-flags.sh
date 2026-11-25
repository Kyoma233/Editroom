#!/bin/zsh
# Prints the extra Swift flags this machine's macOS SDK needs, on one line (empty when there are none).
#
# SceneTags.describe() asks Apple's on-device model to describe video frames, which needs the image-aware
# Foundation Models API that shipped in the macOS 27 SDK. Built with an older SDK the call can't compile at
# all, so the source keeps it behind EDITROOM_VISION_CAPTIONS and this script turns that on only when the
# installed SDK actually has the API. Everything else in the app builds with any Xcode 26 or later.
set -euo pipefail

sdk=$(xcrun --sdk macosx --show-sdk-path)
framework="$sdk/System/Library/Frameworks/FoundationModels.framework"

if grep -rqs "capabilities" "$framework" && grep -rqs "Attachment" "$framework"; then
  print -r -- "-D EDITROOM_VISION_CAPTIONS"
fi
