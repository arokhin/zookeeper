# Mirrors GHA website.yaml job "website-site" (runs-on: ubuntu-24.04, same as the agents).
# setup-node 24.18.1 → the same official tarball, unpacked into this build's MF_TOOLS.
node_dir="$MF_TOOLS/node-v$MF_NODE_VERSION-linux-x64"
curl -fsSL --retry 3 "https://nodejs.org/dist/v$MF_NODE_VERSION/node-v$MF_NODE_VERSION-linux-x64.tar.xz" |
  tar -xJ -C "$MF_TOOLS"
export PATH="$node_dir/bin:$PATH"
# Stateless: npm cache and Playwright browsers per build, not in the agent's home
# (GHA caches both). The frontend-maven-plugin's own `npx playwright install` inside
# `mvn site` sees the same PLAYWRIGHT_BROWSERS_PATH, so it finds what is installed here.
export npm_config_cache="$MF_TOOLS/npm-cache"
export PLAYWRIGHT_BROWSERS_PATH="$MF_TOOLS/ms-playwright"
node --version
npm --version
(cd zookeeper-website && npm ci)
# --with-deps installs the browsers' system libraries with sudo apt-get (passwordless sudo works on the AMIs).
(cd zookeeper-website && npx playwright install --with-deps)
"$MF_MVN" "${MF_MVN_COMMON[@]}" -pl zookeeper-website site
