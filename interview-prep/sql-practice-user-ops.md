# SQL 手撕练习(TikTok 业务场景版)

> 情报:第一轮电话面现场考 1 题,难度 easy——"熟悉 group by, order by, join 就差不多了"。
> 但你简历写了 CTE 和窗口函数,所以练到 Medium 保险。
> **练习方式:不用 AI、不用运行器,手打在记事本里,写完再对答案。** 每天 3-4 题,3 天过完。

## 表结构(所有题目共用)

```sql
creators (creator_id, name, tier, region, joined_date)
videos   (video_id, creator_id, posted_date, views, likes)
orders   (order_id, creator_id, brand_id, gmv, order_date)
tickets  (ticket_id, user_id, category, status, created_at, resolved_at)
```

---

## Part A — Easy(面试最可能考的难度)

**A1. 查出所有 tier 为 'Gold' 的创作者,按加入时间从新到旧排列。**

**A2. 统计每个 region 的创作者人数,只显示人数超过 100 的地区,按人数降序。**

**A3. 查询每个创作者的姓名和他们的总 GMV,没有订单的创作者也要显示(GMV 记为 0)。**

**A4. 找出 2026 年 6 月发布的、观看量超过 10 万的视频,显示视频 ID、创作者姓名、观看量。**

**A5. 统计每个工单类别(category)的数量和平均解决时长(小时),按数量降序。**

**A6. 找出下过单但从未发过视频的创作者。**

---

## Part B — Medium(拉开差距用)

**B1. 用 CTE:找出每个 region 总 GMV 最高的月份(2026 年内)。**

**B2. 每个创作者最近一笔订单的日期和金额。**

**B3. 统计每月新增创作者数,以及相比上月的增减(不用窗口函数版:自连接;窗口函数版:LAG)。**

**B4. 找出"重复报障用户":同一 user_id 在 7 天内提交过 3 张及以上同类别工单。**

---

## Part C — 窗口函数(简历写了,必须会)

**C1. 每个 region 内按总 GMV 给创作者排名,取每个 region 的前 3 名。**

**C2. 按月统计 GMV,并计算累计 GMV(running total)。**

---

# 答案

## A1
```sql
SELECT *
FROM creators
WHERE tier = 'Gold'
ORDER BY joined_date DESC;
```

## A2
```sql
SELECT region, COUNT(*) AS creator_count
FROM creators
GROUP BY region
HAVING COUNT(*) > 100
ORDER BY creator_count DESC;
```
> 考点:**WHERE 过滤行,HAVING 过滤组**。被追问就说这句。

## A3
```sql
SELECT c.name, COALESCE(SUM(o.gmv), 0) AS total_gmv
FROM creators c
LEFT JOIN orders o ON c.creator_id = o.creator_id
GROUP BY c.creator_id, c.name;
```
> 考点:"没有订单的也要显示" = **LEFT JOIN**;NULL 转 0 用 **COALESCE**。

## A4
```sql
SELECT v.video_id, c.name, v.views
FROM videos v
JOIN creators c ON v.creator_id = c.creator_id
WHERE v.posted_date >= '2026-06-01'
  AND v.posted_date <  '2026-07-01'
  AND v.views > 100000;
```
> 日期用左闭右开区间,比 BETWEEN 更稳(不怕时间戳精度问题)。

## A5
```sql
SELECT category,
       COUNT(*) AS ticket_count,
       AVG(EXTRACT(EPOCH FROM (resolved_at - created_at)) / 3600) AS avg_resolve_hours
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY category
ORDER BY ticket_count DESC;
```
> 不同数据库时间差写法不同(MySQL 用 `TIMESTAMPDIFF(HOUR, created_at, resolved_at)`),口头说明即可,面试官不纠结方言。

## A6
```sql
SELECT DISTINCT c.creator_id, c.name
FROM creators c
JOIN orders o  ON c.creator_id = o.creator_id
LEFT JOIN videos v ON c.creator_id = v.creator_id
WHERE v.video_id IS NULL;
```
> "存在 A 但不存在 B" 的经典写法:LEFT JOIN + IS NULL(也可以用 NOT EXISTS)。

## B1
```sql
WITH monthly AS (
  SELECT c.region,
         DATE_TRUNC('month', o.order_date) AS month,
         SUM(o.gmv) AS month_gmv
  FROM orders o
  JOIN creators c ON o.creator_id = c.creator_id
  WHERE o.order_date >= '2026-01-01' AND o.order_date < '2027-01-01'
  GROUP BY c.region, DATE_TRUNC('month', o.order_date)
),
ranked AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY region ORDER BY month_gmv DESC) AS rn
  FROM monthly
)
SELECT region, month, month_gmv
FROM ranked
WHERE rn = 1;
```

## B2
```sql
SELECT creator_id, order_date, gmv
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY creator_id ORDER BY order_date DESC) AS rn
  FROM orders
) t
WHERE rn = 1;
```
> "每组最新一条" = ROW_NUMBER 按组倒序取 rn=1,支持岗数据里天天用。

## B3(窗口函数版)
```sql
WITH monthly AS (
  SELECT DATE_TRUNC('month', joined_date) AS month, COUNT(*) AS new_creators
  FROM creators
  GROUP BY DATE_TRUNC('month', joined_date)
)
SELECT month, new_creators,
       new_creators - LAG(new_creators) OVER (ORDER BY month) AS mom_change
FROM monthly
ORDER BY month;
```

## B4
```sql
SELECT t1.user_id, t1.category, COUNT(*) AS cnt
FROM tickets t1
JOIN tickets t2
  ON t1.user_id = t2.user_id
 AND t1.category = t2.category
 AND t2.created_at BETWEEN t1.created_at AND t1.created_at + INTERVAL '7 days'
GROUP BY t1.user_id, t1.category, t1.ticket_id
HAVING COUNT(*) >= 3;
```
> 这题偏难,面试大概率不考;能讲思路(自连接开 7 天窗口)就已经超预期。

## C1
```sql
WITH creator_gmv AS (
  SELECT c.creator_id, c.name, c.region, SUM(o.gmv) AS total_gmv
  FROM creators c
  JOIN orders o ON c.creator_id = o.creator_id
  GROUP BY c.creator_id, c.name, c.region
)
SELECT *
FROM (
  SELECT *, RANK() OVER (PARTITION BY region ORDER BY total_gmv DESC) AS rnk
  FROM creator_gmv
) t
WHERE rnk <= 3;
```
> 被追问 **RANK vs DENSE_RANK vs ROW_NUMBER**:并列时 RANK 跳号(1,1,3)、DENSE_RANK 不跳(1,1,2)、ROW_NUMBER 强行连续不并列(1,2,3)。

## C2
```sql
SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(gmv) AS month_gmv,
       SUM(SUM(gmv)) OVER (ORDER BY DATE_TRUNC('month', order_date)) AS running_total
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
```

---

## 面试现场技巧

1. **先复述题目和确认口径**("要包含没有订单的创作者吗?时间范围?")——支持岗最看重澄清需求的习惯,这一步本身就是加分项。
2. **先说思路再写**:"先 join 两张表,按 region 分组,再用 HAVING 过滤" —— 写错了思路分还在。
3. **写完主动检查三件事**:JOIN 会不会产生重复行?NULL 处理了吗?GROUP BY 列和 SELECT 列对齐了吗?
4. 方言差异(DATE_TRUNC vs DATE_FORMAT)不确定就直说 "I'll write it in Postgres syntax, happy to adjust"——大方比装懂好。
