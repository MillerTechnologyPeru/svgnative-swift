// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "svgnative",
    platforms: [
      .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "svgnative",
            targets: ["svgnative", "boost", "cpp-base64"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "svgnative",
            dependencies: ["boost", "cpp-base64"],
            path: "svg-native-viewer",
            exclude: ["svgnative/src/win",
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
            publicHeadersPath: "svgnative/include",
            cSettings: [.define("USE_CG", to: "1"),
                        .define("BOOST_VARIANT_DETAIL_NO_SUBSTITUTE", to: "1"),
                        .headerSearchPath("svgnative/src")]
        ),
        .target(
          name: "boost",
          dependencies: [],
          path: "third_party",
          sources: ["boost_variant_property_tree", "dummy.cpp"],
          publicHeadersPath: "boost_variant_property_tree",
          cSettings: [.define("BOOST_VARIANT_DETAIL_NO_SUBSTITUTE", to: "1")]
        ),
        .target(
          name: "cpp-base64",
          dependencies: [],
          path: "third_party",
          sources: ["cpp-base64/base64.h", "cpp-base64/base64.cpp"],
          publicHeadersPath: "cpp-base64"
        )
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
