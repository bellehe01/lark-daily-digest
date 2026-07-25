# Outlandish(现职)— 项目弹药库

**公司**:Outlandish,美区 TikTok Shop 代理(agency),startup 节奏
**时间**:Sep 2025 – Present
**官方头衔**:Senior Data Analyst,**所属 AI Development Team**(2026-07 精确版;背调核头衔+时间,团队名几乎不核;后缀描述可按人设变化,见 personas.md)
**全流程 ownership(2026-07 本人确认,AI PM/Builder 人设核心弹药)**:作为 AI Product Builder 搭建 Creator Operation System,全链路一人负责——AI agent/workflow/system 概念设计 → **用 Claude 辅助 coding** → **Railway/Laravel 部署** → 用户教育(SOP/培训)→ **观测使用指标** → 收集用户反馈持续迭代。价值点:不是"会用 AI 的分析师",而是"从概念到部署到运营指标闭环的 builder";AI 岗面试讲"我自己观测 adoption 指标来决定迭代方向"是稀缺信号
**协作面**:直接对接 C-suite;横跨 BD、Operations、Legal、Finance、US/UK region 团队
**服务对象**:内部团队(AM/Ops/Finance 等)+ 外部(brand 客户、creator/sponsor)——内外兼有,不是纯 internal

---

## P1 · Creator CRM(0→1)
- 管理 **44,000+ creators** 及其品牌 campaign 全生命周期:onboarding、GMV-based tiering/segmentation、recruitment、video-performance tracking、per-campaign P&L
- 公司 account/ops 团队的 operating backbone
- **角度**:DA=数据资产;PM=0→1 产品;Ops=生态运营底座;Support=被支持的核心平台

## P2 · AI 规划工具
- 把 campaign 表现数据转成每个品牌的月度 creator 策略 + GMV 目标
- **Pilot 故事**(PM 人设用):先小范围 AM 试点→按反馈迭代→推广 **300+ brands**
- 规划周期 **~1 个月 → 7 天**
- 背后是公司 **single source of truth** 报表体系 + client-facing **monthly benchmark**(US/UK)

## P3 · 推荐引擎
- **LLM pain-point tagging(=labeling/categorization)+ GMV-weighted scoring**
- 为品牌匹配已验证的 creator,替代人工跨渠道搜索;一次性合作→长期关系(生态健康角度)

## P4 · SCF(Social Commerce Festival)check-in & tiering 平台
- 5,000+ TikTok creators 与品牌对接的线下活动
- **痛点链**:按 creator handle 人工查 GMV 分 Tier → 3,000+ creator 两周查不完 → **20+ creator 提交 technical support ticket** 投诉 tier 错误
- **方案**:Eventbrite webhook + TikTok API,报名即自动分级入库;AI vision 读 GMV 截图核验
- **结果**:check-in 排队 **4 小时 → 20 分钟**;工单类别消灭
- 另含:creator training + 现场实时支持(高压场景素材)
- **这是支持岗的王牌 STAR 故事**(工单激增→根因→自动化→类别消灭)

## P5 · 指标自动化(250h 故事的真实出处)
- 原状:AE 人工从 TikTok 摘 GMV/Ads Spend/AOV 填 tracker,频繁漏填错填,需专人盯
- 方案:TikTok API 直连,自动更新各品牌看板
- 结果:**~250 小时/月**人力消灭 + 一整类数据错误消灭
- ⚠️ 面试会被问 250h 怎么算的:AE 人数 × 每日耗时,提前把账算顺

## P6 · Weekly report 自助编辑
- 痛点:**30 个用户里 5 人**先后提出同类需求(不同 account 需要不同排版/内容/格式)
- 方案:自由编辑功能——拖拽模块排序、自助添加模块
- 结果:该类请求归零
- **角度**:Support=复盘共性需求→产品化;PM=用户反馈→功能决策

## P7 · AI 会议 pipeline(公司 repo creatorsamples_web,代码验证过的事实)
- Laravel Artisan 命令 `meetings:sync-weekly`,**每 30 分钟**自动跑,端到端无人工
- 链路:Lark Calendar API(14 天滚动窗)发现会议 → 4 层模糊匹配归属品牌 → VC/Minutes API 拉带发言人的官方转写 → LLM 按严格 JSON 提取 summary(2-4 句)+ action_items(含 assignee_name、due_date)→ Lark Task v2 自动建任务并指派(人名 ILIKE 模糊匹配到 open_id,失败回退店铺第一个 AM)→ 每天 06:00 把任务完成/删除状态回同步 DB
- 工程细节:owner-first token 轮换链(AM→CGL→LSM→LSS→AE→4 个全局兜底)、分级退避(3×30min → ≥6h 间隔 → 5 次标记 unavailable;token 过期单独计数 48 次提示重授权)、JSON 校验+降级、事务化写入;核心代码 **~3,260 行 PHP + 10+ 测试文件**
- tasklist 无法自动匹配时发交互卡片给指定负责人(配置注释=Belle He)选择
- 🔴 红线:模型是 **google/gemini-2.5-flash-lite via OpenRouter**(代码方法名叫 callClaude 是误导)→ 简历/面试只说 "an LLM";摘要只展示在内部 Ops SPA,**不发群不发邮件**

