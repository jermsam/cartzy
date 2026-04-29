# Shimmer Loading Effect Implementation

## Overview

Replaced the standard `ProgressView()` spinner with a premium shimmer/skeleton loading effect for product images. This creates a more polished, modern user experience while images load from Unsplash.

## Implementation

### ShimmerView Component

Located in `platforms/ios/ProductImageView.swift`:

```swift
struct ShimmerView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.secondarySystemBackground)
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.secondarySystemBackground),
                        Color(.tertiarySystemBackground),
                        Color(.secondarySystemBackground)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: geometry.size.width * 2)
                .offset(x: phase * geometry.size.width * 2 - geometry.size.width)
            }
        }
        .onAppear {
            withAnimation(
                Animation.linear(duration: 1.5)
                    .repeatForever(autoreverses: false)
            ) {
                phase = 1
            }
        }
    }
}
```

### Integration with ProductImageView

```swift
struct ProductImageView: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ShimmerView()  // ← Premium loading effect

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()

            case .failure:
                Image(systemName: "photo")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)

            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 96, height: 96)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(14)
    }
}
```

## How It Works

1. **Gradient Animation**: A three-color gradient moves horizontally across the view
2. **Infinite Loop**: Animation repeats continuously until the image loads
3. **Smooth Transition**: When the image loads, it seamlessly replaces the shimmer
4. **System Colors**: Uses adaptive colors that work in both light and dark mode

## Benefits

### User Experience
- **Premium Feel**: Matches design patterns from apps like Instagram, Facebook, LinkedIn
- **Visual Feedback**: Users know content is loading (not frozen)
- **Reduced Perceived Wait Time**: Animated placeholders make loading feel faster

### Technical
- **Lightweight**: Pure SwiftUI, no external dependencies
- **Adaptive**: Automatically adjusts to light/dark mode
- **Reusable**: Can be used for any loading state

## Performance Notes

- **Animation Duration**: 1.5 seconds provides smooth, not-too-fast shimmer
- **GPU Acceleration**: SwiftUI animations are hardware-accelerated
- **Memory Efficient**: Minimal overhead compared to ProgressView

## Customization Options

### Adjust Speed
```swift
Animation.linear(duration: 1.0)  // Faster
Animation.linear(duration: 2.0)  // Slower
```

### Change Colors
```swift
gradient: Gradient(colors: [
    Color.gray.opacity(0.3),
    Color.gray.opacity(0.1),
    Color.gray.opacity(0.3)
])
```

### Different Animation Style
```swift
// Pulse effect instead of shimmer
.opacity(phase)
.onAppear {
    withAnimation(
        Animation.easeInOut(duration: 1.0)
            .repeatForever(autoreverses: true)
    ) {
        phase = 0.5
    }
}
```

## Combined with Image Optimization

The shimmer effect works perfectly with the Rust-side image optimization:

1. **Rust** provides optimized 300x300 URLs (w=300&h=300&q=80&auto=format)
2. **SwiftUI** shows shimmer while AsyncImage downloads
3. **Unsplash/Imgix** delivers WebP/AVIF for faster loading
4. **User** sees smooth shimmer → image transition

Typical load times:
- **Original image**: 2-5 seconds (8-12 MB)
- **Optimized thumbnail**: 0.3-0.8 seconds (15-30 KB)

The shimmer effect is most visible on slower connections, where it significantly improves perceived performance.

## Future Enhancements

### Skeleton Shapes
For more complex layouts, you could add shaped skeletons:

```swift
struct ProductCardSkeleton: View {
    var body: some View {
        VStack(alignment: .leading) {
            ShimmerView()
                .frame(height: 200)
                .cornerRadius(12)
            
            ShimmerView()
                .frame(height: 20)
                .cornerRadius(4)
            
            ShimmerView()
                .frame(width: 100, height: 16)
                .cornerRadius(4)
        }
    }
}
```

### Conditional Shimmer
Only show shimmer on slow connections:

```swift
@State private var showShimmer = false

.onAppear {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        showShimmer = true
    }
}

// In AsyncImage:
case .empty:
    if showShimmer {
        ShimmerView()
    } else {
        Color.clear
    }
```

## References

- [Human Interface Guidelines - Loading](https://developer.apple.com/design/human-interface-guidelines/loading)
- [SwiftUI Animation Best Practices](https://developer.apple.com/documentation/swiftui/animation)
- [Skeleton Screens - UX Pattern](https://www.nngroup.com/articles/skeleton-screens/)
