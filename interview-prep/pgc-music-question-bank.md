# PGC Music Product Operations (Copyright Solutions) 面试预测题库

> 2026-09 建档。框架来自小红书面试准备法:① 自我介绍(强JD定制) ② 高频问题预测 = a.简历深挖 + b.业务场景情景模拟。
> 数字口径一律以 career-kb/metrics-and-redlines.md 台账为准。

---

## 0. 先判断:这个面试考什么

**面试官画像**:HM 是 Head of Music Tools, Systems and Infrastructure (MCS),2026年3月才组建的新团队。他自己的履历:0到1建过版税报告平台(royalty reporting platform)、设计过 rights data model、做过 escrow 系统防 bad actors、参与过 UMG/SME/WMG 谈判。

**由此推断考察重心(按权重)**:
1. **AI 落地能力**——不是会调 prompt,而是"从人工流程到 AI 产品"的完整方法论(JD 第一条就是 AI-powered productivity + MRD)
2. **Internal product ownership**——把内部用户当客户,管 roadmap、管 adoption
3. **版权/版税域的手感**——不要求专家,但要听得懂 ISRC、label delivery、licensing,且知道**这个域错误成本极高**(钱+法务)
4. **跨团队推动 + GTM**——训练、文档、采用率
5. **音乐热情**——内推语已经立了 music lover 人设,面试要接得住

一句话总纲:**他在招一个能把他手下那些人工的 rights/royalty 流程 AI 化、并让运营团队真用起来的人。所有回答往这个靶心靠。**

---

## 1. 自我介绍(强JD定制,60–90秒)

改造弹药库里的 platform-builder 版本,三段式:

**CN 版**
面试官好,我是 Belle。我现在在一家 TikTok Shop 代运营公司的 AI 团队,角色本质上就是这个 JD 写的事:识别运营痛点,把它变成 AI 驱动的内部工具,然后作为 product owner 负责推广、培训和迭代。我搭建并维护了 60 多个自动化流程,数据准确率从 70% 提到接近 97%,自动化每月省下约 250 小时人工。更早之前我在 TikTok Music 团队做过版权和 metadata 运营:每周对新歌做 ISRC、发行方、地区的核对,UMG 授权过渡期负责把未授权曲目挡在编辑歌单外,我做的升级协议和 QA checklist 被团队沿用,同类错误降了约 80%。私下我也是重度音乐用户,弹吉他、常跑现场,所以这个岗位对我来说是把专业能力放回最熟悉的领域。

**EN 版**
Hi, I'm Belle. My current role is essentially what this JD describes: I identify operational pain points, turn them into AI-driven internal tools, and own each rollout as the product owner, with training, documentation, and adoption metrics. I've built and maintained 60+ automation workflows, improving data accuracy from about 70% to nearly 97%, and my automations eliminate about 250 hours of manual work per month. Before that, on the TikTok Music team, I ran copyright and metadata operations: weekly ISRC, distributor, and release-region verification against label deliveries, and rights safeguards during the UMG licensing transition. My escalation protocol and QA checklist were adopted and cut similar errors by about 80%. Outside work I play guitar and follow the music industry closely, so this role brings my product operations skills back to home ground.

**要点**:先 JD 镜像(pain point → AI tool → product owner → rollout),再音乐版权段,最后 music lover 收尾。不要按时间顺序流水账。

---

## 2a. 简历深挖预测(逐条,附答法口径)

### Outlandish 段(会挖最深,是现职)

**Q1. "250 小时/月怎么算出来的?"**(几乎必问)
- 口径:效率=人时;基线 = AE 人数 × 每人每日手工摘数耗时;自动化 GMV/广告消耗数据流后这部分归零,叠加错误返工消失。台账里有拆法(goal-decomposition-playbook 250h 案例)。
- 追问预判:"省下的时间去哪了?"→ 答:转去更高价值工作(客户策略),且消灭了一整类错误,不只是省时。

**Q2. "60+ 自动化流程都是什么?怎么维护的?"**
- 分类答:数据校验类(缺失/重复/无效/延迟四类问题的系统检测)、提醒跟进类、报表生成类;全部 Wiki 文档化,别人能接手和扩展。这是 Data Quality & Automation STAR(弹药库 P11)。

**Q3. "AI planning tool 从 1 个月到 7 天,怎么推的?"**
- Pilot(几个 AM)→ 收反馈迭代 → 全公司 rollout;adoption 靠培训+文档+用数据说话。这题是他 JD 里 "data-driven adoption" 的镜像,答的时候主动报 adoption 指标(首次跑通率、重复提问量、配置到上线时长)。

**Q4. "RAG proposal assistant 具体架构?怎么防幻觉?"**
- 检索层用历史 proposal 库;输出有人工确认环节;用 golden set 评估。如果被问到技术细节,答到"我负责选型、评估和落地,写代码用 AI 辅助"即可,不装深。

**Q5. "MRD 你写过吗?举个例子"**(JD 原词)
- 用 creator CRM 或 planning tool:用户是谁、痛点、现有流程成本、方案选项(自动化/流程/产品化)、成功指标。

### TikTok Music 段(本岗位核心背书,必挖)

**Q6. "UMG 过渡期你具体做了什么?"**(高危题,口径要稳)
- 如实边界:我是数据分析实习生,**不参与谈判**;我的角色是执行层的 rights safeguard——用 SQL 每周核对新歌 metadata(ISRC/发行方/地区)对 label delivery schedule,过渡期把未授权 UMG 曲目从编辑歌单筛出去。不越界说自己"处理 UMG 关系"。
- 他本人谈过 UMG,吹牛必被戳穿。**准确的小,胜过夸大的大。**

