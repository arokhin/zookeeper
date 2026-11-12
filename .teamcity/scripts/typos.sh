# Mirrors GHA ci.yaml job "Typo Check": crate-ci/typos@v1.22.4 with the repo's .typos.toml.
v="$MF_TYPOS_VERSION"
curl -fsSL --retry 3 "https://github.com/crate-ci/typos/releases/download/v$v/typos-v$v-x86_64-unknown-linux-musl.tar.gz" |
  tar -xz -C "$MF_TOOLS/bin"
"$MF_TOOLS/bin/typos" --version
"$MF_TOOLS/bin/typos"
