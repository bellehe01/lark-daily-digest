#!/usr/bin/env bash
# download_skills.sh — 一键下载小红书《中文 AI 博主 PPT Skill 天花板排名》里的 7 个开源 skill。
# 用法:
#   bash skills/download_skills.sh [目标目录]     # 默认 ./ppt-skills
set -euo pipefail

DEST="${1:-./ppt-skills}"
mkdir -p "$DEST"

# 排名(飞哥智慧小卖部 2026-08-09)从高到低:
REPOS=(
  "hugohe3/ppt-master"                      # 🥇 夯      3.1万⭐ 可编辑 PPTX,元素级编辑+音色克隆旁白
  "zarazhangrui/frontend-slides"            # 🥈 顶级    2.3万⭐ 张咋啦,HTML 输出,审美拉满
  "alchaincyf/huashu-design"                # 🥈 顶级    1.9万⭐ 花叔,可导出可编辑 PPTX
  "op7418/guizang-ppt-skill"                # 🥉 人上人  1.5万⭐ 歸藏,瑞士风+快捷键
  "lewislulu/html-ppt-skill"                # NPC       6500⭐  Lewis,自带计时器/逐字稿
  "JimLiu/baoyu-skills"                     # NPC       2.2万⭐ 宝玉,可爱路线,纯图片输出
  "joeseesun/qiaomu-anything-to-notebooklm" # NPC       5400⭐  乔木,图片卡片/NotebookLM
)

for repo in "${REPOS[@]}"; do
  name="${repo##*/}"
  if [ -d "$DEST/$name/.git" ]; then
    echo "== $repo 已存在,拉取更新 =="
    git -C "$DEST/$name" pull --ff-only || true
  else
    echo "== 克隆 $repo =="
    git clone --depth 1 "https://github.com/$repo" "$DEST/$name"
  fi
done

echo
echo "全部完成,skill 位于:$DEST"
echo "在 Claude Code 中使用:阅读对应仓库的 SKILL.md(ppt-master 为 skills/ppt-master/SKILL.md)按其流程生成。"
