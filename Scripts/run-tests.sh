#!/bin/bash

set -o pipefail

: ${SCHEME:="XCDYouTubeKit iOS Static Library"}
: ${CONFIGURATION:="Release"}
: ${DESTINATION:="platform=iOS Simulator,name=iPhone 5s"}

COMMAND="xcodebuild clean test -project XCDYouTubeKit.xcodeproj -scheme '${SCHEME}' -configuration '${CONFIGURATION}' -destination '${DESTINATION}'"

for BUILD_SETTING in OBJROOT RUN_CLANG_STATIC_ANALYZER; do
    VALUE=`eval echo \\$"${BUILD_SETTING}"`
    if [ ! -z "${VALUE}" ]; then
        COMMAND+=" ${BUILD_SETTING}='${VALUE}'"
        unset ${BUILD_SETTING}
    fi
done

xcpretty --version > /dev/null && COMMAND+=" | xcpretty -c"

set -x
eval "${COMMAND}"
