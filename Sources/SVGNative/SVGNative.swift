//
//  SVGNative.swift
//  svgnative
//
//  Created by Alsey Coleman Miller on 2/24/26.
//

internal import CSVGNative
#if canImport(CoreGraphics)
import CoreGraphics
#endif

public struct SVGNative: ~Copyable {
    
    internal let handle: OpaquePointer
    
    public init?(_ document: String) {
        let rendererType: svg_native_renderer_type_t
        #if canImport(CoreGraphics)
        rendererType = SVG_RENDERER_CG
        #endif
        guard let handle = svg_native_create(rendererType, document) else {
            return nil
        }
        self.handle = handle
    }
    
    deinit {
        svg_native_destroy(handle)
    }
    
    public var intrinsicSize: (width: Float, height: Float)? {
        let width = svg_native_canvas_width(handle)
        let height = svg_native_canvas_height(handle)
        guard !width.isNaN, !height.isNaN else { return nil }
        return (width, height)
    }
    
    public func render() {
        svg_native_render(handle)
    }
    
    #if canImport(CoreGraphics)
    public func setRenderer(_ context: CGContext) {
        svg_native_set_renderer(handle, Unmanaged.passUnretained(context).toOpaque())
    }
    #endif
}
