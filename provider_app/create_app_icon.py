#!/usr/bin/env python3
"""
Create app icons with red, gold, green colors and black star
Generates all required iOS and Android icon sizes
"""

from PIL import Image, ImageDraw, ImageFont
import os
import math

def create_icon(size):
    """Create app icon with red, gold, green background and black star"""
    # Create image with transparent background
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Colors (Ghana flag inspired)
    red = (206, 17, 38)     # Ghana red
    gold = (252, 209, 22)   # Ghana gold  
    green = (0, 146, 70)    # Ghana green
    black = (0, 0, 0)       # Black star
    
    # Draw horizontal stripes
    stripe_height = size // 3
    
    # Red stripe (top)
    draw.rectangle([0, 0, size, stripe_height], fill=red)
    
    # Gold stripe (middle)  
    draw.rectangle([0, stripe_height, size, stripe_height * 2], fill=gold)
    
    # Green stripe (bottom)
    draw.rectangle([0, stripe_height * 2, size, size], fill=green)
    
    # Draw black star in center
    center_x = size // 2
    center_y = size // 2
    star_radius = size // 6
    
    # Create 5-point star
    star_points = []
    for i in range(10):
        angle = math.pi * 2 * i / 10 - math.pi / 2
        if i % 2 == 0:
            # Outer points
            x = center_x + star_radius * math.cos(angle)
            y = center_y + star_radius * math.sin(angle)
        else:
            # Inner points
            x = center_x + (star_radius * 0.4) * math.cos(angle)
            y = center_y + (star_radius * 0.4) * math.sin(angle)
        star_points.append((x, y))
    
    draw.polygon(star_points, fill=black)
    
    return img

def main():
    # iOS icon sizes
    ios_sizes = [
        (20, "Icon-App-20x20@1x.png"),
        (40, "Icon-App-20x20@2x.png"), 
        (60, "Icon-App-20x20@3x.png"),
        (29, "Icon-App-29x29@1x.png"),
        (58, "Icon-App-29x29@2x.png"),
        (87, "Icon-App-29x29@3x.png"),
        (40, "Icon-App-40x40@1x.png"),
        (80, "Icon-App-40x40@2x.png"),
        (120, "Icon-App-40x40@3x.png"),
        (120, "Icon-App-60x60@2x.png"),
        (180, "Icon-App-60x60@3x.png"),
        (76, "Icon-App-76x76@1x.png"),
        (152, "Icon-App-76x76@2x.png"),
        (167, "Icon-App-83.5x83.5@2x.png"),
        (1024, "Icon-App-1024x1024@1x.png")
    ]
    
    # Android icon sizes
    android_sizes = [
        (192, "ic_launcher.png"),           # xxxhdpi
        (144, "ic_launcher_144.png"),       # xxhdpi  
        (96, "ic_launcher_96.png"),         # xhdpi
        (72, "ic_launcher_72.png"),         # hdpi
        (48, "ic_launcher_48.png"),         # mdpi
        (36, "ic_launcher_36.png"),         # ldpi
    ]
    
    # Create iOS icons
    ios_dir = "ios/Runner/Assets.xcassets/AppIcon.appiconset"
    os.makedirs(ios_dir, exist_ok=True)
    
    print("Creating iOS app icons...")
    for size, filename in ios_sizes:
        icon = create_icon(size)
        icon.save(f"{ios_dir}/{filename}")
        print(f"Created {filename} ({size}x{size})")
    
    # Create Android icons
    android_dirs = [
        "android/app/src/main/res/mipmap-xxxhdpi",
        "android/app/src/main/res/mipmap-xxhdpi", 
        "android/app/src/main/res/mipmap-xhdpi",
        "android/app/src/main/res/mipmap-hdpi",
        "android/app/src/main/res/mipmap-mdpi",
        "android/app/src/main/res/mipmap-ldpi"
    ]
    
    for i, (size, filename) in enumerate(android_sizes):
        android_dir = android_dirs[i]
        os.makedirs(android_dir, exist_ok=True)
        
        icon = create_icon(size)
        icon.save(f"{android_dir}/ic_launcher.png")
        print(f"Created Android icon {size}x{size} in {android_dir}")

if __name__ == "__main__":
    main()
    print("\n✅ All app icons created successfully!")
    print("Icons feature Ghana flag colors (red, gold, green) with black star")