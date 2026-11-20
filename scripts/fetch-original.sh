#!/usr/bin/env bash
# 从作者网站 alpo.ge 下载原始文件，并用仓库里的 SHA256SUMS 校验。
#
#   bash scripts/fetch-original.sh          # 只下载作者的说明 remark.pdf
#   bash scripts/fetch-original.sh --lean   # 另外下载 14 个 Lean 分卷（约 240 MB）并解压对比
#
# 文件都放在 original/ 目录下（该目录已加入 .gitignore，不会被提交）。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/original"
BASE="https://alpo.ge"
WAYBACK="https://web.archive.org/web/20261120141958/https://alpo.ge/remark.pdf"
mkdir -p "$OUT"
cd "$OUT"

echo "==> 下载作者说明 remark.pdf"
if ! curl -fSLo remark.pdf "$BASE/remark.pdf"; then
  echo "    作者网站不可用，改用互联网档案馆快照"
  curl -fSLo remark.pdf "$WAYBACK"
fi

if [[ "${1:-}" == "--lean" ]]; then
  echo "==> 下载 14 个 Lean 分卷"
  for i in $(seq -w 1 14); do
    curl -fSLO "$BASE/lean.tar.gz.part$i" &
  done
  wait
  cat lean.tar.gz.part{01..14} > lean.tar.gz
fi

echo "==> 校验 SHA-256"
grep -Ev '^(#|$)' "$ROOT/SHA256SUMS" | shasum -a 256 -c --ignore-missing -

if [[ -f lean.tar.gz ]]; then
  echo "==> 解压并与本仓库的 src/ 逐字节比较"
  rm -rf extracted && mkdir extracted
  tar -xzf lean.tar.gz -C extracted
  for f in lakefile.toml lake-manifest.json lean-toolchain; do
    cmp "extracted/lean/$f" "$ROOT/$f"
  done
  diff -rq extracted/lean/src "$ROOT/src" && echo "    完全一致：本仓库的 Lean 源码与作者原始压缩包相同"
fi

echo "==> 完成。文件在 $OUT"
