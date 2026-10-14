#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-v0.7.0}"
PRIVATE_REPO="englutandula/LutaPDF"
PUBLIC_REPO="englutandula/LutaPDF-releases"
DEST_DIR="dist/$TAG"

echo "==> Downloading $TAG release from $PRIVATE_REPO..."
mkdir -p "$DEST_DIR"
~/.local/bin/gh release download "$TAG" --repo "$PRIVATE_REPO" --dir "$DEST_DIR" --clobber

echo "==> Files downloaded:"
ls -la "$DEST_DIR"

echo "==> Creating release on $PUBLIC_REPO..."
~/.local/bin/gh release create "$TAG" "$DEST_DIR"/* \
  --repo "$PUBLIC_REPO" \
  --title "LutaPDF $TAG" \
  --generate-notes \
  --latest

echo "==> Done! Release published to https://github.com/$PUBLIC_REPO/releases/tag/$TAG"
