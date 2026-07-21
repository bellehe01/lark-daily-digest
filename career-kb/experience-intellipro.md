# IntelliPro — Product Manager Intern, AI Sourcing(Jun 2025 – Sep 2025)

> 来源:另一会话的完整事实核查(2026-07-18 确认),含来源标签。本页为权威版本。
> 标签:**[Belle-said]** 聊天确认 · **[Belle-deck]** 本人演示稿截图 · **[Claude-inferred]** 推断 · **[Unconfirmed]** 未确认
> ⚠️ 公司拼写:**IntelliPro**(IntelliPro Group,ATS 跑在 hitalentech/APN 平台),不是 "Interlipro"
> ⚠️ 头衔:官方 = **Product Manager Intern**;"AI Product Manager/AI Sourcing" 是简历定位语,背调/正式申请场合用官方头衔

## 一、角色基本信息
- 公司:IntelliPro Group — 招聘/人力服务公司;工具内嵌于其自有 ATS(Jobs/Candidates/Companies/Finance/Report 模块)[Belle-deck]
- 性质:实习 [Belle-said];时间:2025.06 – 2025.09(月精度)[Belle-said]
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
- 与 TikTok/ByteDance(2023–2024)无重叠 ✅;毕业(2025.05)后入职自洽 ✅
- ✅ **9 月边界已确认(Belle, 2026-07)**:IntelliPro 至 9 月上旬结束,Outlandish 9 月中旬入职——无缝衔接、无并行。简历双写 "Sep 2025" 没问题,被问就按此口径答

## 六、明确未提及(面试与写作均不得声称)
- golden-standard 如何构建(谁标、标准、30 人怎么选)——**面试若被问,需 Belle 提前回忆或准备诚实说法**
- $0.0075 路径中 cache/batch 的作用(deck 仅写换 GPT-5-mini;cache 是搜索提速,与成本无关)
- pilot 之后的状态(转正式/停掉均未知)
- recruiter 具体反馈(无原话、无满意度/采纳率)

## 七、角度标注
- **AI PM**:最强对口(设计+rubric+prompt+评估+模型选型)
- **AI Product Builder/应用 AI**:适用,带"工程写代码"的诚实边界
- **LLM 评估/数据**:nDCG golden-standard 评估是稀缺差异化信号
- 纯运营/增长岗:弱相关,一般不上简历
