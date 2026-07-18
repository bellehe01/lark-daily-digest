# IntelliPro — Product Manager Intern, AI Sourcing(Jun 2025 – Sep 2025)

> 来源:另一会话产出的 "AI Product Builder" 简历(2026-07 转入)。
> ⚠️ 本页数字标注"待确认"的,定稿/面试前需本人最终核实。

**公司**:IntelliPro(招聘/人力服务公司)
**时间线校验**:✅ 毕业(2025.5)→ IntelliPro(2025.6–9)→ Outlandish(2025.9–)无重叠,填补空档

## 项目:AI 候选人 Sourcing 工具(0→1)

**产品**:输入原始 JD → 端到端产出打分排序的 LinkedIn 候选人 shortlist,约 5–10 分钟(待确认)
链路:JD parsing → search-query optimization → batch sourcing → multi-dimensional scoring
落地:与工程共建,作为 IntelliPro 招聘平台内 "AI Sourcing" tab 试点,由在职 recruiter 实测(待确认程度:pilot 阶段)

**系统设计(她 own 的部分)**:
- 多智能体 LLM pipeline:把 JD 理解拆成 skill / seniority / location 专职 agent
- 例子:'Tax Director' 归一化到正确的 LinkedIn seniority 词;'Palo Alto' → SF Bay Area → West Coast 的地理扩展
- 设计动机:对抗 LLM 在长、多目标 prompt 上的精度衰减(面试可讲的架构决策)

**评估体系(最稀缺的部分)**:
- 6 维加权评分 rubric:skills match 0.5、competency depth、domain fit、seniority、education、career progression
- 亲写 scoring prompts;离线验证用 **nDCG@30** 对 golden-standard 标注
- 结果(待确认):rubric-guided GPT-4 ~**94% nDCG**;与 recruiter 人工 top-30 排序 **98%+ 重合**;覆盖 5 个 JD

**模型选型与成本**:
- Benchmark **8+ LLMs**(GPT-4/4.1/5、Gemini 2.5、DeepSeek V3/R1、Qwen 3)质量 vs 成本
- 每 JD 成本 ~$4–8;优化路径至 ~$0.0075/候选人(待确认)

## 角度标注
- **AI PM 岗**:王牌经历——架构决策 + 评估方法论 + 成本工程,三件套齐全
- **APM/PM 岗**:0→1 + 与工程共建 + pilot 验证
- **数据岗**:nDCG 评估、golden-standard 构建
- **支持/运营岗**:一般不上简历(空间不够时优先级低于 Outlandish 内容),但可作 AI 谈资

## 面试必被追问点
- nDCG@30 怎么算的、golden-standard 怎么标的(30 是什么、5 个 JD 怎么选)
- 为什么 skills match 权重 0.5、其他维度怎么定的
- 多 agent 拆分前后精度对比有没有数据
- $0.0075/候选人的优化路径具体是什么(小模型分流?缓存?batch?)
- pilot 的 recruiter 反馈如何、后来上线了吗(⚠️ 离职后状态要么知道要么老实说不知道)

## 红线
- 是 **intern** 身份,3 个月——不夸大为正式 PM 或长期 owner
- "GPT-5" 出现在 benchmark 列表(时间上 2025 夏是否可用需自洽;若不确定,说 "当时最新的 GPT 系列版本")
- pilot ≠ 正式上线;用户规模没有数字就不要给
