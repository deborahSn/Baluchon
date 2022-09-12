//
//  URLProtocolFake.swift
//  BaluchonTests
//
//  Created by Déborah Suon on 09/01/2022.
//

import Foundation


class URLProtocolFake: URLProtocol {
    static var fakeURLs = [URL?: (data: Data?, response: HTTPURLResponse?, error: Error?)]()

    override class func canInit(with request: URLRequest) -> Bool { true }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let url = request.url {
            if let (data, response, error) = URLProtocolFake.fakeURLs[url] {
                if let responseStrong = response {
                    client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
                }
                if let dataStrong = data {
                    client?.urlProtocol(self, didLoad: dataStrong)
                }
                if let errorStrong = error {
                    client?.urlProtocol(self, didFailWithError: errorStrong)
                }
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}

class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    
    override func cancel() {}
}
