# original/：作者原始文件

这个目录用来存放从作者网站下载的原始文件。运行下面的命令即可获取并校验：

```bash
bash scripts/fetch-original.sh          # 下载作者说明 remark.pdf
bash scripts/fetch-original.sh --lean   # 另外下载 14 个 Lean 分卷，并与本仓库 src/ 逐字节比对
```

| 文件 | 原始地址 | 备份地址 | SHA-256 |
|---|---|---|---|
| `remark.pdf`（4 页英文说明） | <https://alpo.ge/remark.pdf> | [互联网档案馆快照（2026-11-20）](https://web.archive.org/web/20261120141958/https://alpo.ge/remark.pdf) | `3fc97784…cfeb8d` |
| `lean.tar.gz.part01` … `part14` | <https://alpo.ge/lean.tar.gz.part01> … `part14` | [part01 快照](https://web.archive.org/web/20261120142003/https://alpo.ge/lean.tar.gz.part01) | 见 [`SHA256SUMS`](../SHA256SUMS) |

## 为什么 PDF 不直接放在仓库里

`remark.pdf` 是作者的个人文章，作者没有给它附任何许可协议。默认情况下它的版权属于作者，
所以本仓库不重新分发 PDF 文件本身，也不提供逐句全文翻译，只做两件事：

1. 给出原始链接、存档链接和 SHA-256，并附一键下载校验脚本，保证你拿到的就是作者发布的那一份；
2. 在 [`docs/02-作者说明导读.md`](../docs/02-作者说明导读.md) 里用中文把内容讲清楚：作者说了什么、每个数学名词是什么意思、时间线怎么读。

如果作者明确同意转载或翻译，可以把 PDF 和完整译文补进这个目录。
