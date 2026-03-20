# FamilyMemo - 系统架构设计文档

> 版本 v0.1 | 2026-03-20  
> 阶段：MVP（鸿蒙端 + 内存数据库），面向后续多端扩展

---

## 一、整体目标

家庭协作备忘录，核心功能：

- 多用户组建群组
- 群组内创建/编辑备忘录
- 备忘录支持 @成员
- 设定提醒时间，到时推送通知
- 多端支持（HarmonyOS、iOS、后端服务）

---

## 二、技术选型

| 层次 | MVP（第一阶段） | 正式阶段 |
|---|---|---|
| 鸿蒙客户端 | ArkTS + HarmonyOS Stage 模型 | 同左 |
| iOS 客户端 | 暂不实现 | Swift / SwiftUI |
| 后端 | 暂不实现（内存模拟） | Node.js (Fastify) + PostgreSQL |
| 实时推送 | 鸿蒙 Agent Reminder | HMS Push Kit / APNs |
| 数据存储 | 内存（MemoryDataStore） | PostgreSQL + Redis |
| 认证 | 本地用户切换 | JWT + Refresh Token |

---

## 三、目录结构规划

FamilyMemo/
├── harmony/entry/src/main/ets/
│   ├── entryability/EntryAbility.ets
│   ├── data/
│   │   ├── Types.ets              (已有)
│   │   ├── IDataStore.ets         (已有)
│   │   ├── MemoryDataStore.ets    (MVP 待实现)
│   │   └── HttpDataStore.ets      (正式阶段)
│   ├── services/ReminderService.ets
│   ├── viewmodel/
│   │   ├── GroupViewModel.ets
│   │   └── MemoViewModel.ets
│   ├── components/
│   │   ├── MemoCard.ets
│   │   ├── MemberChip.ets
│   │   ├── MentionInput.ets
│   │   └── ReminderPicker.ets
│   └── pages/
│       ├── Index.ets
│       ├── GroupPage.ets
│       └── MemoDetail.ets
├── ios/                (正式阶段)
├── server/             (正式阶段)
└── shared/             (正式阶段)

---

## 四、数据模型（现有 Types.ets）

| 类型 | 关键字段 |
|---|---|
| User | id / name / avatar(emoji) / color |
| Group | id / name / memberIds[] / createdAt |
| Memo | id / groupId / title / content / createdBy / mentionIds[] / reminders[] / done |
| Reminder | id / time(ms) / notified |
| Notification | id / userId / memoId / message / read / createdAt |
| MemoInput | 创建/编辑 DTO |

正式阶段补充：User 增加 deviceToken/passwordHash，Group 增加 inviteCode，Reminder 增加 repeatType

---

## 五、数据层切换策略

IDataStore 接口，MVP 用 MemoryDataStore，正式阶段换 HttpDataStore，接口完全相同。
EntryAbility.ets 初始化时注入 AppStorage，页面通过 AppStorage.get 获取。

---

## 六、页面流程

启动 → Index（群组列表 + 用户切换 + 通知角标）
       → GroupPage（备忘录列表 + FAB 新建）
           → MemoDetail（编辑 + @提及 + 提醒时间 + 保存/删除/完成）

---

## 七、提醒推送机制

MVP：鸿蒙 Agent Reminder（本地，权限已申请，无需后端）
正式：后端 Redis+Bull 队列 → HMS Push Kit（鸿蒙）/ APNs（iOS）

---

## 八、后端 REST API（正式阶段参考）

认证：POST /auth/register|login|refresh
群组：GET/POST /groups，POST /groups/:id/invite，POST /groups/join
备忘录：GET/POST /groups/:id/memos，PUT/PATCH/DELETE /memos/:id
通知：GET /notifications，PATCH /notifications/:id/read，PATCH /notifications/read-all

---

## 九、MVP 开发顺序

1. data/MemoryDataStore.ets
2. entryability/EntryAbility.ets
3. pages/Index.ets
4. pages/GroupPage.ets
5. pages/MemoDetail.ets
6. services/ReminderService.ets
7. 通知列表

---

## 十、已有文件状态

| 文件 | 状态 |
|---|---|
| data/Types.ets | 已完成 |
| data/IDataStore.ets | 已完成 |
| module.json5 | 已完成 |
| 其余页面/服务文件 | 待实现 |
