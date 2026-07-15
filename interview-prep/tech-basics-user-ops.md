# 支持岗技术基础速览(TikTok PUO 面试准备)

> 定位:JD 要求 "Familiarity with HTML, JavaScript, SQL, HTTP protocols, and internet technologies"。
> 考察的不是写代码,而是**排查问题时知道错误发生在哪一层、该升级给谁**。
> 每节都配了英文关键句,面试直接说。

---

## 1. HTTP 状态码 = 工单路由表(最高频考点)

| 状态码 | 含义 | 支持视角:谁的问题 → 怎么处理 |
|---|---|---|
| **200** OK | 请求成功 | 请求没问题;若页面仍不对 → 查返回的数据内容或前端渲染 |
| **301/302** | 重定向 | 一般正常;循环重定向才是 bug |
| **400** Bad Request | 请求格式错误 | 用户输入或前端传参问题 → 让用户检查输入/复现步骤 |
| **401** Unauthorized | 未登录/凭证失效 | 让用户重新登录、检查 token 过期 → **支持侧可解决** |
| **403** Forbidden | 已登录但无权限 | **权限问题 → 走权限开通流程**(你简历里的 permissions 类咨询) |
| **404** Not Found | 资源不存在 | 链接错误或资源被删 → 核对 URL/数据是否存在 |
| **408 / 超时** | 请求超时 | 网络或服务慢 → 让用户重试,多人报告则升级 |
| **429** Too Many Requests | 触发限流 | 调用频率过高 → 降频/加缓存;API 集成常见 |
| **500** Internal Server Error | 服务端代码报错 | **升级给工程**,附请求详情 |
| **502/503/504** | 网关错误/服务不可用/网关超时 | 服务挂了或在部署 → **升级给工程/查发布记录**,通常是批量性故障 |

**一句话规则**:`4xx = 请求方(用户/权限/输入)的问题,支持侧先处理;5xx = 服务端的问题,直接升级工程。`

> EN: "My rule of thumb: 4xx errors point to the client side — auth, permissions, bad input — which support can usually resolve; 5xx means something broke on the server, so I escalate to engineering with the full request context."

---

## 2. "浏览器输入 URL 后发生了什么"(经典题)

```
输入 URL → DNS 解析(域名→IP) → 建立 TCP 连接 + TLS 握手(HTTPS)
→ 发送 HTTP 请求 → 服务器处理并返回响应(HTML)
→ 浏览器解析 HTML → 加载 CSS/JS/图片 → 渲染页面 → JS 执行交互逻辑
```

**支持视角的价值:每一步都对应一类故障**:
- DNS 失败 → 整个站打不开("无法访问此网站")
- TLS/证书错误 → 安全警告页
- 请求发出无响应 → 服务或网络挂了
- 返回 4xx/5xx → 见上表
- HTML 到了但页面空白/错乱 → 前端 JS 报错(看 Console)

> EN: "I use this chain to localize issues: if DNS or TLS fails nothing loads; if the request returns 4xx/5xx it's server-side or auth; if the response is 200 but the page is blank, I check the browser console for JavaScript errors."

---

## 3. 前端 vs 后端问题怎么判断(DevTools 排查流程)

打开 **F12 DevTools**,两个面板走完 90% 的分诊:

**① Console(控制台)**
- 红色 JS 报错 → 前端问题(比如 `undefined is not a function`)
- 无报错但页面不对 → 继续看 Network

**② Network(网络)**
- 找到对应请求,看 **Status**(对照上表)
- 看 **Response**:200 但返回数据是空的/错的 → 数据问题(查库,用 SQL)
- 看 **Payload/Request**:前端传的参数就是错的 → 前端问题
- 右键 **Copy as cURL** / 导出 **HAR** → 附在升级工单里,工程师直接复现

**升级给工程的报告模板**(体现专业度):
```
[问题] 用户 X 在 Y 页面执行 Z 操作时失败
[复现步骤] 1... 2... 3...(必现/偶现,影响多少用户)
[证据] 请求 URL + 状态码 + 响应体截图 / HAR 文件
[已排除] 已确认非权限问题(403 已排除)、其他用户可复现、清缓存无效
[影响] 阻塞 N 个用户的 XX 工作流,建议优先级 P1/P2
```

