# Inlined ahead of every step body by settings.kts. Runs under bash -eo pipefail on
# Linux agents only: upstream CI has no Windows or macOS lanes at all.

# Stateless by default (DESIGN Lesson 7). Per-build tool state (Maven local repo,
# npm cache, Playwright browsers, downloaded tools) lives in MF_TOOLS, which
# settings.kts points at this build's temp dir. TeamCity wipes it after the build.
# It is deliberately NOT inside the checkout: apache-rat:check scans the whole
# source tree, and tools/ci/run-shfmt.sh runs `shfmt -f .`, so a checkout-local
# cache would fail RAT with thousands of unlicensed files, or feed shfmt files
# that are not upstream's. Nothing touches the shared agent ~/.m2.
: "${MF_TOOLS:?settings.kts must set env.MF_TOOLS}"
mkdir -p "$MF_TOOLS/repository" "$MF_TOOLS/bin"
export PATH="$MF_TOOLS/bin:$PATH"

# Upstream GHA: mvn -B -V -e -ntp "-Dstyle.color=always" <args>, MAVEN_OPTS=-Djansi.force=true.
# GHA's setup-java `cache: maven` is dropped (stateless); the first build of each cell is cold.
MF_MVN_COMMON=(-B -V -e -ntp "-Dstyle.color=always" "-Dmaven.repo.local=$MF_TOOLS/repository")

echo "JAVA_HOME=$JAVA_HOME"
"$JAVA_HOME/bin/java" -version
export PATH="$JAVA_HOME/bin:$PATH"
"$MF_MVN" -v
git log -n1
