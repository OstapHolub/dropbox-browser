//
// MockingURLProtocol.swift
// APIClient
//

// Created by Ostap Holub on 02.09.2023.
//

import Foundation

/// Custom implementation fo `URLProtocol`. Provides mocked responses with `Data` or `Error`
/// using `MocksRegistry` as a source.
public class MockingURLProtocol: URLProtocol {

    public override class func canInit(with request: URLRequest) -> Bool {
        MocksRegistry.contains(request)
    }

    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    public override func startLoading() {
        guard let url = request.url,
              let response = MocksRegistry.response(for: request) else {
                  fatalError(
                    "No mock response for \(request.url!). This should never happen. Check " +
                    "the implementation of `canInit(with request: URLRequest) -> Bool`"
                  )
              }

        // Simulate response on a background thread.
        DispatchQueue.global(qos: .default).async {
            switch response {
            case let .success(data):

                // Simulate receiving an URLResponse. We need to do this
                // to let the client know the expected status code.
                let urlResponse = HTTPURLResponse(url: url, statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: [:])

                self.client?.urlProtocol(self, didReceive: urlResponse!, cacheStoragePolicy: .notAllowed)

                // Simulate received data.
                self.client?.urlProtocol(self, didLoad: data)

                // Finish loading (required).
                self.client?.urlProtocolDidFinishLoading(self)
            case let .failure(error):
                // Simulate error.
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }

    public override func stopLoading() { }
}
