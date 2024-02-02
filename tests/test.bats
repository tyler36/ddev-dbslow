setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/dbslow-test
  mkdir -p $TESTDIR
  export PROJNAME=dbslow-test
  export DDEV_NON_INTERACTIVE=true
  cd "${TESTDIR}"

  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  # [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

health_checks_mysql() {
  echo "# Check logging can be turned on."
  ddev dbslow on
  ddev mysql -e "SELECT 'START'; DO SLEEP(2); SELECT 'END';"
  ddev dbslow view | grep "DO SLEEP(2)"

  echo "# Check log can be turned off."
  ddev dbslow off
  ddev mysql -e "SELECT 'START'; DO SLEEP(4); SELECT 'END';"
  if [[ $(ddev dbslow view) =~ "SLEEP(4)" ]]; then
    echo "Logging is still enabled."
    exit 1;
  fi
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart

  health_checks_mysql
}

# @test "install from release" {
#   set -eu -o pipefail
#   cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
#   echo "# ddev get tyler36/ddev-dbslow with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
#   ddev get tyler36/ddev-dbslow
#   ddev restart >/dev/null
#   health_checks_mysql
# }
