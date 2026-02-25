import Testing
@testable import SVGNative

@Test func testIntrinsicSize() async throws {
    // Test SVG with explicit width and height
    let svgWithSize = """
    <svg width="100" height="200" xmlns="http://www.w3.org/2000/svg">
        <rect width="100" height="200" fill="red"/>
    </svg>
    """
    
    let svgData = try #require(SVGData(svgWithSize))
    
    let size = svgData.intrinsicSize
    #expect(size != nil)
    #expect(size?.width == 100)
    #expect(size?.height == 200)
}
