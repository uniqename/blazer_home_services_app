#!/bin/bash

# Create screenshots directory structure
mkdir -p /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots
mkdir -p /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots

echo "📱 Creating placeholder screenshots for app store submissions..."

# Create placeholder screenshot files (these will be 1x1 pixel black images as placeholders)
# You'll need to replace these with actual app screenshots

# iPhone screenshots
echo "Creating iPhone screenshots..."
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_1_welcome.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_2_resources.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_3_crisis_support.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_4_community.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_5_safety_tools.png

# iPad screenshots
echo "Creating iPad screenshots..."
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/iOS_App_Store/screenshots/screenshot_1_welcome_ipad.png

# Android screenshots
echo "Creating Android screenshots..."
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_1.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_2.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_3.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_4.png
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/phone_screenshot_5.png

# Tablet screenshots
echo "Creating tablet screenshots..."
screencapture -x -t png /Users/enamegyir/Desktop/BEACON_APP_REVIEW_SUBMISSIONS/Google_Play_Store/screenshots/tablet_screenshot_1.png

echo "✅ Placeholder screenshots created!"
echo "📝 Note: These are placeholder files. You need to:"
echo "1. Open the HTML files in the screenshot_templates directory"
echo "2. Take proper screenshots of each HTML file"
echo "3. Replace the placeholder files with actual screenshots"
echo "4. Ensure correct dimensions for each platform"
echo ""
echo "📱 iOS Requirements:"
echo "- iPhone 6.5\": 1284 x 2778 pixels"
echo "- iPad Pro 12.9\": 2048 x 2732 pixels"
echo ""
echo "📱 Android Requirements:"
echo "- Phone: 16:9 or 9:16 aspect ratio"
echo "- Tablet: 16:10 or 10:16 aspect ratio"
echo ""
echo "📂 HTML templates available in: screenshot_templates/"
echo "📂 Output directory: Desktop/BEACON_APP_REVIEW_SUBMISSIONS/"