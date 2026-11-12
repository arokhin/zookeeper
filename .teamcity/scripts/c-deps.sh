# Mirrors GHA step "Install C Dependencies": sudo apt update; sudo apt install -y libcppunit-dev libsasl2-dev.
# -Pfull-build also compiles the C client (autoreconf, configure --with-openssl --with-sasl, make), even
# with -DskipTests. GHA's runner image ships autoconf/automake/libtool/pkg-config/libssl-dev preinstalled;
# the demo AMI's contents are unverified, so they are listed explicitly (installing a present package is a no-op).
# The AMI ships with empty apt lists (GOTCHAS), so update first. -n: fail loudly if sudo needs a password.
sudo -n apt-get update -qq
sudo -n DEBIAN_FRONTEND=noninteractive apt-get install -y -qq \
  libcppunit-dev libsasl2-dev \
  build-essential autoconf automake libtool pkg-config libssl-dev
