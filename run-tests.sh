#!/usr/bin/env bash
#Run backend tests with Gradle, ensuring proper environment setup and error handling.
set -euo pipefail


echo " Running Backend Tests"
echo "*==============================*"

# Variables
RESULTS_DIR="build/test-results/test"

# Java verification
if ! command -v java >/dev/null 2>&1; then
  echo "ERROR: Java is not installed"
  exit 1
fi

# Gradle Wrapper verification
if [ ! -f "./gradlew" ]; then
  echo "ERROR: gradlew not found"
  exit 1
fi

echo "Java version:"
java -version

# Cleaning up old reports
echo "Cleaning previous test artifacts..."
rm -rf build/test-results
rm -rf build/reports/tests

# Permissions Gradle Wrapper
echo "Making gradlew executable..."
chmod +x ./gradlew

# Gradle Wrapper Verificationer
if [ ! -x "./gradlew" ]; then
  echo "ERROR: gradlew is not executable"
  exit 1
fi

#Launch of tests
echo "Running Gradle tests..."

./gradlew clean test

TEST_EXIT_CODE=$?

#Verification of JUnit report generation
if [ -d "$RESULTS_DIR" ]; then
  echo "JUnit reports generated in $RESULTS_DIR"
else
  echo "WARNING: No JUnit reports generated"
fi

# Return code management
if [ $TEST_EXIT_CODE -ne 0 ]; then
  echo "Backend tests failed"
  exit $TEST_EXIT_CODE
fi

echo "Backend tests completed successfully"
exit 0