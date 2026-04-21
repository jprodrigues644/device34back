#!/usr/bin/env bash
# Run backend (Java) tests

set -e

echo "Running backend tests..."

#Make sure java is installed
# Make sure Gradle wrapper is executable
#
chmod +x ./gradlew
./gradlew clean test

echo "Backend tests completed"