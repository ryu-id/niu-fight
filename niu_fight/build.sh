#!/bin/bash
# =============================================
# NIU-FIGHT - Automated Android Build Script
# =============================================
# Usage: ./build.sh
# Requires: Godot 4.3 + Android Export Template installed

set -e

echo "========================================"
echo "   NIU-FIGHT Android Build Script"
echo "========================================"

# Check if Godot exists
if ! command -v godot &> /dev/null; then
    echo "ERROR: Godot not found in PATH"
    echo "Please install Godot 4.3 and add it to PATH"
    exit 1
fi

echo "[1/5] Checking Godot version..."
godot --version

echo "[2/5] Creating build directory..."
mkdir -p build

echo "[3/5] Exporting Android APK (Debug)..."
godot --headless --export-debug "Android" build/Niu-Fight-debug.apk

echo "[4/5] Exporting Android APK (Release)..."
godot --headless --export-release "Android" build/Niu-Fight-release.apk

echo "[5/5] Build completed!"
echo ""
echo "APK files created:"
ls -lh build/*.apk

echo ""
echo "========================================"
echo "Build finished successfully!"
echo "========================================"