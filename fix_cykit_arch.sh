#!/bin/bash

echo "🧹 清理旧的 SwiftPM 构建缓存..."
rm -rf .build
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/Developer/Xcode/DerivedData

echo "🔧 重新解析依赖..."
xcodebuild -resolvePackageDependencies

echo "🏗️ 重新构建 CYKit (arm64, iOS Simulator)..."
xcodebuild -scheme CYKit \
    -destination 'generic/platform=iOS Simulator' \
    -configuration Debug \
    build

echo "✅ 编译完成，CYKit 已重新生成 arm64 架构版本"
