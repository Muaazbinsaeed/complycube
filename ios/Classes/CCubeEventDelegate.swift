/**
 * Copyright (C) 2019 Jerry Wang, Jason C.H
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 */

import Foundation
import Flutter

class CCubeEventDelegate: FlutterStreamHandler {
    static var _sink: FlutterEventSink?

    static func fireEvent(_ newState: Any?, errorMessage: String? = nil) {
        guard let sink = _sink else {
            return
        }

        if let errorMsg = errorMessage {
            sink(FlutterError(code: "\(newState)",
                              message: errorMsg,
                              details: nil))
            return
        }

        sink(newState)
    }

    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        CCubeEventDelegate._sink = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        CCubeEventDelegate._sink = nil
        return nil
    }
}
