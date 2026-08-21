import AppKit
import Foundation

let arguments = CommandLine.arguments

guard arguments.count >= 4 else {
    fputs("usage: watermark-image <input> <output> <watermark-png> [max-pixels] [--pattern]\n", stderr)
    exit(1)
}

let inputURL = URL(fileURLWithPath: arguments[1])
let outputURL = URL(fileURLWithPath: arguments[2])
let logoURL = URL(fileURLWithPath: arguments[3])
let extraArguments = Array(arguments.dropFirst(4))
let maxPixels = CGFloat(extraArguments.compactMap { Int($0) }.first ?? 1800)
let usesPattern = extraArguments.contains("--pattern")

guard let source = NSImage(contentsOf: inputURL),
      let logo = NSImage(contentsOf: logoURL),
      source.size.width > 0,
      source.size.height > 0 else {
    fputs("Unable to read the source image or logo.\n", stderr)
    exit(1)
}

let sourcePixels = source.representations.compactMap { $0 as? NSBitmapImageRep }.first
let sourceSize = sourcePixels.map { NSSize(width: $0.pixelsWide, height: $0.pixelsHigh) } ?? source.size
let scale = min(1, maxPixels / max(sourceSize.width, sourceSize.height))
let canvasSize = NSSize(width: floor(sourceSize.width * scale), height: floor(sourceSize.height * scale))
guard let canvas = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: Int(canvasSize.width),
    pixelsHigh: Int(canvasSize.height),
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bitmapFormat: [],
    bytesPerRow: 0,
    bitsPerPixel: 0
), let context = NSGraphicsContext(bitmapImageRep: canvas) else {
    fputs("Unable to prepare the output image.\n", stderr)
    exit(1)
}

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = context
source.draw(in: NSRect(origin: .zero, size: canvasSize), from: NSRect(origin: .zero, size: sourceSize), operation: .copy, fraction: 1)

if usesPattern {
    // Offset alternating rows so a useful crop cannot avoid the copyright mark.
    let markSize = min(max(250, canvasSize.width * 0.24), 420)
    let horizontalStep = markSize * 0.98
    let verticalStep = markSize * 0.9
    var row = 0
    var y = -markSize * 0.25

    while y < canvasSize.height {
        var x = row.isMultiple(of: 2) ? -markSize * 0.2 : -markSize * 0.7
        while x < canvasSize.width {
            let markRect = NSRect(x: x, y: y, width: markSize, height: markSize)
            logo.draw(in: markRect, from: NSRect(origin: .zero, size: logo.size), operation: .sourceOver, fraction: 1)
            logo.draw(in: markRect, from: NSRect(origin: .zero, size: logo.size), operation: .sourceOver, fraction: 1)
            x += horizontalStep
        }
        y += verticalStep
        row += 1
    }
} else {
    let inset = max(18, canvasSize.width * 0.022)
    let logoHeight = min(max(34, canvasSize.height * 0.09), 112)
    let logoWidth = logoHeight * (logo.size.width / logo.size.height)
    let textSize = min(max(12, canvasSize.width * 0.018), 26)
    let notice = "© 2026 Trace Downey. All rights reserved."
    let paragraph = NSMutableParagraphStyle()
    paragraph.lineBreakMode = .byTruncatingTail
    let textAttributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: textSize, weight: .semibold),
        .foregroundColor: NSColor(calibratedWhite: 0.1, alpha: 1),
        .paragraphStyle: paragraph
    ]
    let textSizeMeasured = (notice as NSString).size(withAttributes: textAttributes)
    let badgePaddingX = max(12, canvasSize.width * 0.012)
    let badgePaddingY = max(8, canvasSize.height * 0.011)
    let contentHeight = max(logoHeight, textSizeMeasured.height)
    let badgeWidth = logoWidth + badgePaddingX + textSizeMeasured.width + badgePaddingX * 2
    let badgeHeight = contentHeight + badgePaddingY * 2
    let badgeRect = NSRect(
        x: canvasSize.width - inset - badgeWidth,
        y: inset,
        width: badgeWidth,
        height: badgeHeight
    )

    NSColor(calibratedWhite: 1, alpha: 0.88).setFill()
    NSBezierPath(roundedRect: badgeRect, xRadius: badgeHeight * 0.2, yRadius: badgeHeight * 0.2).fill()
    NSColor(calibratedWhite: 0.12, alpha: 0.18).setStroke()
    let badgeBorder = NSBezierPath(roundedRect: badgeRect, xRadius: badgeHeight * 0.2, yRadius: badgeHeight * 0.2)
    badgeBorder.lineWidth = 1
    badgeBorder.stroke()

    let logoRect = NSRect(
        x: badgeRect.minX + badgePaddingX,
        y: badgeRect.midY - logoHeight / 2,
        width: logoWidth,
        height: logoHeight
    )
    logo.draw(in: logoRect, from: NSRect(origin: .zero, size: logo.size), operation: .sourceOver, fraction: 0.9)

    let textRect = NSRect(
        x: logoRect.maxX + badgePaddingX,
        y: badgeRect.midY - textSizeMeasured.height / 2,
        width: textSizeMeasured.width,
        height: textSizeMeasured.height
    )
    (notice as NSString).draw(in: textRect, withAttributes: textAttributes)
}
NSGraphicsContext.restoreGraphicsState()

let outputType: NSBitmapImageRep.FileType = outputURL.pathExtension.lowercased() == "png" ? .png : .jpeg
let outputProperties: [NSBitmapImageRep.PropertyKey: Any] = outputType == .jpeg ? [.compressionFactor: 0.86] : [:]

guard let imageData = canvas.representation(using: outputType, properties: outputProperties) else {
    fputs("Unable to encode watermarked image.\n", stderr)
    exit(1)
}

try FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true)
try imageData.write(to: outputURL)
