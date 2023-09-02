//
// DefaultSDKHeadersProvider.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation
import UIKit

/// Defines default set of SDK headers with common data.
public enum DefaultSDKHeadersProvider {

    /// Static headers storage tied up to the application lifecycle.
    public static var headers: [AnyHashable: Any] {
        [
            SDKHeaderKey.sdkName.rawValue: "iOS",
            SDKHeaderKey.sdkVersion.rawValue: "1.0.0",
            SDKHeaderKey.systemVersion.rawValue: UIDevice.current.systemVersion,
            SDKHeaderKey.deviceIdiom.rawValue: UIDevice.current.model,
            SDKHeaderKey.apiVersion.rawValue: "2.7"
        ]
    }
}
