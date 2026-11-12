# Mirrors GHA e2e.yaml job "compatibility" [jdk=MF_JDK, zk=MF_ZK].
"$MF_MVN" "${MF_MVN_COMMON[@]}" package -DskipTests

# zoo_sample.cfg puts dataDir at /tmp/zookeeper. A GHA runner is fresh per job; a TeamCity agent may
# have run another e2e cell before (possibly a newer server writing a snapshot an older one cannot
# read). Clear it so the cell is stateless (Lesson 7).
rm -rf /tmp/zookeeper
export ZOOCFG=zoo_sample.cfg

if [ "$MF_ZK" = "nightly" ]; then
  tools/ci/test-connectivity.py --server . --client .
else
  dist="apache-zookeeper-$MF_ZK-bin"
  # GHA caches this tarball (actions/cache); here every build downloads it (stateless).
  curl -fsSL --retry 3 -O "https://archive.apache.org/dist/zookeeper/zookeeper-$MF_ZK/$dist.tar.gz"
  tar -xzf "$dist.tar.gz"
  tools/ci/test-connectivity.py --server . --client "$dist"
  tools/ci/test-connectivity.py --server "$dist" --client .
fi
