#!/bin/bash

# HomeLinkGH and Beacon NGO Staging Deployment Script
# This script deploys both applications to their respective staging environments

set -e

echo "🚀 Starting staging deployment for HomeLinkGH and Beacon NGO..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
HOMELINKGH_DIR="customer_app"
BEACON_DIR="beacon-of-new-beginnings/ngo_support_app"
STAGING_DOMAIN="staging.homelinkgh.com"
BEACON_STAGING_DOMAIN="staging.beaconnewbeginnings.org"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
check_flutter() {
    if ! command -v flutter &> /dev/null; then
        print_error "Flutter is not installed. Please install Flutter first."
        exit 1
    fi
    print_success "Flutter is installed"
}

# Check if Firebase CLI is installed
check_firebase() {
    if ! command -v firebase &> /dev/null; then
        print_warning "Firebase CLI is not installed. Installing..."
        npm install -g firebase-tools
    fi
    print_success "Firebase CLI is available"
}

# Check if Netlify CLI is installed
check_netlify() {
    if ! command -v netlify &> /dev/null; then
        print_warning "Netlify CLI is not installed. Installing..."
        npm install -g netlify-cli
    fi
    print_success "Netlify CLI is available"
}

# Deploy HomeLinkGH Customer App
deploy_homelinkgh() {
    print_status "Deploying HomeLinkGH Customer App to staging..."
    
    cd "$HOMELINKGH_DIR"
    
    # Clean previous builds
    print_status "Cleaning previous builds..."
    flutter clean
    flutter pub get
    
    # Build for web with staging configuration
    print_status "Building Flutter web app for staging..."
    flutter build web --web-renderer html --base-href "/" --dart-define=ENVIRONMENT=staging
    
    # Copy staging files
    print_status "Copying staging configuration..."
    if [ -d "web/staging" ]; then
        cp web/staging/* build/web/
        print_success "Staging files copied"
    else
        print_warning "No staging directory found, using default build"
    fi
    
    # Deploy to Firebase Hosting (staging)
    print_status "Deploying to Firebase Hosting..."
    if [ -f "firebase.json" ]; then
        firebase deploy --project homelinkgh-staging --only hosting
        print_success "HomeLinkGH deployed to Firebase Hosting"
    else
        print_warning "No firebase.json found, skipping Firebase deployment"
    fi
    
    # Deploy to Netlify (alternative)
    print_status "Deploying to Netlify..."
    if [ -f "netlify.toml" ]; then
        netlify deploy --prod --dir=build/web --site=homelinkgh-staging
        print_success "HomeLinkGH deployed to Netlify"
    else
        print_warning "No netlify.toml found, skipping Netlify deployment"
    fi
    
    cd ..
}

# Deploy Beacon NGO App
deploy_beacon() {
    print_status "Deploying Beacon NGO App to staging..."
    
    cd "$BEACON_DIR"
    
    # Clean previous builds
    print_status "Cleaning previous builds..."
    flutter clean
    flutter pub get
    
    # Build for web with staging configuration
    print_status "Building Flutter web app for staging..."
    flutter build web --web-renderer html --base-href "/" --dart-define=ENVIRONMENT=staging
    
    # Copy staging files
    print_status "Copying staging configuration..."
    if [ -d "web/staging" ]; then
        cp web/staging/* build/web/
        print_success "Staging files copied"
    else
        print_warning "No staging directory found, using default build"
    fi
    
    # Deploy to Firebase Hosting (staging)
    print_status "Deploying to Firebase Hosting..."
    if [ -f "firebase.json" ]; then
        firebase deploy --project beacon-staging --only hosting
        print_success "Beacon NGO deployed to Firebase Hosting"
    else
        print_warning "No firebase.json found, skipping Firebase deployment"
    fi
    
    # Deploy to Netlify (alternative)
    print_status "Deploying to Netlify..."
    if [ -f "netlify.toml" ]; then
        netlify deploy --prod --dir=build/web --site=beacon-staging
        print_success "Beacon NGO deployed to Netlify"
    else
        print_warning "No netlify.toml found, skipping Netlify deployment"
    fi
    
    cd ../..
}

# Setup Firebase projects for staging
setup_firebase_staging() {
    print_status "Setting up Firebase staging projects..."
    
    # HomeLinkGH staging
    cd "$HOMELINKGH_DIR"
    if [ ! -f "firebase.json" ]; then
        print_status "Creating Firebase configuration for HomeLinkGH..."
        cat > firebase.json << EOF
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "no-cache"
          }
        ]
      }
    ]
  }
}
EOF
    fi
    cd ..
    
    # Beacon NGO staging
    cd "$BEACON_DIR"
    if [ ! -f "firebase.json" ]; then
        print_status "Creating Firebase configuration for Beacon NGO..."
        cat > firebase.json << EOF
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "no-cache"
          }
        ]
      }
    ]
  }
}
EOF
    fi
    cd ../..
}

# Setup Netlify configurations
setup_netlify_staging() {
    print_status "Setting up Netlify staging configurations..."
    
    # HomeLinkGH netlify.toml
    cd "$HOMELINKGH_DIR"
    if [ ! -f "netlify.toml" ]; then
        print_status "Creating Netlify configuration for HomeLinkGH..."
        cat > netlify.toml << EOF
[build]
  publish = "build/web"
  command = "flutter build web --web-renderer html --dart-define=ENVIRONMENT=staging"

[build.environment]
  FLUTTER_WEB_USE_SKIA = "false"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"

[context.staging]
  environment = { ENVIRONMENT = "staging" }
EOF
    fi
    cd ..
    
    # Beacon NGO netlify.toml
    cd "$BEACON_DIR"
    if [ ! -f "netlify.toml" ]; then
        print_status "Creating Netlify configuration for Beacon NGO..."
        cat > netlify.toml << EOF
[build]
  publish = "build/web"
  command = "flutter build web --web-renderer html --dart-define=ENVIRONMENT=staging"

[build.environment]
  FLUTTER_WEB_USE_SKIA = "false"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
    Referrer-Policy = "strict-origin-when-cross-origin"

[context.staging]
  environment = { ENVIRONMENT = "staging" }
EOF
    fi
    cd ../..
}

# Main deployment function
main() {
    print_status "🚀 Starting staging deployment process..."
    
    # Check prerequisites
    check_flutter
    check_firebase
    check_netlify
    
    # Setup configurations
    setup_firebase_staging
    setup_netlify_staging
    
    # Deploy applications
    deploy_homelinkgh
    deploy_beacon
    
    print_success "🎉 Staging deployment completed!"
    print_status "📋 Deployment Summary:"
    echo "   HomeLinkGH Staging: https://${STAGING_DOMAIN}"
    echo "   Beacon NGO Staging: https://${BEACON_STAGING_DOMAIN}"
    echo ""
    print_status "🧪 Test Credentials:"
    echo "   HomeLinkGH Customer: test.customer@homelinkgh.com / TestPass123!"
    echo "   HomeLinkGH Provider: test.provider@homelinkgh.com / TestPass123!"
    echo "   Beacon NGO: Demo mode - no login required"
    echo ""
    print_status "📖 View logs with: firebase hosting:channel:list"
}

# Run main function
main "$@"