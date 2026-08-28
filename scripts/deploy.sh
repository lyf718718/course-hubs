#!/usr/bin/env bash
# Stateless deploy of one course hub to https://lyf718718.github.io/course-hubs/<course>/
#
#   ./scripts/deploy.sh <course-slug> <path-to-site-dir>
#
# <site-dir> must contain index.html (the course's hub_build/site/ output).
# Pattern mirrors mktg-research-sim/scripts/deploy_pages.sh: fresh shallow clone,
# replace the course subfolder, push, discard — no persistent local repo required.
set -euo pipefail

REPO="https://github.com/lyf718718/course-hubs.git"
SLUG="${1:?usage: deploy.sh <course-slug> <path-to-site-dir>}"
SITE="${2:?usage: deploy.sh <course-slug> <path-to-site-dir>}"

case "$SLUG" in
  *[!a-z0-9_-]*) echo "slug must be lowercase [a-z0-9_-]: $SLUG" >&2; exit 1 ;;
esac
[[ -f "$SITE/index.html" ]] || { echo "no index.html in $SITE — run the course's build_hub.py first" >&2; exit 1; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
git clone --quiet --depth 1 "$REPO" "$TMP/repo"

rm -rf "$TMP/repo/${SLUG:?}"
mkdir -p "$TMP/repo/$SLUG"
cp -R "$SITE"/. "$TMP/repo/$SLUG"/

cd "$TMP/repo"
git add -A
if git diff --cached --quiet; then
  echo "no changes for $SLUG — nothing deployed"
  exit 0
fi
git commit --quiet -m "deploy $SLUG $(date +%Y-%m-%d)"
git push --quiet
echo "Deployed: https://lyf718718.github.io/course-hubs/$SLUG/"
