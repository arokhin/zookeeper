# Mirrors GHA scripts.yaml job "ShellCheck": tools/ci/run-shellcheck.sh.
# GHA's runner image has shellcheck preinstalled; the demo AMI is not known to. apt on
# Ubuntu 24.04 gives 0.9.x; ubuntu-latest (26.04) may be newer, so new warnings can differ.
if ! command -v shellcheck >/dev/null 2>&1; then
  sudo -n apt-get update -qq
  sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y -qq shellcheck
fi
shellcheck --version
tools/ci/run-shellcheck.sh