> EN: "Before escalating, I reproduce the issue, isolate it — console error means frontend, failed request means backend or auth, 200-with-wrong-data means data layer — and hand engineering a repro with the exact request, status code, and what I've already ruled out."

---

## 4. 核心概念一句话版(可能被抽问)

| 概念 | 一句话 | 你的真实案例 |
|---|---|---|
| **GET vs POST** | GET 取数据、参数在 URL、可缓存;POST 提交数据、参数在 body、会改变服务端状态 | 调 TikTok API 拉 GMV 用 GET;创建 Lark 任务用 POST |
| **API vs Webhook** | API 是"我去拉"(pull),Webhook 是"它来推"(push,事件触发) | Eventbrite webhook:创作者一报名就自动推给我们系统分级 |
| **REST API** | 用 HTTP 动词(GET/POST/PUT/DELETE)操作资源,返回 JSON | 你所有集成都是 REST |
| **JSON** | 键值对的数据交换格式,API 的通用语言 | 你的 LLM pipeline 要求模型输出严格 JSON 再校验 |
| **鉴权 token / Bearer** | 请求头里带的"通行证",过期就 401 | 会议转写要用有权限用户的 token,你做过 token 轮换 |
| **Cookie / Session** | 浏览器存的小数据/服务端的登录态;登录问题的常见根源 | "清缓存和 cookie 再试"是有效的第一步不是玄学 |
| **缓存 Cache** | 存旧副本加速;"改了但没生效"常是缓存没过期 | 报表更新了但用户看到旧数据 → 先想缓存 |
| **CDN** | 就近分发静态资源;个别地区打不开常与它有关 | — |
| **HTML / CSS / JS** | 骨架 / 样式 / 行为;JS 报错才影响功能 | 你的内部工具就是 Web 应用 |
| **限流 Rate limit** | API 每分钟调用上限,超了 429 | 你的 pipeline 每 30 分钟批量跑就有频控意识 |

---

## 5. 高频问答(准备到能脱口而出)

**Q: 用户报告"页面打不开",你怎么排查?**
> 先问范围:一个人还是多人?一个页面还是整站?→ 一个人+整站 = 本地网络/VPN/DNS;多人+一个功能 = 我们的服务问题。然后让用户 F12 截图 Console 和 Network,或者远程复现。按状态码分诊:403 走权限,5xx 升级工程并附复现证据,200 但数据不对就去查数据层。**先止血(给 workaround),再治根(推修复)**。

**Q: 同时来了三个问题怎么排优先级?**
> 按 **影响面 × 紧急度**:阻塞多人核心工作流的 > 单人的;有截止时间压力的(比如客户汇报要用的报表)> 可等的;有 workaround 的降级处理。响应上全部先秒级 ack("收到,正在看"),让用户知道没有被忽略——我现在每天 10-30 条咨询就是这么管的。

**Q: 举一个你排查技术问题的例子。**
> 用 SCF 的故事:20+ 创作者提交工单说 tier 分配错误 → 排查发现根因不是算法而是人工查数流程跟不上(3000+ 积压)→ 短期手动修正安抚用户,长期用 webhook + API 重建流程,工单类别消灭。

**Q: 你不是工程师,遇到看不懂的技术问题怎么办?**
> 我的职责是把问题**定位到层级并翻译清楚**,不是修代码。我会复现、收集证据(状态码、请求、日志)、排除已知原因,然后给工程一个可直接行动的报告。同时我会把这次的解法写进 SOP,下次同类问题支持侧自己就能解决。

**Q: (可能的加分题)你怎么看 AI 在用户支持里的应用?**
> 我实际做过:LLM 做分类打标(和工单 triage 同构)、AI vision 自动核验用户提交的数据消灭了一个工单类别、AI 会议 pipeline 自动生成任务。我的观点:AI 先吃掉"重复、有模式"的工单(FAQ、状态查询、分类路由),人集中处理判断类和情绪类问题;关键是用真实工单数据持续优化 AI 的准确率——这正是你们团队在做的方向。

---

## 6. 考前 30 分钟清单

- [ ] 4xx vs 5xx 规则能脱口而出
- [ ] URL→页面 六步链条能画出来
- [ ] Console/Network 分诊二步法能描述
- [ ] GET vs POST、API vs Webhook 各一句话
- [ ] SCF 排查故事 2 分钟版练一遍(中英文各一遍)
- [ ] 升级报告模板五要素:问题/复现/证据/已排除/影响
