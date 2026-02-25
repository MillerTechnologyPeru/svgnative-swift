import Testing
@testable import SVGNative

@Test func testIntrinsicSize() async throws {
    // Test SVG with explicit width and height
    let svgWithSize = """
    <svg width="100" height="200" xmlns="http://www.w3.org/2000/svg">
        <rect width="100" height="200" fill="red"/>
    </svg>
    """
    
    guard let svgData = SVGNative(svgWithSize) else {
        Issue.record()
        return
    }
    
    let size = svgData.intrinsicSize
    #expect(size != nil)
    #expect(size?.width == 100)
    #expect(size?.height == 200)
}
