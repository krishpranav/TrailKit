//
//  ExploreWebView.swift
//  TrailKit
//
//  Created by Krisna Pranav on 31/03/26.
//

import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    @Binding var title: String
    @Binding var isLoading: Bool
    @Binding var canGoBack: Bool
    @Binding var canGoForward: Bool
    var webView = WKWebView()

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewRepresentable

        init(_ parent: WebViewRepresentable) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            parent.title = webView.title ?? ""
            parent.canGoBack = webView.canGoBack
            parent.canGoForward = webView.canGoForward
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }
    }

    func goBack()    { webView.goBack() }
    func goForward() { webView.goForward() }
    func reload()    { webView.reload() }
}

struct ExploreWebView: View {
    @State private var urlInput = "https://www.alltrails.com"
    @State private var loadedURL = URL(string: "https://www.alltrails.com")!
    @State private var pageTitle = "Explore Trails"
    @State private var isLoading = false
    @State private var canGoBack = false
    @State private var canGoForward = false

    private let webViewRepresentable = WebViewRepresentable(
        url: URL(string: "https://www.alltrails.com")!,
        title: .constant(""),
        isLoading: .constant(false),
        canGoBack: .constant(false),
        canGoForward: .constant(false)
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack(spacing: 10) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                            .font(.footnote)

                        TextField("Search or enter URL", text: $urlInput)
                            .textContentType(.URL)
                            .keyboardType(.URL)
                            .autocorrectionDisabled()
                            .autocapitalization(.none)
                            .onSubmit { navigate() }

                        if !urlInput.isEmpty {
                            Button {
                                urlInput = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.secondary)
                                    .font(.footnote)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    Button("Go") { navigate() }
                        .fontWeight(.medium)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color(.systemBackground))
                .overlay(alignment: .bottom) {
                    Divider()
                }

                if isLoading {
                    ProgressView()
                        .progressViewStyle(.linear)
                        .transition(.opacity)
                }

                WebViewRepresentable(
                    url: loadedURL,
                    title: $pageTitle,
                    isLoading: $isLoading,
                    canGoBack: $canGoBack,
                    canGoForward: $canGoForward
                )
                .ignoresSafeArea(edges: .bottom)

            }
            .navigationTitle(pageTitle.isEmpty ? "Explore Trails" : pageTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        webViewRepresentable.goBack()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .disabled(!canGoBack)

                    Spacer()

                    Button {
                        webViewRepresentable.goForward()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .disabled(!canGoForward)

                    Spacer()

                    Button {
                        webViewRepresentable.reload()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
    }

    func navigate() {
        var raw = urlInput.trimmingCharacters(in: .whitespaces)

        if !raw.contains(".") || raw.contains(" ") {
            raw = "https://www.google.com/search?q=" + raw.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        } else if !raw.hasPrefix("http://") && !raw.hasPrefix("https://") {
            raw = "https://" + raw
        }

        if let url = URL(string: raw) {
            loadedURL = url
        }
    }
}
