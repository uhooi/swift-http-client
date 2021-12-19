PRODUCT_NAME := Example
PROJECT_NAME := ${PRODUCT_NAME}.xcodeproj
SCHEME_NAME := ${PRODUCT_NAME}

TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 13 Pro Max
TEST_OS ?= 15.2
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

.PHONY: build-debug
build-debug:
	xcodebuild \
-sdk ${TEST_SDK} \
-configuration ${TEST_CONFIGURATION} \
-project ${PROJECT_NAME} \
-scheme ${SCHEME_NAME} \
-destination ${TEST_DESTINATION} \
clean build

