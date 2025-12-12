#!/usr/bin/env bash
set -euo pipefail

# Run Flutter tests with coverage and generate lcov report
flutter test --coverage

# Optionally filter out generated or bootstrap files from coverage
# Requires lcov (if available in environment)
if command -v lcov >/dev/null 2>&1; then
  echo "Filtering coverage for boilerplate and generated files..."
  lcov --remove coverage/lcov.info \
    "**/*.g.dart" \
    "**/*.freezed.dart" \
    "**/main.dart" \
    -o coverage/lcov.info || true
fi

echo "Coverage artifacts available under coverage/"
