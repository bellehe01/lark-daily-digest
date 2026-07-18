# Belle He — Career Knowledge Base

> 用途:为任意新岗位快速定制简历/cover letter/面试准备的**单一事实来源**。
> 所有事实经本人确认或代码验证,标注了来源和诚实红线。
> 新会话使用方法:让 AI 通读本目录,再给它 JD 链接,按下方 SOP 产出。

## 目录结构

| 文件 | 内容 |
|---|---|
| `profile.md` | 联系方式、教育、语言、地理偏好等基础信息 |
| `experience-outlandish.md` | 现职全部项目的完整事实(核心弹药库) |
| `experience-intellipro.md` | IntelliPro AI Sourcing PM 实习(2025.6–9,AI PM 王牌) |
| `experience-early-career.md` | TikTok PM / TikTok DA / ByteDance 三段实习 |
| `metrics-and-redlines.md` | 全部数字的台账(含出处)+ 诚实红线清单 |
| `personas.md` | 已建成的 4 个简历人设 + 求职进行时快照 |

相关目录:
- `../resume/` — 4 套已完成的简历+CL 成品(HTML 源文件 + PDF)
- `../interview-prep/` — 技术基础、SQL 练习、场景题框架三件套

## 新 JD 来了怎么用(SOP)

1. **抓 JD**:提取职责列表、最低/优先资格、团队名、地点
2. **选人设**:对照 `personas.md` 四个人设,选最近的作为基底(或混合)
3. **主题化改写**:Outlandish 段落按"主题 bullet"写法——每条主题对应 JD 的一个核心职责,主题词加粗,项目作并列证据塞入,**每条 ≤4 行**
4. **逐词对齐**:JD 的原词(如 "ticket deflection"、"QA sampling")直接进 bullet 和 Skills
5. **头衔适配**:官方头衔是 Senior Data Analyst,后缀按人设选(见 personas.md),不可编造头衔
6. **诚实校验**:对照 `metrics-and-redlines.md` 红线清单过一遍
7. **排版**:单页硬约束;内容少则放大字号填满版面(9.0–9.5pt 区间调),内容多则压缩间距;Coursework(all A/A+)保留

## 渲染管线(HTML → PDF)

```bash
# 渲染 PDF(用 resume/ 下任一 HTML 做模板,改内容不改样式骨架)
chromium --headless --disable-gpu --no-sandbox --no-pdf-header-footer \
  --print-to-pdf=OUT.pdf IN.html

# 检查页数(必须为 1)
python3 -c "import re; d=open('OUT.pdf','rb').read(); print(max(len(re.findall(rb'/Type\s*/Page[^s]', d)),1))"

# 简历图片版(私信用)
chromium --headless --disable-gpu --no-sandbox --hide-scrollbars \
  --force-device-scale-factor=2 --window-size=1224,HEIGHT --screenshot=OUT.png IN.html
# (截图前给 body 加 padding: 44px 52px;HEIGHT 按内容调,避免截断或留白)
```

## 简历写作原则(本次求职季验证有效)

- **主题 bullet**:一个主题=JD 一个核心要求,项目是证据不是主角
- **保数字、删机制**:KPI 数字留在纸上,实现细节留给面试
- **每条 bullet ≤4 行**;Summary ≤5 行且必须包含当前主打牌(如 AI)
- **公司名适配**:投 TikTok 时保留 "TikTok API" 等生态词(亲和牌)
- **可验证资产**:GitHub(lark-daily-digest)、Tableau Public 链接尽量保留
- 简历、CL 日期、Drive 分享链接三者投递前核对一致
