// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "svgnative",
    platforms: [
      .macOS(.v10_13),
      .iOS(.v12),
      .tvOS(.v12),
      .watchOS(.v4)
    ],
    products: [
        .library(
            name: "SVGNative",
            targets: ["SVGNative"]
        ),
    ],
    targets: [
        .target(
            name: "SVGNative",
            dependencies: ["CSVGNative"]
        ),
        .target(
            name: "CSVGNative",
            dependencies: ["boost", "cpp-base64"],
            path: "svg-native-viewer",
            exclude: ["svgnative/example",
                      "svgnative/src/win",
                      "svgnative/src/xml/ExpatXMLParser.cpp",
                      "svgnative/src/xml/RapidXMLParser.cpp",
                      "svgnative/src/ports/cairo",
                      "svgnative/src/ports/d2d",
                      "svgnative/src/ports/gdiplus",
                      "svgnative/src/ports/skia",
                      "svgnative/src/ports/string",
                      "svgnative/include/svgnative/ports/cairo",
                      "svgnative/include/svgnative/ports/d2d",
                      "svgnative/include/svgnative/ports/gdiplus",
                      "svgnative/include/svgnative/ports/skia",
                      "svgnative/include/svgnative/ports/string"],
            sources: ["svgnative/src"],
            publicHeadersPath: "include/CSVGNative",
            cSettings: [.define("USE_CG", to: "1"),
                        .define("BOOST_VARIANT_DETAIL_NO_SUBSTITUTE", to: "1"),
                        .headerSearchPath("svgnative/src"),
                        .headerSearchPath("svgnative/include")],
            linkerSettings: [
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreFoundation"),
                .linkedLibrary("xml2")
            ]
        ),
        .target(
          name: "boost",
          dependencies: [],
          path: "third_party",
          sources: ["dummy.cpp"],
          publicHeadersPath: "boost_variant_property_tree",
          cSettings: [.define("BOOST_VARIANT_DETAIL_NO_SUBSTITUTE", to: "1")]
        ),
        .target(
          name: "cpp-base64",
          dependencies: [],
          path: "third_party",
          sources: ["cpp-base64/base64.h", "cpp-base64/base64.cpp"],
          publicHeadersPath: "cpp-base64"
        ),
        .testTarget(
            name: "SVGNativeTests",
            dependencies: ["SVGNative"]
        )
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