## P8 · Lark Daily Digest(给 C-suite 做的,开源)
- https://github.com/bellehe01/lark-daily-digest —— **唯一可公开验证的作品**
- 每工作日早晨 LaunchAgent 自动跑:扫全部 Lark 群聊(24h,周一 72h)→ **一次 Claude API 调用**(此处真的是 Claude:claude-sonnet-4-6)对所有群做 🔴🟡🟢 紧急度分诊 → 提取每群一句话摘要 + Key Decisions + Action Items → 组装 Lark 交互卡片发 DM
- 工程:15 分钟超时守护、失败重试、JSON 校验、降级 fallback、日志
- 打包成 Claude Code skill,同事可向导式一键安装(个人工具→团队工具的产品化)
- **角度**:Support=triage 同构;AI=分诊/提取/路由完整链;PM=发现高管痛点→产品化→推广

## P9 · 日常用户支持(用户口头确认的事实)
- **10–30 条咨询/天**;渠道:多个(chat + 内部平台/IM)
- 用户构成:内部团队(AM、Ops、Finance)+ 外部 brand/creator 合作方
- 问题分类:数据不一致、权限、工具报错、操作咨询(四类都有)
- 响应:基本秒回;绝大多数当天解决;跟进确认;是最终解决方(几乎全部自己解决),懂 escalation
- 固定复盘:确认解决 + 定期总结高频问题改工具/流程
- 认可:用户和领导都多次认可响应速度(非正式 CSAT)
- 配套:SOP、user guides、内部培训(BD/Ops/Legal/Finance/regional)、role-based dashboards

## P10 · BD Proposal Agent(RAG 提案推荐系统,代码验证+本人确认 2026-07)
- Repo:github.com/bellehe01/BD_Proposal_Agent(⚠️ 含真实客户 proposal PDF——Honeylove/Skims/CNKR 等,**若为 public 需立即转 private**)
- **本人确认的业务事实(2026-07)**:用户=BD 团队 **5 人**,已实际用起来;一份 proposal 起草 **~2 小时 → 15 分钟**;**每周产出 ~5 份**;赢单率提高(定性,无数字勿量化)+ 客户赞赏;构建于 **~2026 年 3 月**
- 语料:历史 proposal 库 + case study 库 + 公司数据(与代码一致:pages.jsonl / case_studies.jsonl / markdown proof library)
- **~14,000 行 Python(18 个模块;核心四件 recommend/annotate/web_app/ingest 约 9,400 行)** + Web UI(stdlib http.server + vanilla JS)+ Dockerfile + 中英文档(含中文团队同步文档)
- **链路**:PDF 提案库 → 页级 ingestion(pdftotext/pdftoppm,OCR 三档 off/fallback/full)→ **多模态页面理解**(slide 渲染图+抽取文本 → summary/tags/section/evidence/confidence,prompt 含反幻觉约束)→ deck+page 双层索引 → 结构化 brief(公司/行业/痛点/预算/时间线/市场)→ 策略建议 + proposal 骨架 + **每页配历史参考 slide** + 改写建议 + case proof → PPT 导出
- Scenario heuristic builder:离线 LLM 合成可复用路由场景(默认 gpt-5.4);标注/合成用 gpt-4.1-mini(OpenAI/OpenRouter)
- **Whole-context 对照实验**:专设"整库进 context"实验路径作为 retrieval-first 的受控反例(token 成本/噪声/失败模式分析)——评估思维实证
- 🔴 红线(embedding,已澄清):架构文档设计了**混合检索**(metadata 过滤+词法匹配+embedding 语义相似度),并把 embedding retrieval 列为 **V2 路径**;**当前实现是 V1(结构化标注+词法/启发式),embedding 未落地**。✅ 可说"设计了含 embedding 语义层的混合检索架构,V1 落地 metadata+词法,embedding 是规划的 V2";❌ 不可说"用 embedding 检索找相似案例"(实现层面不成立)
- 角度:AI PM(架构决策+对照实验)、RAG 应用、多模态文档理解

---

