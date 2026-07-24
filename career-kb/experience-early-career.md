# 早期经历(三段实习)

## TikTok · Product Manager Intern, Effect Creation Tools Team(Jan 2024 – Jun 2024)

> **2026-07 本人补充(热点/内容策略角度)**:特效工作与内容策略强相关——日常**分析热点**、**追热点**来做/优化投稿工具、**造热点**(如 S 级特效上线)。
> **2026-07 工作实证已接入**(三批截图 + 1 份 PDF,内部文档 L2 级;⚠️ 同红线 #13:仅个人使用,面试讲方法论不报内部数值)。

**T1 · 特效迁移 pipeline 疏通**
- 诊断 QA、ETL、模型过滤器三处失败点;重构数据流
- 系统吞吐 **400x**;恢复推荐侧特效供给
- 角度:技术排查+工程协作(支持岗);数据流诊断(DA);unblock 高优项目(PM)

**T2 · 次世代特效资产库(0→1)**
- 上线 **4,000+ 分类资产**(beauty/3D/滤镜等);跨 engineering/design/ops/QA/legal
- 提交渗透率 **+38%**;人均内容创作 **+55%**
- **PMF owner**:A/B 测试 + creator 访谈打磨价值主张
- 角度:creative workflow 产品(投广告创意类岗的对口证据);创作者反馈→产品决策(创作者运营岗)

**T3 · 生成模型训练数据**
- 与 AI PM、ML 工程师定义 2D/3D 资产训练集(GAN masks、floral props 等)
- 策划 benchmark 视觉、prompt 库,把内容"品味"转成视觉质量标准
- 角度:AI 训练数据/模型评估经验
- 实证:《模型目标效果举例》——她整理的模型目标效果样例表(逐条效果视频 + 分类标签 + 可上线判断),即"品味→视觉质量标准"的实物

### 工作实证材料(2026-07 本人提供三批截图 + PDF;⚠️ 内部文档,同红线 #13)

**E1 · TTEH 素材库全周期 owner(对应 T2 的完整证据链)**
- 《Supplying New Assets in TTEH》PRD(她写的):从 AME 向 Effect House 素材库迁移 **2,000+ 新素材**(Face Effects / Screen Effects / Stickers / Filters 四大类)
  - 选品优先级逻辑:已迁 AME 的素材 → 供给不足的品类 → 投稿占比高的品类
  - 成功指标分层:Process Metric(素材供给量)vs Success Metric(投稿量)
  - **双侧 A/B 实验设计**:生产侧(新素材对 TTEH 投稿的影响)+ 消费侧(对发布指标的影响),G0/G1/G2 流量分组
  - 上线 checklist:合规安全、Legal、全量发布等
- 《TikTok Asset library Q1 Review & Q2 Planning》:季度复盘(供给数据、存在问题)+ Q2 规划 OKR(P0/P1 分级、逐项 owner,她任多项 owner)
- 《[AB Report] T1 - AMS 素材分发》:完整 A/B 实验报告(实验组/对照组、显著性分析、上线建议)
- 《TTEH Remaking Project - Q1 Review and Plan》:**设计师项目管理**——收集设计师报告的 EH 功能缺口(Bling 颜色限制、glowing edges、rainbow gradient、slow zoom、色差等)、规划 IE 工程资源支持、设定设计师交付预期(季度结束前一个月交付、自主上传 Loki、**AME/EH 实机验证**——她本人做 PM 实机验证,曾抓出 Neon Wings 翅膀位置 bug 让设计师返工重导)

**E2 · 特效品类供需分析框架(《2024移动端工具能力》她参与的规划文档)**
- 方法论:按品类算 **供给占比 × 投稿占比 × 投稿/供给比(ROI)**,TT 品类与抖音品类各建一张表
- 关键发现:**编辑类供给 ~0.8% 但投稿 ~7%,投稿/供给比 ~9.9,是最被低估的高 ROI 品类** → P1 重点品类定为美妆/滤镜/编辑;P2 低成本:泛娱乐/游戏/AR
- 竞品对比:AME 基础工具能力已对齐竞品,gap 在 **interaction 玩法组合**与**素材丰富度(约 1,500 vs 竞品 15,000)**;方向:补齐高频能力/素材、**用 AIGC 生成素材降低制作成本**
- 工具能力效率表:按能力标签算 pub% / vv% / pub-vv 比(2D 人物分割、图片类最高频)
- 附 2024 key metrics 目标 + Q1-Q4 任务拆分
- **面试讲法(安全版)**:"我们用供给占比、投稿占比和两者比值给特效品类排 ROI,发现编辑类严重供给不足,把它提为 P1"——不报内部具体百分比

**E3 · 拍转编(Shooting-to-Editing)搬运链路优化——她署名的策略文档 + 配套链路文档(最硬核的漏斗优化故事)**
- 背景:拍转编搬运路径 **数仓送审 → Loki 过滤 → 测试 → 人审 → 上线**;80%+ 的特效被"开拍触发类"规则过滤,最终上线量仅剩个位数/极少
- 她的《拍转编审核策略优化》(2024-03,署名何贝尔):重设数仓与 Loki 过滤逻辑——数仓取数时去除不适合编辑页的开拍触发类但**保留被误判的美颜美妆类**(靠提示语 Blink eyes/Multi-faces/Show cat 等识别,并指出提示语判断不精确、建议改用道具包参数或 Loki 业务标签);搬运条件 7 天内投稿 top4k;设计 Trending Tab(与拍摄页共用推荐逻辑)与 New Tab(按人审上线顺序)下发逻辑
- 配套《拍转编搬运链路优化-促供给》:**全漏斗量化管理**——倒推公式"每日需上线 4,000 ÷ 审核通过率 80% ÷ 测试通过率 50% ÷ 过滤通过率 64% ≈ 15,625 送审需求";分阶段把送审量 **1,000 → 4,000 → 12,000**;Loki 过滤通过率 **70%→90%**(数据驱动:分析过滤不通过原因分布——定帧类 74.8%、肢体表情触发 12.4%、抠五官 6.7%、声音 3.2%,逐类评估可否放开);测试通过率 **50%→80%**(改内存/帧率阈值);人审 manpower **1 → 13-15**(并测算单人时审 ~90 条);发现"全球 top4k"选品对小国不公平(美国 trending 20+ 条 vs 巴西 7 条)提出分国家拆分
- 协调面:数仓、Loki、测试(QA/EP)、人审五方,逐项 owner + 排期
- **这是 PM/运营面试的王牌 STAR:发现供给瓶颈 → 逐层漏斗诊断 → 改规则/阈值/人力 → 送审量 12 倍**(内部数值面试可讲相对变化,不报绝对值)

**E4 · 编辑特效业务 Landing 文档(她维护的业务入门 doc)**
- 覆盖:编辑特效是什么/功能入口、供给现状(分区域)、用户编辑行为洞察、2023 年项目目标(渗透提升)、协作群、入职权限 checklist——证明她是**编辑特效子业务的实际运营 owner**

**E5 · 数据需求与指标口径(DA 能力实证)**
- 《TTEH asset contribution analysis request 2024 Q2(业务版)》:她写的数据需求文档——指标定义(近 7 日 publish days、特效消费渗透、素材供给等)、产出表 schema(素材 id 主键、一二级 category、icon_url 等)、Hive 表与看板链接
- 《TikTok素材库看板指标口径(业务版)》:AME/TTEH 两套指标字典 + 素材等级定义——证明她定义并维护指标口径
- 《特效实习生|工作交接》:完整交接文档(事务工作、资料汇总、竞品对比、审核判定)——收尾专业度

**特效段落面试金句素材**:①"投稿/供给比"品类 ROI 框架;②拍转编五层漏斗逐层通过率优化;③设计师实机验证抓 bug;④双侧(生产/消费)A/B 设计;⑤AIGC 降本方向判断(2024 年初就提出)

## TikTok · Content Product Operations Intern(Data Track), Music Team(Aug 2023 – Jan 2024)

> **2026-07 本人更正:官方岗位名为 "Content Product Operation - Data Track"**(此前简历写 Data Analyst Intern)。职责本质:分析歌曲热度为歌单内容提建议,并以此优化产品功能(如 New Release)。内容运营类岗位用新头衔;纯数据岗可继续用 Data Analyst 表述(两者都真实,Data Track 即数据方向)。
> **2026-07 工作实证已接入**(两批截图,L2-内部;⚠️ 同红线 #13)。**五个市场确认为 BR/ID/MX/AU/SG**(巴西/印尼/墨西哥/澳洲/新加坡)。

**D1 · New Release 本地化策略**
- 5 个市场;内部用户数据 + 竞对基准(Spotify、Apple Music);与设计迭代 UI/内容位
- CTR **+20%**;平均收听时长 **+13%**
- 角度:内容趋势与竞对监控(运营岗);跨区协作

**D2 · 大规模数据分析**
- SQL/Python 分析 **5M+** 歌单记录;data profiling + validation 保准确
- 周报洞察给跨区编辑团队;策展时间 **4 天→2 天**;WAU **+18%**
- 角度:SQL 规模证据(所有岗通用)

**D3 · 自助 Tableau 看板**
- 监控 playlist WAU、平均收听时长;drill-down 交互;(原始简历提到 DAX)
- 实时可见性提升;ad-hoc 数据请求 **−70%**(= deflection 思维的证据)

### 工作实证材料(2026-07 本人提供两批截图;⚠️ L2-内部,同红线 #13)

**M1 · TTM Content Consumption Overview 看板(owner 显示 hebeier——她本人建的)**
- 覆盖 BR/ID/MX/AU/SG 五市场、近 7 天滚动:语言流媒体占比(含 WoW 变化)、Top streamed songs/artists/genres/album genres、Top moods & activities、Scene/Mood/Theme 消费数据(按 tag 过滤,如 Happy)
- **New Release 专属 tab**:new release(last 3 months)与 all time release 分国家对比,指标含 play_track_cnt、collect_track_cnt、**stream duration/UV、finish rate、skip rate**——这就是 D1"New Release 功能优化"的数据底座;能看出印尼 finish rate 最高、墨西哥/澳洲 skip rate 偏高等市场差异(内部数值不外报,面试讲指标设计与市场差异洞察)

**M2 · Current Release Dashboard(owner hebeier)**
- Track Release 元数据表(UPC/ISRC/label/distributor/genre,可按 Artist Priority 等筛选)+ Daily/Weekly streams(EN 与 ALL 口径分开)+ TOP 100 streamed tracks——新歌发行监控的完整链路

**M3 · TTM Playlist Key Metrics Dashboard(owner hebeier)**
- Playlist Performance / Track Performance / TAGS 三 tab;指标体系:WAU(listen+1min user)、MAU、Impressions、Streams、Collects、Average Play Duration、skip rate、finish rate、Stay Duration Per Subscriber,均带 WoW 与趋势小图
- 她在看板里写了**使用注释**(如何调 filter 查任意周/月的活跃数;提醒"个位数消费的歌单会造成剧烈数据波动,可用过滤器排除低消费歌单")——自助看板 + 用户教育,即 D3 "ad-hoc −70%" 的实物

**M4 · 跨市场内容洞察产出**
- 《Top Consumed Genres/Searches/Tracks/Artists in Each Market》看板 + 《TTM Top Tracks/Playlists/Genres/Searches/Artists》词云 dashboard(5 Markets Dashboard):Top genres/tracks/artists/EN search queries
- 《Top consumed Genres/Scenes/Search queries》电子表:**五市场 × Top20 genre 排名矩阵**(高亮跨市场共性 genre)——"本地化策略"的分析实物(BR 重 Sertanejo/Baile Funk/Forró,ID 重 Indo Pop/Dangdut,MX 重 Latin,AU/SG 偏 Pop/EDM/Hip Hop 等结构差异)
- 《Insights of Top 50 WAU playlists (GPT)》**周度洞察报告**:popular genres/categories 分布、更新时间分布、Metrics Rising Playlists(WoW)、**Playlists to be updated 建议清单**+文字 insights——**"歌曲热度分析→歌单内容建议"的直接证据**,且标题带 GPT(2023 年即用 GPT 辅助分析,可作早期 AI 应用素材)

**M5 · Musixmatch 竞品调研(她写的文档,2023-09)**
- 拆解 Musixmatch 的用户/艺术家双边服务、歌词分发链路(Instagram/Apple Music/Tidal/Google 等)、社区贡献机制、歌词上传全流程规范(Transcription/Sync/Format/Structured 段落标注/Performer 标注规则)——竞对产品机制研究能力实证

**M6 · 内容供给项目文档**(截图分辨率低,细节待补;如需入库请发可读版本)

**Music 段落面试金句素材**:①指标体系设计(finish rate/skip rate/stream duration per UV/stay duration per subscriber 张口即来);②五市场 genre 结构差异驱动本地化(BR Sertanejo vs ID Dangdut);③周度 Top50 WAU playlist 洞察 → 歌单更新建议的运营闭环;④2023 年就用 GPT 辅助歌单洞察

## ByteDance · Product Operations Intern, Photo & Text Community Team(Jan 2023 – Aug 2023)

> 本地资料夹 `/Users/ahs/Desktop/抖音图文` 待接入。
> **2026-07 增补:本人提供了当时的完整岗位描述+OKR 截图**——岗位实为**抖音图文中台的内容产品运营**(内容产品运营实习生),为图文内容生产、投稿活跃、优质度等结果指标负责;基于重点垂类与作者分析制定**分行业目标内容和作者增长策略**。本人确认覆盖垂类含 **Beauty、Fashion & Lifestyle**(通过策略、创作者分级、campaign 等手段激励垂类创作者发布)。

**B1 · O1 图文作者运营(垂类创作者增长)**
- 建设图文中台运营能力;**定义和识别优质内容/作者**;策略流量扶持、作者教育、投稿活动、**1v1 帮扶机制、社群运营**,沉淀图文作者成长解决方案
- 结果:活跃图文作者投稿频次 **1.35%→1.48%(+10%)**;**垂类 vv +7%**
- 角度:垂类创作者增长策略(内容运营岗核心证据);creator lifecycle/education/campaigns

**B2 · O2 图文产品运营(产品杠杆)**
- 完善图文运营的产品能力建设;**跑通与上游的合作机制(醒图 Xingtu、相机 Camera、主端)**
- 建立**潜力图文内容挖掘能力**、支持单图和多图的**图文投稿模板**、**个人页挑战推全**及其他杠杆性产品链路试点
- 结果:带动图文投稿量 **+7%**(模板 A/B 验证,投稿渗透 +0.2%)
- 角度:产品工具撬动内容供给;跨上游团队推动

**B3 · 内容治理体系**
- 用历史审核数据 + 行为流失信号,主动拦截低质/违规内容
- 高风险曝光 **−12%**;信任指标提升
- 角度:**Trust & Safety / Platform Responsibility 的唯一直接证据**(投 T&S 相关岗必放首位)

**日常方法论(截图原文)**:发现问题、拆解问题、解决问题,持续提升运营数据指标;协同上下游同事/部门推动业务按时按质上线

### KR 级细节(2026-07 本人提供,面试深挖弹药——不上简历)
**O1 作者运营四条 KR:**
- KR1 定义与识别:在图文优势垂类明确优质内容标准(**"有用&好看"**),厘清进审链路和标注流程,明确账号识别手段
- KR2 策略运营:对识别出的优质内容/账号做流量策略扶持(提稿均 vv 和稿均互动);策略圈定优质作者群体,**站内信触达 + 作者服务** → 投稿频次↑10%
- KR3 活动运营:组织/包装多场投稿活动,提升作者对平台引导内容的感知
- KR4 用户运营:建立垂类 **1v1 帮扶机制**和核心作者社群;以**摄影/艺术为切入点**,每垂类找 **~20 个头部示范性作者**做诊断赋能(解决投稿灵感、审核/分发链路问题),深度合作沉淀成长方案

**O2 产品运营三条 KR:**
- KR1 投稿模板:搬运醒图单图模板上线推全,A/B 投稿渗透 **+0.2%**;挑战支持单图模板,**带动 1% 图文投稿量**;按季度监控站内外优质投稿形式定模板方向
- KR2 个人页运营:挑战功能推全 + 实验运营策略,A/B 渗透 **+0.4%**、人均投稿数 **+0.5%**;资源管理规则 + **盖亚系统对接**,**点击-投稿转化率 2%→2.1%(+5%)**,图文投稿量 **+5%**
- KR3 价值探索:热点 case 标准对齐,**policy diff 占比 25%→5%**;收藏复访价值分析;**醒图一键同步投稿**可行性 + 用户画像摸底(醒图对大盘图文投稿量贡献 **4.67%→6%**);电商评价转投稿冷启激励(经验决策比 **1%→1.05%**)

**面试金句素材**:①"优质内容标准 = 有用&好看"(标准定义能力);②每垂类 20 个头部示范作者的 1v1 诊断(creator lifecycle 精细化);③点击-投稿转化率、渗透率、policy diff 这些指标名张口即来(证明真做过内容中台)

### 工作实证材料(2026-07 本人提供截图;⚠️ 内部文档 L2/L4 级,仅限个人记忆唤醒与面试口头准备,严禁公开/入 portfolio/报内部具体数值)

**① 垂类筛选分析框架(L4-机密表格《图文重点垂类筛选》——她本人建的分析工作簿)**
- 指标体系:**图文不可替代 VV 占比 × 赛道规模(垂类图文 VV 占大盘比)× 经验决策稿均 vv**
- 输出:一级/二级垂类分类 + **高/低消费 × 高/低价值四象限**(如"低消费图文高价值类")→ 决定重点垂类投入
- 这就是 KR4 "以摄影/艺术为切入点"的数据依据(摄影摄像类不可替代占比最高)
- **面试讲法(安全版)**:"我建了一个垂类优先级框架,用图文不可替代性、赛道规模、单稿效率三个维度筛选重点垂类,摄影/艺术因不可替代性最高被选为切入点"——**不报具体百分比**

**② 优质内容标准落地(L2-内部周报《个人工作记录》)**
- 亲手把"有用&好看"操作化为**"精美图片"标注标准**,四维:生态要求(无违规、非 AIGC——CG 人物除外)/营销感要求(无挂车、团购券锚点)/质量要求(主体精美整洁、构图精致、色调明亮、无过度曝光美颜滤镜)/**情绪价值**("美"的享受、愉悦感)
- 亲手执行**二级垂类标注**;标注"挑战单图&多图模板是否编辑过"(文字二次编辑/加文字元素/贴纸)→ 推动产品明确 Q3 上线功能(编辑功能+多图模板)
- **站内外新型创作形式监测**(抖音 5-6 月经验决策内容 + XHS):识别照片压贴图、文压图、纯文本类(PPT/备忘录)、优质拍图+emoji 分段长文案、拼图攻略、趣味图片模板之外的新形式 → 反哺投稿链路产品需求/模板需求
- 起草《Q3 激励"精美图片"活动方案 1.0》
- **对 AIGC/标注类岗位是黄金素材**:标准定义→标注执行→标注结果驱动产品决策,完整闭环

**③ 投稿主题特刊(清明节 VOL.01)**
- 她策划/制作的创作者投稿灵感特刊:按主题标签(清明美食/养生/假期小记/去哪玩)组织示例内容+参与讨论 CTA
- KR3 活动运营的实物证据;展示内容策划/编辑包装能力

**④ 待处理**:CV 长图里出现两段未入库经历——**鞋类品牌运营实习生**、**数据分析实习生(零售)**,截图分辨率不足以提取细节;如需入库请单独发可读版本

## 取舍规则(按人设裁剪)
- 空间紧张时优先砍:T3(除非投 AI 岗)、D1(除非投内容/运营岗)、B3
- B1 vs B2 二选一规则:创作者增长类岗留 B1,平台治理/支持类岗留 B2
- T1、D2、D3 几乎所有岗位通用,默认保留
