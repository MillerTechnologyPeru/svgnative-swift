//
//  SVGNative.swift
//  svgnative
//
//  Created by Alsey Coleman Miller on 2/24/26.
//

import CSVGNative

public struct SVGNative: ~Copyable {
    
    internal let handle: svg_native_t
    
    init(
        document: String,
        renderer: svg_native_renderer_type_t = SVG_RENDERER_UNKNOWN
    ) {
        self.handle = svg_native_create(renderer, document)
    }
    
    deinit {
        svg_native_destroy(handle)
    }
    
    var width: Float? {
        svg_native_canvas_width(handle)
    }
    
    var height: Float? {
        svg_native_canvas_height(handle)
    }
    
    func render() {
        svg_native_render(handle)
    }
}
