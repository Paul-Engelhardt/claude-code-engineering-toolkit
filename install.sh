#!/usr/bin/env bash
#
# Claude Code Engineering Toolkit: optional installer.
#
# Copies the agent files of one language version into a Claude Code agents
# directory. This is a convenience only. Manual installation is documented
# in README.md and README.de.md and works just as well.
#
# Requirements: bash (3.2+), cp, cmp, awk. Nothing else.

set -eu

usage() {
  cat <<'EOF'
Usage: ./install.sh --lang <de|en> [--project <path>] [--force] [agent ...]

Copies the toolkit agents into a Claude Code agents directory.

Options:
  --lang <de|en>      Language version to install (required)
  --project <path>    Install into <path>/.claude/agents/
                      (default: ~/.claude/agents/)
  --force             Overwrite existing files with the same file name
  -h, --help          Show this help

Arguments:
  agent ...           Install only these agents (default: all)

Examples:
  ./install.sh --lang de
  ./install.sh --project /path/to/project --lang en
  ./install.sh --lang en code-reviewer software-developer

Existing files are never overwritten without --force.

Exit codes: 0 = done, 1 = finished with conflicts, 2 = usage error
EOF
}

die() {
  printf 'Error: %s\n' "$1" >&2
  printf "Run './install.sh --help' for usage.\n" >&2
  exit 2
}

# Prints the 'name' field from a file's YAML frontmatter, if there is one.
frontmatter_name() {
  awk '
    { sub(/\r$/, "") }
    NR == 1 && $0 != "---" { exit }
    NR > 1 && $0 == "---" { exit }
    NR > 1 && /^name:/ {
      sub(/^name:[ \t]*/, ""); sub(/[ \t]+$/, "")
      gsub(/^["\047]|["\047]$/, "")
      print; exit
    }
  ' "$1"
}

report() {
  if [ -n "${3:-}" ]; then
    printf '  %-10s %-24s %s\n' "$1" "$2" "$3"
  else
    printf '  %-10s %s\n' "$1" "$2"
  fi
}

# --- Arguments ---------------------------------------------------------------

lang=""
project=""
force=0
selected=""

while [ $# -gt 0 ]; do
  case "$1" in
    --lang)      [ $# -ge 2 ] || die "--lang needs a value (de or en)"
                 lang="$2"; shift 2 ;;
    --lang=*)    lang="${1#*=}"; shift ;;
    --project)   [ $# -ge 2 ] || die "--project needs a path"
                 project="$2"; shift 2 ;;
    --project=*) project="${1#*=}"; shift ;;
    --force)     force=1; shift ;;
    -h|--help)   usage; exit 0 ;;
    -*)          die "unknown option: $1" ;;
    *)           n="${1%.md}"
                 case "$n" in
                   ""|*[!a-z0-9-]*) die "invalid agent name: $1" ;;
                 esac
                 selected="$selected $n"; shift ;;
  esac
done

case "$lang" in
  de) other_lang="en" ;;
  en) other_lang="de" ;;
  "") die "--lang is required (de or en)" ;;
  *)  die "unsupported language: $lang (use de or en)" ;;
esac

script_dir="$(cd "$(dirname "$0")" && pwd)"
src_dir="$script_dir/agents/$lang"
[ -d "$src_dir" ] || die "agent directory not found: $src_dir"

available=""
for f in "$src_dir"/*.md; do
  [ -f "$f" ] || continue
  n="$(basename "$f" .md)"
  available="$available $n"
done
[ -n "$available" ] || die "no agent files found in $src_dir"

if [ -n "$selected" ]; then
  for n in $selected; do
    [ -f "$src_dir/$n.md" ] || die "unknown agent: $n (available:$available)"
  done
  agents="$selected"
else
  agents="$available"
fi

if [ -n "$project" ]; then
  [ -d "$project" ] || die "project directory not found: $project"
  target="$(cd "$project" && pwd)/.claude/agents"
else
  target="$HOME/.claude/agents"
fi

# --- Install -----------------------------------------------------------------

mkdir -p "$target"

printf 'Installing agents (%s) into %s\n\n' "$lang" "$target"

installed=0
unchanged=0
overwritten=0
conflicts=0

for n in $agents; do
  src="$src_dir/$n.md"
  dest="$target/$n.md"
  agent_name="$(frontmatter_name "$src")"
  [ -n "$agent_name" ] || agent_name="$n"

  # Claude Code identifies agents by 'name', not by file name. Another file
  # with the same name would shadow or be shadowed by this one.
  clash=""
  for f in "$target"/*.md; do
    [ -f "$f" ] || continue
    [ "$f" = "$dest" ] && continue
    if [ "$(frontmatter_name "$f")" = "$agent_name" ]; then
      clash="$(basename "$f")"
      break
    fi
  done

  if [ -n "$clash" ]; then
    report "conflict" "$n" "name '$agent_name' already used by $clash"
    conflicts=$((conflicts + 1))
  elif [ ! -e "$dest" ]; then
    cp "$src" "$dest"
    report "installed" "$n"
    installed=$((installed + 1))
  elif cmp -s "$src" "$dest"; then
    report "unchanged" "$n" "already up to date"
    unchanged=$((unchanged + 1))
  elif [ "$force" -eq 1 ]; then
    cp "$src" "$dest"
    report "replaced" "$n"
    overwritten=$((overwritten + 1))
  else
    other="$script_dir/agents/$other_lang/$n.md"
    if [ -f "$other" ] && cmp -s "$other" "$dest"; then
      report "conflict" "$n" "the $other_lang version is installed"
    else
      report "conflict" "$n" "existing file differs (modified or other version)"
    fi
    conflicts=$((conflicts + 1))
  fi
done

printf '\n%d installed, %d unchanged, %d replaced, %d conflicts\n' \
  "$installed" "$unchanged" "$overwritten" "$conflicts"

if [ "$conflicts" -gt 0 ]; then
  printf '\nConflicting files were left untouched.\n'
  printf 'Same file name: rerun with --force to replace them.\n'
  printf 'Same name in another file: remove or rename that file manually.\n'
fi

if [ $((installed + overwritten)) -gt 0 ]; then
  printf '\nRestart running Claude Code sessions to load the changes.\n'
fi

[ "$conflicts" -eq 0 ] || exit 1
