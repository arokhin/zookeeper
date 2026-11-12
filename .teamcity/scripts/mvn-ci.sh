# Mirrors GHA ci.yaml job "mvn" (and, for the paused Jenkins lanes, their `sh "mvn ..."` line).
# MF_MVN_ARGS is the matrix entry's `args`, copied verbatim from upstream into settings.kts.
# It contains no quotes, so word splitting reproduces GHA's ${{ matrix.profile.args }} expansion.
# shellcheck disable=SC2086
"$MF_MVN" "${MF_MVN_COMMON[@]}" $MF_MVN_ARGS
