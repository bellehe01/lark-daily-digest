# IntelliPro — Product Manager Intern, AI Sourcing(May 2025 – Sep 2025)

> 来源:另一会话的完整事实核查(2026-07-18 确认),含来源标签。本页为权威版本。
> 标签:**[Belle-said]** 聊天确认 · **[Belle-deck]** 本人演示稿截图 · **[Claude-inferred]** 推断 · **[Unconfirmed]** 未确认
> ⚠️ 公司拼写:**IntelliPro**(IntelliPro Group,ATS 跑在 hitalentech/APN 平台),不是 "Interlipro"
> ⚠️ 头衔:官方 = **Product Manager Intern**;"AI Product Manager/AI Sourcing" 是简历定位语,背调/正式申请场合用官方头衔

## 一、角色基本信息
- 公司:IntelliPro Group — 招聘/人力服务公司;工具内嵌于其自有 ATS(Jobs/Candidates/Companies/Finance/Report 模块)[Belle-deck]
- 性质:实习 [Belle-said];时间:**2025.05 – 2025.09**(Belle 2026-07 修正:5 月开始,与毕业月重叠属正常)
- ⚠️ docx 简历(belle-he-resume-ai-product-builder.docx)写的是 "Jun 2025 – Sep 2025",与修正后不一致,**下次改版时更新为 May 2025**
- **团队:Belle + 3 名工程师;直接汇报 CTO 和 CEO** [Belle 确认]——初创直报高管,是好细节
- 分工:她主导产品/系统设计、亲写 scoring prompts、亲跑离线评估;代码实现与工程合作 [Belle-said]
- 地点/远程、公司规模:[Unconfirmed]

## 二、项目:AI Sourcing Tool(0→1)
一句话:内嵌 IntelliPro ATS 的 AI 候选人 sourcing 功能,JD → 打分排序的 LinkedIn shortlist。

**痛点** [Belle-deck]:招聘官人工读 JD、搜 LinkedIn、手工筛排;技术痛点:技能抽取与 LinkedIn 搜索冲突(技能太泛→大量无关;AND 连接→结果过少)、搜索速度、排序质量 vs 成本。

**她做的**:
- 主导 sourcing 系统产品设计 [Belle-said]
- 设计多智能体 LLM pipeline:JD parsing / seniority / skill / location 专职 agent("Tax Director"→正确 seniority 词;"Palo Alto"→SF Bay Area→West Coast→US)[Belle-deck];拆分动机:LLM 长输入理解衰减、多目标 prompt 注意力分散 [Belle-deck]
- 设计 6 维加权评分 rubric 并**亲写 scoring prompts** [Belle-said + deck]:Skills 0.5 / Core competencies & depth 0.15 / Domain match 0.1 / Seniority & scope / Education 0.1 / Progression & longevity 0.05
- **亲自跑离线评估**(nDCG@30 对 golden-standard)和 8+ 模型 benchmark [Belle-said + deck]
- LinkedIn batch search + search cache(提速用)[Belle-deck]
- ❌ 本项目**没有 RAG/embedding 检索组件**,不得声称

**模型池** [Belle-deck]:GPT-4 / 4.1 / 5 / mini 系列、Gemini 2.5 Flash / Pro、DeepSeek V3 / R1、Qwen 3

## 三、数字台账(注意两组验证集不能混!)
| 数字 | 含义 | 来源 |
|---|---|---|
| 94.54% / 93.33% | nDCG@30,GPT-4 with rubric,Job 8038 / 9527(**共 2 个岗位**) | Belle-deck 原文 |
| "~94% nDCG" | 四舍五入的简历写法,底层属实 | 加工 |
| 98%+ | Top-30 与招聘官人工排序重合率,**验证于 5 个 JD**(与 nDCG 的 2 岗是两组不同验证) | Belle-deck 原文 |
| 30 | 每岗 golden-standard 标注候选人数 | Belle-deck |
| $3.95 / $8.45 per JD | 成本 @200 / @500 候选人 | Belle-deck 原文 |
| "~$4–8 per JD" | 区间概括,底层属实 | 加工 |
| $0.2/JD、$0.015/person | 解析单价(UI 解析 $0.015 为**预估**) | Belle-deck |
| $0.0075/person | GPT-5-mini **潜在优化,未落地** | Belle-deck |
| 1 / 1 / 1–5 / 2–3 min | 分阶段耗时(解析/条件/搜索/排序;UI 打分未计时) | Belle-deck |
| "~5–10 min 端到端" | 由分阶段加总推断(docx 简历用了此写法,可保留);**面试口径已定(Belle 确认):报分阶段耗时——解析 1 分钟、搜索 1–5 分钟、排序 2–3 分钟** | Claude 推断+口径已定 |
| 50 | 每 JD 返回推荐候选人数 | Belle-deck/截图 |

## 四、诚实红线
1. **上线状态**:staging/试点/demo,有部分真实顾问在测试 [Belle-said]。❌ "shipped to production/全量上线";✅ "piloted inside IntelliPro's ATS, tested by working recruiters"
2. **代码归属**:她主导设计+prompt+评估;代码与工程合作。❌ "solely built/单枪匹马";✅ "designed and drove; wrote the prompts and ran the evaluation; built with engineering"
3. **结果归属**:性能是团队产出;✅ "the tool reached 94% nDCG; I designed the rubric and ran the evaluation"
4. **规模**:真实使用人数/岗位量/公司规模均未确认,❌ 编任何数
5. **成本**:$0.015(UI)是预估、$0.0075 是未落地优化,❌ 当实测
6. **验证集**:nDCG 基于 2 岗、重合率基于 5 JD,❌ 混为一谈
7. **头衔**:官方 Product Manager Intern

