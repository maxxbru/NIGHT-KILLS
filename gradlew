#!/usr/bin/env sh
# Minimal gradlew
APP_NAME="Gradle"
APP_BASE_NAME=$(basename "$0")
GRADLE_USER_HOME="${GRADLE_USER_HOME:-$HOME/.gradle}"
# Download gradle if not present
if [ ! -f "$HOME/.gradle/wrapper/dists/gradle-8.2-bin/gradle-8.2/bin/gradle" ]; then
  echo "Downloading Gradle..."
  mkdir -p "$HOME/.gradle/wrapper/dists"
  # Use wrapper jar if exists, else use direct gradle
  if command -v wget > /dev/null; then
    wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip -O /tmp/gradle.zip || true
    unzip -q /tmp/gradle.zip -d /tmp/ || true
    /tmp/gradle-8.2/bin/gradle --version || true
  fi
fi
# Try wrapper
if [ -f "gradle/wrapper/gradle-wrapper.jar" ]; then
  exec java -jar gradle/wrapper/gradle-wrapper.jar "$@"
else
  # Fallback to system gradle installed by setup
  exec gradle "$@"
fi