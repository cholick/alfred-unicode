import AppKit

struct CLDR: Codable {
    struct Item: Codable {
        let arg: String
        let icon: [String: String]
    }
    let items: [Item]
}

let size = CGSize(width: 64, height: 64)
let attrs: [NSAttributedString.Key: Any] = [.font: NSFont.systemFont(ofSize: 52)]

let jsonData = try! Data(contentsOf: URL(filePath: "tmp/cldr.json"))
let parsed = try! JSONDecoder().decode(CLDR.self, from: jsonData)

for item in parsed.items {
    let str = NSAttributedString(string: item.arg, attributes: attrs)
    let image = NSImage(size: size, flipped: false) { _ in
        str.draw(at: CGPoint(
            x: (size.width - str.size().width) / 2,
            y: (size.height - str.size().height) / 2
        ))
        return true
    }
    
    guard let tiff = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiff),
          let png = bitmap.representation(using: .png, properties: [:]),
          let iconPath = item.icon["path"]
    else {
        fatalError("Issue with: \(item.arg)")
    }

    try! png.write(to: URL(filePath: "tmp/" + iconPath))

}

print("Wrote \(parsed.items.count) icons")
