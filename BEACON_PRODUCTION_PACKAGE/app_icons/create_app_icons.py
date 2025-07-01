#!/usr/bin/env python3
"""
Beacon of New Beginnings - App Icon Generator
Creates all required app icons for iOS and Android based on the NGO branding
"""

from PIL import Image, ImageDraw, ImageFont
import os
import math

# Brand colors
HOPE_GREEN = "#2E7D5C"
CARE_ORANGE = "#FFA726" 
LIGHT_GREEN = "#4CAF50"
WHITE = "#FFFFFF"
SOFT_BACKGROUND = "#F8F9FA"

# Icon sizes for iOS
IOS_SIZES = [
    (1024, "AppStore"),
    (180, "iPhone3x"),
    (120, "iPhone2x"),
    (152, "iPad2x"),
    (76, "iPad1x"),
    (167, "iPadPro2x"),
    (60, "iPhoneSettings2x"),
    (40, "Spotlight2x"),
    (29, "Settings2x"),
    (20, "Notification2x")
]

# Icon sizes for Android
ANDROID_SIZES = [
    (512, "PlayStore"),
    (192, "xxxhdpi"),
    (144, "xxhdpi"),
    (96, "xhdpi"),
    (72, "hdpi"),
    (48, "mdpi"),
    (36, "ldpi")
]

def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple"""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def create_gradient_background(size, color1, color2):
    """Create a radial gradient background"""
    img = Image.new('RGB', (size, size))
    draw = ImageDraw.Draw(img)
    
    # Create radial gradient
    center = size // 2
    max_radius = size // 2
    
    for radius in range(max_radius):
        # Calculate gradient position (0 to 1)
        ratio = radius / max_radius
        
        # Interpolate between colors
        r1, g1, b1 = hex_to_rgb(color1)
        r2, g2, b2 = hex_to_rgb(color2)
        
        r = int(r1 + (r2 - r1) * ratio)
        g = int(g1 + (g2 - g1) * ratio)
        b = int(b1 + (b2 - b1) * ratio)
        
        color = (r, g, b)
        
        # Draw circle
        left = center - radius
        top = center - radius
        right = center + radius
        bottom = center + radius
        
        draw.ellipse([left, top, right, bottom], fill=color)
    
    return img

def draw_beacon_symbol(draw, size):
    """Draw a stylized beacon/lighthouse symbol"""
    center = size // 2
    
    # Beacon base (lighthouse structure)
    base_width = size // 4
    base_height = size // 2
    base_x = center - base_width // 2
    base_y = center + size // 6
    
    # Draw lighthouse shape (trapezoid)
    top_width = base_width // 2
    top_x = center - top_width // 2
    top_y = base_y - base_height
    
    lighthouse_points = [
        (base_x, base_y),
        (base_x + base_width, base_y),
        (top_x + top_width, top_y),
        (top_x, top_y)
    ]
    
    draw.polygon(lighthouse_points, fill=hex_to_rgb(WHITE))
    
    # Beacon light (circular glow)
    light_radius = size // 8
    light_center_y = top_y - light_radius // 2
    
    # Outer glow
    for i in range(3):
        glow_radius = light_radius + i * 2
        alpha = 100 - i * 30
        draw.ellipse([
            center - glow_radius, light_center_y - glow_radius,
            center + glow_radius, light_center_y + glow_radius
        ], fill=hex_to_rgb(CARE_ORANGE))
    
    # Main light
    draw.ellipse([
        center - light_radius, light_center_y - light_radius,
        center + light_radius, light_center_y + light_radius
    ], fill=hex_to_rgb(WHITE))
    
    # Light rays
    ray_length = size // 4
    for angle in [0, 45, 90, 135, 180, 225, 270, 315]:
        radian = math.radians(angle)
        start_x = center + math.cos(radian) * light_radius
        start_y = light_center_y + math.sin(radian) * light_radius
        end_x = center + math.cos(radian) * ray_length
        end_y = light_center_y + math.sin(radian) * ray_length
        
        draw.line([start_x, start_y, end_x, end_y], 
                 fill=hex_to_rgb(CARE_ORANGE), width=max(1, size//100))

def draw_support_hands(draw, size):
    """Draw subtle hands representing care and support"""
    center = size // 2
    hand_size = size // 8
    
    # Left hand (giving)
    left_x = center - size // 3
    left_y = center + size // 4
    
    # Right hand (receiving) 
    right_x = center + size // 3
    right_y = center + size // 4
    
    # Draw simple hand shapes
    for x, y in [(left_x, left_y), (right_x, right_y)]:
        # Palm
        draw.ellipse([x - hand_size//2, y - hand_size//3, 
                     x + hand_size//2, y + hand_size//3], 
                    fill=hex_to_rgb(LIGHT_GREEN))
        
        # Fingers (simplified)
        finger_width = hand_size // 6
        for i in range(3):
            finger_x = x - hand_size//4 + i * finger_width
            finger_y = y - hand_size//2
            draw.ellipse([finger_x - finger_width//2, finger_y - finger_width,
                         finger_x + finger_width//2, finger_y + finger_width//2],
                        fill=hex_to_rgb(LIGHT_GREEN))

def create_app_icon(size):
    """Create a single app icon of specified size"""
    # Create gradient background
    img = create_gradient_background(size, HOPE_GREEN, LIGHT_GREEN)
    draw = ImageDraw.Draw(img)
    
    # Add beacon symbol
    draw_beacon_symbol(draw, size)
    
    # Add support hands for larger icons
    if size >= 120:
        draw_support_hands(draw, size)
    
    # Add subtle border
    border_width = max(1, size // 64)
    draw.ellipse([border_width, border_width, 
                 size - border_width, size - border_width], 
                outline=hex_to_rgb(HOPE_GREEN), width=border_width)
    
    return img

def create_all_icons():
    """Create all required app icons"""
    # Create output directories
    os.makedirs("ios_icons", exist_ok=True)
    os.makedirs("android_icons", exist_ok=True)
    
    print("🏮 Creating Beacon of New Beginnings App Icons...")
    
    # Create iOS icons
    print("\n📱 Creating iOS Icons...")
    for size, name in IOS_SIZES:
        icon = create_app_icon(size)
        filename = f"ios_icons/icon_{size}x{size}_{name}.png"
        icon.save(filename)
        print(f"   ✅ {filename}")
    
    # Create Android icons
    print("\n🤖 Creating Android Icons...")
    for size, density in ANDROID_SIZES:
        icon = create_app_icon(size)
        filename = f"android_icons/ic_launcher_{size}x{size}_{density}.png"
        icon.save(filename)
        print(f"   ✅ {filename}")
    
    # Create master icon
    print("\n🎨 Creating Master Icon...")
    master_icon = create_app_icon(1024)
    master_icon.save("beacon_app_icon_master_1024x1024.png")
    print("   ✅ beacon_app_icon_master_1024x1024.png")
    
    print("\n🎉 All icons created successfully!")
    print("\nNext steps:")
    print("1. Review all icons for clarity at small sizes")
    print("2. Test on actual devices")
    print("3. Replace icons in your app bundle")
    print("4. Update app store listings with new icons")

if __name__ == "__main__":
    create_all_icons()