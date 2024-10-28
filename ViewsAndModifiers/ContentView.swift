//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by David Ferreira on 27/10/24.
//

import SwiftUI

// View composition
struct CapsuleText: View {
    var text: String
    var color: Color?
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .foregroundStyle(color ?? .white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

// Custom modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}



// Custom modifer with property
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.footnote)
                .foregroundStyle(.white)
                .padding(5)
                .background(.ultraThinMaterial)
        }
    }
}

// Extensions on View
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

extension View {
    func watermark(text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

/// Wonder when it’s better to add a custom view modifier versus just adding a new method to View, 
/// and really it comes down to one main reason: custom view modifiers can have their own stored
/// properties, whereas extensions to View cannot.


struct ContentView: View {
    var body: some View {
        VStack {
            // View Composition
            CapsuleText(text: "Hello, world!")
            CapsuleText(text: "Hello, world!", color: .yellow)
            
            // Custom modifier
            Text("Hello world!")
                .modifier(Title())
            
            // Custom modifier with extension
            Text("Hello world!")
                .titleStyle()
            
            // Custom modifier with extension with param
            Color.blue
                .frame(width: 200, height: 200)
                .watermark(text: "Watermark!")

        }
    }
}

#Preview {
    ContentView()
}
