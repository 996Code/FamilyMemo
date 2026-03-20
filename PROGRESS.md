# FamilyMemo — 开发进度追踪

> 最后更新：2026-03-20

---

## 当前阶段：MVP Phase 1 — 鸿蒙端（内存数据库）

---

## 已完成

- [x] 项目目录结构初始化（harmony / ios / server / shared）
- [x] HarmonyOS 工程配置（build-profile.json5, module.json5, oh-package.json5）
- [x] 核心数据类型定义 `data/Types.ets`
- [x] 数据层抽象接口 `data/IDataStore.ets`
- [x] 系统权限申请：`PUBLISH_AGENT_REMINDER`
- [x] 页面路由注册（Index / GroupPage / MemoDetail）
- [x] 系统架构设计文档 `ARCHITECTURE.md`
- [x] Git 仓库初始化，推送到 GitHub

---

## 待开发（按优先级排序）

### MVP Phase 1 — 鸿蒙端

- [ ] `data/MemoryDataStore.ets` — 实现 IDataStore，内置种子数据
- [ ] `entryability/EntryAbility.ets` — 初始化 DataStore，注入 AppStorage
- [ ] `pages/Index.ets` — 首页：群组列表 + 用户切换 + 通知角标
- [ ] `pages/GroupPage.ets` — 群组页：备忘录列表 + 新建 FAB
- [ ] `pages/MemoDetail.ets` — 详情页：创建/编辑 + @提及 + 提醒时间
- [ ] `services/ReminderService.ets` — Agent Reminder 封装
- [ ] 通知列表页（可复用 Index 页面内嵌）

### MVP Phase 2 — 联调验证

- [ ] 多用户切换测试（模拟家庭成员场景）
- [ ] 提醒推送验证（Agent Reminder 实际触发）
- [ ] UI 样式打磨

---

## Phase 2 — 后端 + 多端（规划中）

- [ ] `server/` — Node.js (Fastify) + PostgreSQL 后端
- [ ] `server/` — JWT 认证、REST API
- [ ] `server/` — 推送服务（HMS Push Kit + APNs）
- [ ] `harmony/data/HttpDataStore.ets` — 替换内存实现
- [ ] `ios/` — Swift/SwiftUI 客户端
- [ ] `shared/types.ts` — 跨端类型对齐

---

## 关键设计决策记录

| 决策 | 结论 | 原因 |
|---|---|---|
| 数据层切换方式 | IDataStore 接口 + AppStorage 注入 | 无需改动 UI 层，直接换实现 |
| MVP 推送方案 | 鸿蒙 Agent Reminder（本地） | 无需后端，离线可用 |
| 正式推送方案 | 服务端 + HMS Push Kit + APNs | 跨设备、跨平台 |
| 后端语言 | Node.js (Fastify) | 轻量、TS 全栈类型复用 |
| 数据库 | PostgreSQL + Redis | 关系数据 + 任务队列 |

---

## 遗留问题 / 待确认

- [ ] 是否需要邀请码加入群组（正式阶段）？
- [ ] 备忘录是否需要附件/图片支持？
- [ ] 提醒是否需要重复提醒（每天/每周）？
