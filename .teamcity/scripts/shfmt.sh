# Mirrors GHA scripts.yaml "Install shfmt". Upstream's tools/ci/install-shfmt.sh runs
# `sudo wget ... -O /usr/local/bin/shfmt`, which would leave a binary on the shared agent.
# Same version and URL, but into this build's MF_TOOLS/bin. The version is read from
# upstream's script, so a bump there is picked up here.
shfmt_version=$(sed -n 's/^shfmt_version=//p' tools/ci/install-shfmt.sh)
[ -n "$shfmt_version" ] || { echo "could not read shfmt_version from tools/ci/install-shfmt.sh"; exit 1; }
curl -fsSL --retry 3 -o "$MF_TOOLS/bin/shfmt" \
  "https://github.com/mvdan/sh/releases/download/v${shfmt_version}/shfmt_v${shfmt_version}_linux_amd64"
chmod +x "$MF_TOOLS/bin/shfmt"
shfmt --version
