#!/usr/bin/env bash
# Run backend (Java) tests

set -e

echo "Running backend tests..."

chmod +x ./gradlew
./gradlew clean test

echo "Backend tests completed"