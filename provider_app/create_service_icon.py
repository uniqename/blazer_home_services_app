#!/usr/bin/env python3
"""
Create service-focused app icon for HomeLinkGH Provider
Shows tools and service icons representing home services
"""

from PIL import Image, ImageDraw, ImageFont
import os
import math

def create_service_icon(size):
    """Create app icon focused on home services with tools and service symbols"""
    # Create image with gradient background
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    # Colors - Professional service theme
    primary_blue = (41, 98, 255)      # Professional blue
    accent_orange = (255, 152, 0)     # Service orange
    light_gray = (248, 249, 250)     # Light background
    dark_gray = (52, 58, 64)         # Dark text/icons
    green = (40, 167, 69)            # Success green
    
    # Create circular background with gradient effect
    center = size // 2
    radius = size // 2 - 2
    
    # Draw circular background
    draw.ellipse([2, 2, size-2, size-2], fill=primary_blue)
    
    # Draw inner circle for contrast
    inner_radius = radius - size//10
    inner_offset = size//10
    draw.ellipse([inner_offset, inner_offset, size-inner_offset, size-inner_offset], 
                 fill=light_gray)
    
    # Icon elements - tools and service symbols
    icon_size = size // 8
    
    # Draw hammer (top left quadrant)
    hammer_x = center - size//4
    hammer_y = center - size//4
    # Hammer handle
    draw.rectangle([hammer_x-icon_size//4, hammer_y-icon_size//2, 
                   hammer_x+icon_size//4, hammer_y+icon_size//2], 
                  fill=dark_gray)
    # Hammer head
    draw.rectangle([hammer_x-icon_size//2, hammer_y-icon_size//3, 
                   hammer_x+icon_size//6, hammer_y+icon_size//3], 
                  fill=dark_gray)
    
    # Draw wrench (top right quadrant)
    wrench_x = center + size//4
    wrench_y = center - size//4
    # Wrench body
    draw.rectangle([wrench_x-icon_size//3, wrench_y-icon_size//2, 
                   wrench_x+icon_size//3, wrench_y+icon_size//2], 
                  fill=accent_orange)
    # Wrench head
    draw.ellipse([wrench_x-icon_size//2, wrench_y-icon_size//3, 
                 wrench_x-icon_size//6, wrench_y+icon_size//3], 
                fill=accent_orange)
    
    # Draw house (bottom left quadrant)
    house_x = center - size//4
    house_y = center + size//4
    # House base
    draw.rectangle([house_x-icon_size//2, house_y-icon_size//4, 
                   house_x+icon_size//2, house_y+icon_size//2], 
                  fill=green)
    # House roof (triangle)
    roof_points = [
        (house_x, house_y-icon_size//2),
        (house_x-icon_size//2, house_y-icon_size//4),
        (house_x+icon_size//2, house_y-icon_size//4)
    ]
    draw.polygon(roof_points, fill=dark_gray)
    
    # Draw gear (bottom right quadrant)
    gear_x = center + size//4
    gear_y = center + size//4
    gear_radius = icon_size // 3
    
    # Draw gear teeth (simplified as circle with notches)
    draw.ellipse([gear_x-gear_radius, gear_y-gear_radius, 
                 gear_x+gear_radius, gear_y+gear_radius], 
                fill=dark_gray)
    # Inner circle
    inner_gear_radius = gear_radius // 2
    draw.ellipse([gear_x-inner_gear_radius, gear_y-inner_gear_radius, 
                 gear_x+inner_gear_radius, gear_y+inner_gear_radius], 
                fill=light_gray)
    
    # Draw central "H" for HomeLinkGH
    h_size = size // 6
    h_thickness = size // 20
    h_x = center
    h_y = center
    
    # Left vertical line of H
    draw.rectangle([h_x-h_size//2, h_y-h_size//2, 
                   h_x-h_size//2+h_thickness, h_y+h_size//2], 
                  fill=primary_blue)
    # Right vertical line of H
    draw.rectangle([h_x+h_size//2-h_thickness, h_y-h_size//2, 
                   h_x+h_size//2, h_y+h_size//2], 
                  fill=primary_blue)
    # Horizontal line of H
    draw.rectangle([h_x-h_size//2, h_y-h_thickness//2, 
                   h_x+h_size//2, h_y+h_thickness//2], 
                  fill=primary_blue)
    
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
    
    print("Creating service-focused iOS app icons...")
    for size, filename in ios_sizes:
        icon = create_service_icon(size)
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
        
        icon = create_service_icon(size)
        icon.save(f"{android_dir}/ic_launcher.png")
        print(f"Created Android icon {size}x{size} in {android_dir}")

if __name__ == "__main__":
    main()
    print("\n✅ Service-focused app icons created successfully!")
    print("Icons feature: Hammer, Wrench, House, Gear + 'H' for HomeLinkGH Provider")