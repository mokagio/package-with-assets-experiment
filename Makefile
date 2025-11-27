# Makefile for building GenOneFramework XCFramework

# Variables
PROJECT_DIR = ./XCFrameworkScaffold/XCFrameworkScaffold
PROJECT_NAME = XCFrameworkScaffold
SCHEME = GenOneFramework
XCFRAMEWORK_NAME = GenOneFramework.xcframework
BUILD_DIR = ./XCFrameworkScaffold/build
ARCHIVE_DIR = $(BUILD_DIR)/archives

# Derived data location
DERIVED_DATA_PATH = $(BUILD_DIR)/DerivedData

# Archive paths
IOS_ARCHIVE = $(ARCHIVE_DIR)/ios.xcarchive
IOS_SIMULATOR_ARCHIVE = $(ARCHIVE_DIR)/ios-simulator.xcarchive
MACOS_ARCHIVE = $(ARCHIVE_DIR)/macos.xcarchive

# Output path
OUTPUT_DIR = ./XCFrameworkScaffold/output
XCFRAMEWORK_PATH = $(OUTPUT_DIR)/$(XCFRAMEWORK_NAME)

# Integration test variables
INTEGRATION_TEST_PROJECT_DIR = ./XCFrameworkIntegrationTest/XCFrameworkIntegrationTest
INTEGRATION_TEST_PROJECT_NAME = XCFrameworkIntegrationTest
INTEGRATION_TEST_SCHEME = IntegrationTests
INTEGRATION_TEST_FRAMEWORKS_DIR = $(INTEGRATION_TEST_PROJECT_DIR)/Frameworks

.PHONY: all clean xcframework archive-ios archive-ios-simulator archive-macos xcframework-integration-test

all: xcframework

# Build XCFramework for iOS, iOS Simulator, and macOS
xcframework: archive-ios archive-ios-simulator archive-macos
	@echo "Creating XCFramework..."
	@mkdir -p $(OUTPUT_DIR)
	@rm -rf $(XCFRAMEWORK_PATH)
	xcodebuild -create-xcframework \
		-archive $(IOS_ARCHIVE) -framework $(SCHEME).framework \
		-archive $(IOS_SIMULATOR_ARCHIVE) -framework $(SCHEME).framework \
		-archive $(MACOS_ARCHIVE) -framework $(SCHEME).framework \
		-output $(XCFRAMEWORK_PATH)
	@echo "XCFramework created at $(XCFRAMEWORK_PATH)"

# Archive for iOS device
archive-ios:
	@echo "Building archive for iOS..."
	@mkdir -p $(ARCHIVE_DIR)
	xcodebuild archive \
		-project $(PROJECT_DIR)/$(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-destination "generic/platform=iOS" \
		-archivePath $(IOS_ARCHIVE) \
		-derivedDataPath $(DERIVED_DATA_PATH) \
		SKIP_INSTALL=NO \
		BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# Archive for iOS Simulator
archive-ios-simulator:
	@echo "Building archive for iOS Simulator..."
	@mkdir -p $(ARCHIVE_DIR)
	xcodebuild archive \
		-project $(PROJECT_DIR)/$(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-destination "generic/platform=iOS Simulator" \
		-archivePath $(IOS_SIMULATOR_ARCHIVE) \
		-derivedDataPath $(DERIVED_DATA_PATH) \
		SKIP_INSTALL=NO \
		BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# Archive for macOS
archive-macos:
	@echo "Building archive for macOS..."
	@mkdir -p $(ARCHIVE_DIR)
	xcodebuild archive \
		-project $(PROJECT_DIR)/$(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-destination "generic/platform=macOS" \
		-archivePath $(MACOS_ARCHIVE) \
		-derivedDataPath $(DERIVED_DATA_PATH) \
		SKIP_INSTALL=NO \
		BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)
	@rm -rf $(OUTPUT_DIR)
	@echo "Clean complete"

xcframework-integration-test: xcframework
	@echo "Running integration tests..."
	xcodebuild test \
		-project $(INTEGRATION_TEST_PROJECT_DIR)/$(INTEGRATION_TEST_PROJECT_NAME).xcodeproj \
		-scheme $(INTEGRATION_TEST_SCHEME) \
		-destination "platform=iOS Simulator,name=iPhone 16 Pro" | xcbeautify

xcframework-scaffold-test:
	@echo "Running scaffold project tests..."
	xcodebuild test \
		-project $(PROJECT_DIR)/$(PROJECT_NAME).xcodeproj \
		-scheme $(SCHEME) \
		-destination "platform=iOS Simulator,name=iPhone 16 Pro" | xcbeautify

# Help target
help:
	@echo "Available targets:"
	@echo "  make all                        - Build XCFramework for all platforms (default)"
	@echo "  make xcframework                - Build XCFramework for all platforms"
	@echo "  make archive-ios                - Build archive for iOS only"
	@echo "  make archive-ios-simulator      - Build archive for iOS Simulator only"
	@echo "  make archive-macos              - Build archive for macOS only"
	@echo "  make xcframework-integration-test - Build XCFramework and run integration tests"
	@echo "  make clean                      - Remove all build artifacts"
	@echo "  make help                       - Show this help message"