## Portfolio 候选案例(problem → build → impact 三段式)
1. **AI 会议 pipeline**(最完整的工程叙事,但注意公司代码不可展示,讲架构图即可)
1.5 **BD Proposal Agent**(RAG+多模态,~14k 行,有对照实验——转 private 后可用脱敏架构图讲)
2. **Lark Daily Digest**(可直接放 GitHub 链接,唯一可公开 demo)
3. **SCF 自动化**(最好的业务故事:工单→根因→自动化)
4. **250h 指标自动化**(ROI 最直观)
5. **推荐引擎**(AI/算法叙事)
- 可展示资产:GitHub repo、Tableau Public、(架构图/流程图需新画,不可截公司系统)

---

## 面试介绍稿——TikTok LIVE Content Ops & Creator Growth 岗定制(2026-07 定稿)

**开场定位(15 秒)**:"Outlandish 是美区 TikTok Shop 的 agency,服务 300 多个品牌。我的官方 title 是 Senior Data Analyst,但实际工作横跨数据、内部产品和创作者运营——一句话概括:我负责让 44,000 个 creator 的运营规模化。"

**三块主体(50 秒)**:①生态底座——0 到 1 建 Creator CRM,44k creator 全生命周期(招募/onboarding/GMV 分层/视频表现/单 campaign P&L),account 和运营团队的操作底座;②策略层——AI 规划工具(campaign 数据→每品牌月度 creator 策略和 GMV 目标,300+ 品牌,规划 1 个月→7 天)+ creator 推荐引擎(LLM 打标签 + GMV 加权评分,一次性合作→长期关系);③线下/campaign——5,000 人 creator 活动的 creator 侧运营(培训/现场支持/自动 check-in 分层,排队 4h→20min)。

**收尾桥接(20 秒)**:"agency 侧最大的收获是看到平台策略在 creator 端真实落地的样子——creator 为什么接单、为什么流失、什么激励真的有效。我在字节做过平台侧 creator 运营,现在补上了生态另一侧的视角;两边都待过的人知道政策落到 creator 身上哪里会变形——这是我想带回平台侧的东西。"

**追问①"44k 怎么管得过来"**:"不是人管,是系统管。CRM 自动按 GMV 分层、数据驱动触达,人力只花在头部和例外。和我在字节做垂类作者运营同一套逻辑——那时每垂类深耕 20 个头部、社群活动覆盖腰部;现在规模放大三个数量级,把'人'换成 CRM 和自动化。"(与图文"1v1 规模化"答案同构,方法论前后一致)

**追问②"为什么离开 agency 回平台"(几乎必问)**:"agency 让我看到几百个品牌、几万个 creator 的微观真实,但杠杆终究是一家公司的;平台一个策略、一个功能影响整个生态。两边都做过后,我更确定想做生态级的 creator growth。而且 agency 视角是我的差异化——我知道平台的政策和产品到了 creator 手里哪些好用、哪些会变形。"

**追问③"最大挑战"**:SCF 故事(3,000+ 积压、20+ 投诉工单 → 手动止血 → webhook+API 自动化根治 → 4h→20min、工单类别消灭)。

**全场锚点句**:creator 运营的规模化 = **标准 + 分层 + 自动化,人力只花在头部和例外**——所有 creator 相关问题都往这句收。

## "失败经历"定稿——SCF 人工分层方案(2026-07 本人确认参与方案制定)

> **S**:5,000 creator 线下活动,按 GMV 分层定权益/通道。最初人工方案(按 handle 逐个查 GMV 填表)**我参与制定**,当时觉得报名陆续来、人工查得过来。
> **T**:报名远超预期,两周积压 3,000+ 没查完;人工出错,20+ creator 提工单投诉分错层级——活动未开,信任先受损。失败根源:**方案没算过账**。
> **A**:止血——逐个复核投诉、道歉修正,优先高层级/已确认行程的 creator;根治——意识到加人手补不完(错误率随疲劳涨),用报名 webhook + TikTok API 自动拉 GMV 入库分层 + 自动核验,整体替掉人工。
> **R+教训**:check-in 4h→20min,该类工单消灭。教训:**上规模流程定稿前必须做容量测算(峰值×单条耗时),这笔账当时没人算,我也没算,这是我的责任**;由此养成"先算账再承诺"——250h 自动化、拍转编倒推公式都是这个习惯的延续。
**追问**:①为何选人工 → 系统不打通、接 API 有开发成本、"一次性活动"错觉;本质是低估规模和错误率、高估人力弹性;②个人错在哪 → 方案期没提容量账;积压后先想加人硬扛,转自动化转晚了;③教训怎么用 → 250h、倒推公式。
**⚠️ 战术**:SCF 有"最大挑战"(成功版)和"失败"两个取景,**同一场面试只用一次**;若已用成功版,失败题切备胎——Music 小样本错误洞察(发过基于个位数消费歌单波动的错误 insight → 被质疑 → 加最小样本过滤并写进看板注释)。
