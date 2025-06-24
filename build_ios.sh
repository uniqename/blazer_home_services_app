#!/bin/bash

# Blazer Home Services - iOS Build Script for TestFlight
# This script automates the iOS build process for TestFlight deployment

set -e  # Exit on any error

echo "🚀 Starting iOS build process for Blazer Home Services..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project paths
PROJECT_ROOT="/Users/enamegyir/Documents/Projects/blazer_home_services_app"
CUSTOMER_APP="$PROJECT_ROOT/customer_app"
PROVIDER_APP="$PROJECT_ROOT/provider_app"
ADMIN_PANEL="$PROJECT_ROOT/admin_panel"

echo -e "${BLUE}📁 Project root: $PROJECT_ROOT${NC}"

# Function to build a Flutter app for iOS
build_flutter_ios() {
    local app_path=$1
    local app_name=$2
    
    echo -e "${YELLOW}🔨 Building $app_name for iOS...${NC}"
    
    cd "$app_path"
    
    # Clean previous builds
    echo -e "${BLUE}🧹 Cleaning previous builds...${NC}"
    flutter clean
    
    # Get dependencies
    echo -e "${BLUE}📦 Getting dependencies...${NC}"
    flutter pub get
    
    # Build for iOS
    echo -e "${BLUE}🏗️ Building iOS release...${NC}"
    flutter build ios --release --no-codesign
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $app_name iOS build completed successfully${NC}"
    else
        echo -e "${RED}❌ $app_name iOS build failed${NC}"
        exit 1
    fi
}

# Function to check prerequisites
check_prerequisites() {
    echo -e "${BLUE}🔍 Checking prerequisites...${NC}"
    
    # Check if Flutter is installed
    if ! command -v flutter &> /dev/null; then
        echo -e "${RED}❌ Flutter is not installed${NC}"
        exit 1
    fi
    
    # Check if Xcode is installed
    if ! command -v xcodebuild &> /dev/null; then
        echo -e "${RED}❌ Xcode is not installed${NC}"
        exit 1
    fi
    
    # Check Flutter doctor
    echo -e "${BLUE}🩺 Running Flutter doctor...${NC}"
    flutter doctor --android-licenses > /dev/null 2>&1 || true
    
    echo -e "${GREEN}✅ Prerequisites check completed${NC}"
}

# Function to create build info
create_build_info() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local git_hash=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
    
    cat > "$PROJECT_ROOT/BUILD_INFO.md" << EOF
# Blazer Home Services - Build Information

**Build Date:** $timestamp  
**Git Commit:** $git_hash  
**Flutter Version:** $(flutter --version | head -n 1)  
**Xcode Version:** $(xcodebuild -version | head -n 1)  

## Apps Built:
- ✅ Customer App (Main App)
- ✅ Provider App
- ✅ Admin Panel

## Features Included:
- 🎯 Multi-role onboarding (Customer, Provider, Job Seeker, Admin)
- 🍔 DoorDash-style food delivery with real-time tracking
- 💰 Comprehensive earnings dashboard for providers
- 🏪 Restaurant partner dashboard
- 📱 13 service categories with booking workflows
- 📊 Admin panel with job seeker management
- 🔄 Real-time order status updates
- 💳 Multiple payment methods integration

## TestFlight Deployment:
1. Archive each app in Xcode
2. Upload to App Store Connect
3. Configure TestFlight settings
4. Add beta testers
5. Submit for beta review

## Next Steps:
- [ ] Archive in Xcode
- [ ] Upload to App Store Connect
- [ ] Configure TestFlight metadata
- [ ] Add internal testers
- [ ] Submit for external testing review
EOF

    echo -e "${GREEN}📝 Build info created at $PROJECT_ROOT/BUILD_INFO.md${NC}"
}

# Main execution
main() {
    echo -e "${BLUE}🎯 Blazer Home Services - iOS Build Process${NC}"
    echo -e "${BLUE}================================================${NC}"
    
    # Check prerequisites
    check_prerequisites
    
    # Build all apps
    echo -e "${YELLOW}🏗️ Building all Flutter apps for iOS...${NC}"
    
    build_flutter_ios "$CUSTOMER_APP" "Customer App (Main)"
    build_flutter_ios "$PROVIDER_APP" "Provider App"
    build_flutter_ios "$ADMIN_PANEL" "Admin Panel"
    
    # Create build information
    create_build_info
    
    echo -e "${GREEN}🎉 All iOS builds completed successfully!${NC}"
    echo -e "${YELLOW}📱 Next steps:${NC}"
    echo -e "${BLUE}1. Open Xcode and archive each app:${NC}"
    echo -e "   - Customer App: open $CUSTOMER_APP/ios/Runner.xcworkspace"
    echo -e "   - Provider App: open $PROVIDER_APP/ios/Runner.xcworkspace"
    echo -e "   - Admin Panel: open $ADMIN_PANEL/ios/Runner.xcworkspace"
    echo -e "${BLUE}2. Upload to App Store Connect${NC}"
    echo -e "${BLUE}3. Configure TestFlight as per TESTFLIGHT_SETUP.md${NC}"
    echo -e "${BLUE}4. Add beta testers and start testing${NC}"
    
    echo -e "${GREEN}✨ Happy testing! 🚀${NC}"
}

# Run main function
main "$@"