//
//  WebViewContainer.swift
//  Outdoor Prep Kit
//
//  Created by John Hawley on 1/12/24.
//

import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    var item : Item

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: getURL()) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func getURL() -> String {
        var urlText = "https://www.rei.com/search?q="+(item.brand ?? "")+"+"+(item.model ?? "")
        return urlText
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewContainer

        init(_ parent: WebViewContainer) {
            self.parent = parent
        }

        // Implement WKNavigationDelegate methods if needed
    }
}

