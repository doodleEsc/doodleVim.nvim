#!/usr/bin/env bash

get_os_type() {
  os=$(uname)
  if [[ "$os" == "Linux" ]]; then
    echo "linux"
  elif [[ "$os" == "Darwin" ]]; then
    echo "mac"
  else
    echo "win"
  fi
}

OSTYPE=$(get_os_type)
JAR="$HOME/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
CONFIG="$HOME/.local/share/nvim/mason/packages/jdtls/config_$OSTYPE"
LOMBOK="$HOME/.local/share/nvim/mason/packages/jdtls/plugins/lombok.jar"

export GRADLE_HOME='$HOME/.sdkman/candidates/gradle/current/bin/gradle'
java \
  -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044 \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -javaagent:$LOMBOK \
  -Xbootclasspath/a:$LOMBOK \
  -jar $(echo "$JAR") \
  -configuration "$CONFIG" \
  -data "$1" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
