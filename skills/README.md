# PPT Skills 下载与试用笔记

来源:小红书 @飞哥智慧小卖部《中文 AI 博主 PPT Skill 天花板排名》(2026-08-09)。
一键下载全部 7 个 skill:

```bash
bash skills/download_skills.sh          # 克隆到 ./ppt-skills(已 gitignore)
```

## 榜单与实测速览

| 档位 | 作者 | 仓库 | Star | 特点(榜单) | 实测备注 |
|------|------|------|------|--------------|----------|
| 🥇 夯 | hugohe | [hugohe3/ppt-master](https://github.com/hugohe3/ppt-master) | 3.1万 | 唯一真正在做演示文稿:所有元素可自由编辑,内置音色克隆与旁白生成 | ✅ 本次用它重建了作业。SVG → 原生 DrawingML PPTX,流程重但产出全可编辑;有免交互的 Quick 模式,带质量检查器,离线可跑(AI 生图除外) |
| 🥈 顶级 | 张咋啦 | [zarazhangrui/frontend-slides](https://github.com/zarazhangrui/frontend-slides) | 2.3万 | 审美拉满,HTML 输出,对使用者有一点技术要求 | 轻量,SKILL.md + 风格预设 + 动画模式,适合网页演示 |
| 🥈 顶级 | 花叔 | [alchaincyf/huashu-design](https://github.com/alchaincyf/huashu-design) | 1.9万 | 亮点是能直接导出可编辑 PPTX | Node 工具链,demos 丰富 |
| 🥉 人上人 | 歸藏 | [op7418/guizang-ppt-skill](https://github.com/op7418/guizang-ppt-skill) | 1.5万 | 瑞士风审美,自带快捷键,适合线下分享 | HTML 输出,零依赖预览 |
| NPC | Lewis | [lewislulu/html-ppt-skill](https://github.com/lewislulu/html-ppt-skill) | 6500 | 细节好,自带计时器、逐字稿等小工具 | 演讲辅助功能确实全 |
| NPC | 宝玉 | [JimLiu/baoyu-skills](https://github.com/JimLiu/baoyu-skills) | 2.2万 | 可爱路线,主要纯图片输出 | 是个 skill 合集仓库,PPT 只是其中之一 |
| NPC | 乔木 | [joeseesun/qiaomu-anything-to-notebooklm](https://github.com/joeseesun/qiaomu-anything-to-notebooklm) | 5400 | 纯图片卡片输出,适合内容初稿展示 | 主打 anything → NotebookLM/卡片 |

> Star 数为榜单发布时数据。仓库体积参考:ppt-master ~1.3GB(含示例工程),其余 0.5MB–63MB。

## 用 ppt-master 重建作业的最短路径

```bash
bash skills/download_skills.sh
cd ppt-skills/ppt-master
pip install python-pptx XlsxWriter skia-pathops uharfbuzz   # 核心导出依赖
# 按 skills/ppt-master/SKILL.md 的流程走(Quick 模式免确认):
python3 skills/ppt-master/scripts/project_manager.py init <项目名> --format ppt169 --quick-generate
python3 skills/ppt-master/scripts/icon_sync.py projects/<项目目录> tabler-outline/users ...
#(让 Claude 按 quick-generate.md 手写 svg_output/*.svg)
python3 skills/ppt-master/scripts/svg_quality_checker.py projects/<项目目录> --quick-generate --stage final --json
python3 skills/ppt-master/scripts/svg_to_pptx.py projects/<项目目录> --quick-generate --no-notes
```

产出见 [`homework/music-creator-manager/`](../homework/music-creator-manager/)。