**Q7. "讲一个版权运营里你处理过的具体问题"**
- Tate McRae 事件 STAR:大牌新专卡在 label ingestion,发行日临近;我发现异常→按 48–72 小时升级协议报给 BD→几小时内上线;沉淀 QA checklist,六周内同类错误降约 80%。

**Q8. "ISRC 是什么?和 ISWC 什么区别?"(基础知识抽查)**
- ISRC 标识**录音**(recording),ISWC 标识**词曲作品**(composition/work);一首作品可对应多个录音。延伸:label 管录音版权,publisher 管词曲版权。答得出这个区别就过关。

### 早期 TikTok/ByteDance 段(选挖)

**Q9. "0.06% 转化率那个项目,你怎么定位问题的?"**——搬运系统 STAR,弹药库有完整中英版。
**Q10. "你现在 title 是 Senior Data Analyst,为什么转产品运营?"**
- 答:title 是数据,工作内容一直是 internal product owner(识别痛点→建产品→推 adoption);数据能力是做产品运营的加分项不是转行成本。Zora 也认可数据是我的强项。

---

## 2b. 业务场景题预测(按 HM 的域出题)

### 场景 A(最高概率):"我们有一个大量人工的 rights/royalty 数据流程,你怎么用 AI 改造?"
这是他建这个团队的目的,答题骨架:
1. **先跟着做的人走一遍流程**,拆环节:机械核对 / 需要判断 / 需要沟通
2. **两维评估**:AI 适配度 × 错误成本。**版权/版税域错误成本极高(直接是钱和法务风险),所以不追求全自动**:AI 做 pre-check 和初筛,人做最终确认(human-in-the-loop)
3. 用 golden set 定准确率门槛,达标才扩大范围
4. 写 MRD → pilot 一个环节 → 用 adoption 和准确率数据决定推广
5. 校准条件:信号(准确率/人时)连续改善才扩,信号动结果不动就重查驱动关系
- 素材:AI-vision 验证替代人工核对、metadata QA checklist,都是现成案例。

### 场景 B:"内部工具运营团队不愿意用,怎么办?"
- 说服使用 STAR(弹药库):1:1 听顾虑→发现是沟通鸿沟不是技术问题→按反馈改(filters/Top 10 视图)→帮助文档→adoption 起来。
- 主动报验证指标:首次跑通率、重复提问量、配置到上线时长。

### 场景 C:"多个团队需求都说急,怎么排?"
- 优先级框架(弹药库项目管理题):Impact / Urgency & Alternatives / Effort vs Return;金句"急,本质是对不确定性的焦虑";平台配置在关键路径先做,其余 SOP 兜住+给时间表。

### 场景 D:"给你个目标,比如把版权审核效率提高 50%,怎么拆?"
- 六步目标拆解(playbook):**先问口径和基线**(效率怎么定义?现在人时多少?错误率多少?)→拆驱动→判可控→前置信号→责任→校准条件。Zora 那题的教训就是没先立口径,这次开口 30 秒内必须问基线。

### 场景 E:"怎么设计一套 metadata/rights QA 机制?"
- 分层:系统自动校验(格式/完整性/交叉核对)→抽样人审→边界案例例外通道+升级协议;附监控指标(错误率、处理时效)。原型就是她 Music 时期的 checklist + 封面治理的分层审核思路。

### 场景 F:"AI 输出错了,下游已经用了,怎么办?"
- 先按影响面止损和通知→归因(prompt/检索/数据源)→加 guardrail(该环节降级为人工确认)→错误分级:高成本环节永远保留人审。呼应场景 A 的错误成本观。

### 场景 G(对他 escrow/bad actor 背景):"怎么识别刷量/造假的坏行为?"
- 素材:AI-vision 验证替代可被 game 的人工检查(创作者分层造假)、信用卡欺诈 ML 项目(1.2M 交易、0.58% 标签、SMOTE/XGBoost)。

### 场景 H:"工程资源不够,怎么推进?"
- 弹药库场景 3:关键路径拆最小可用版本;非核心用配置/流程兜住;对齐预期。加一句现职特色:很多东西我自己能先建出来(low-code/API/AI 辅助开发),不用等工程排期。这是她对这个岗位的独特卖点。

---

## 3. 音乐行业理解题(music lover 人设验收)

- "你平时怎么听音乐/最近在关注什么?"——答真实的:弹吉他、常跑现场、重度 DSP 用户,可讲一个最近的行业观察(如 TikTok 对歌曲爆红路径的作用)
- "你怎么看 TikTok 和音乐行业的关系?"——TikTok 是歌曲发现引擎;label 既依赖又博弈(2024 年初 UMG 下架事件就是授权博弈);所以 rights 数据的准确和结算的可信,是平台和 label 关系的基础设施——**顺势接到他团队的价值**
- 术语备查:ISRC(录音)/ISWC(作品);label(录音版权)vs publisher(词曲版权);DSP;royalty reporting;delivery/ingestion;editorial playlist

---

## 4. 反问环节(准备 3 个)

1. "团队今年 3 月刚成立,您最想先 AI 化的是哪个系统或流程?"(直接打他建队目的)
2. "这个角色前 6 个月的成功是什么样子?用什么指标衡量?"
3. "团队自建工具和依赖中央工程团队之间,现在怎么分工?"(呼应她'自己能建'的卖点)

---

## 5. 准备优先级

1. 自我介绍中英各背熟一版(上面第 1 节)
2. Q1/Q6/场景 A 是三道命门题:250h 口径、UMG 边界口径、AI 改造方法论
3. 六步拆解框架的路标句(playbook 里有 EN 版)
4. ISRC/ISWC 和 label/publisher 区别,2024 UMG 事件时间线过一遍
5. 反问背 2 个

红线提醒:所有数字对台账;UMG 段绝不越界到"谈判";title 问题不辩解,直接讲工作内容。