## 五、时间线
- 与 TikTok/ByteDance(2023–2024)无重叠 ✅;2025.05 毕业当月入职 IntelliPro,自洽 ✅
- ✅ **9 月边界已确认(Belle, 2026-07)**:IntelliPro 至 9 月上旬结束,Outlandish 9 月中旬入职——无缝衔接、无并行。简历双写 "Sep 2025" 没问题,被问就按此口径答

## 六、Golden-standard 构建(Belle 2026-07 回忆确认,面试可讲)
- **标签**:每个候选人按 6 维 rubric 各维 **1–5 分**,取**总平均分**作为相关度(graded relevance,天然适配 nDCG)
- **30 人来源**:混合——该 JD 的搜索结果取样 **+** 历史上实际推进过的候选人(有真实结果做锚)
- **谁标**:**Belle 和 recruiter 各标一遍,然后对齐**(交叉标注,有 inter-rater 校验意识——面试加分点)
- **两组验证的关系**:5 个 JD 都有 recruiter 人工排序(用于 98%+ 重合率);其中 Job 8038、9527 标注最完整,单独用于 nDCG@30
- **@30 的依据**:recruiter 实际工作中一般看前 30 个候选人(业务合理性,非拍脑袋)

**面试标准答案(中)**:"评估集是我设计的:每个岗位选 30 个候选人——搜索结果取样加上历史真实推进过的候选人——我和 recruiter 各自按 6 维 rubric 每维 1 到 5 打分再对齐,取平均分作相关度标签。选 nDCG@30 是因为 recruiter 实际只看前 30 个,而 nDCG 同时惩罚漏掉好候选人和排序错位,比准确率更贴近 sourcing 的真实目标。"

**EN**: "I built the golden standard myself: 30 candidates per job — sampled from search results plus candidates who had actually advanced historically. A recruiter and I labeled independently on the 6-dimension rubric, 1–5 per dimension, then reconciled; the averaged score became the graded relevance label. I chose nDCG@30 because recruiters realistically review about 30 candidates, and nDCG penalizes both missing good candidates and misordering them — closer to the real sourcing objective than plain accuracy."

## 七、仍然未提及(不得声称)
- $0.0075 路径中 cache/batch 的作用(deck 仅写换 GPT-5-mini;cache 是搜索提速,与成本无关)
- pilot 之后的状态(转正式/停掉均未知)
- recruiter 具体反馈(无原话、无满意度/采纳率)

## 八、角度标注
- **AI PM**:最强对口(设计+rubric+prompt+评估+模型选型)
- **AI Product Builder/应用 AI**:适用,带"工程写代码"的诚实边界
- **LLM 评估/数据**:nDCG golden-standard 评估是稀缺差异化信号
- 纯运营/增长岗:弱相关,一般不上简历

## 九、面试介绍稿(2026-07 定稿)

**nDCG@30 一句话解释**:"nDCG 衡量排序质量——把人工标注的理想排序当满分,我们系统能拿到约 94%;@30 是只看前 30 名,因为顾问实际只看前 30;offline 表示这是用标注集做的离线验证,不是线上实验。"比准确率更适合 sourcing:同时惩罚漏掉好候选人和排序错位。

**90 秒完整版(AI/PM 岗)**:
> S:IntelliPro 是招聘科技公司,有自己的 ATS。我是 AI Sourcing 方向的 PM 实习生,团队我加三个工程师,直接向 CTO 和 CEO 汇报。
> T:顾问 sourcing 纯人工(读 JD、搜 LinkedIn、手工筛),慢且标准因人而异。目标:0 到 1,输入 JD 自动产出可用的候选人 shortlist。
> A:三块——①系统设计:多智能体 LLM pipeline,JD 解析/seniority/技能/地点专职 agent(单一大 prompt 注意力分散;Palo Alto→Bay Area→West Coast 泛化);②评估体系(核心贡献):6 维加权 rubric(技能占一半),scoring prompt 亲手写;golden standard 自建——每岗 30 人、与 recruiter 独立标注后对齐、每维 1-5 取平均;nDCG@30 离线约 94%,另 5 岗前 30 重合率 98%+;③模型选型:8+ 模型质量/成本 benchmark,单岗约 $4-8。
> R:自家 ATS 内试点、真实顾问在用;解析约 1 分钟、搜索 1-5 分钟、排序 2-3 分钟。收获:AI 产品的核心不是调模型,而是定义"什么叫好"并让它可度量。

**30 秒简短版(内容运营岗被顺口问起)**:
> "毕业后先在一家招聘科技公司做了段 AI 产品 0-1:带三个工程师做 AI 候选人排序工具,我负责产品设计和评估体系,直接向 CTO/CEO 汇报,排序质量离线验证约 94%。最大沉淀是评估思维——怎么把'好'变成可度量的标准;后来在 Outlandish 做 creator 推荐引擎直接复用了这套方法。"(结尾句刻意桥接 creator 工作,防"跑题"感)
