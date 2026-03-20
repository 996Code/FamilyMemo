// 核心数据类型定义

export interface User {
  id: string;
  name: string;
  avatar: string; // emoji 头像
  color: string;  // 主题色
}

export interface Group {
  id: string;
  name: string;
  memberIds: string[];
  createdAt: number;
}

export interface Reminder {
  id: string;
  time: number; // timestamp ms
  notified: boolean;
}

export interface Memo {
  id: string;
  groupId: string;
  title: string;
  content: string;
  createdBy: string; // userId
  mentionIds: string[]; // @的用户
  reminders: Reminder[];
  createdAt: number;
  updatedAt: number;
  done: boolean;
}

export interface Notification {
  id: string;
  userId: string;
  memoId: string;
  message: string;
  read: boolean;
  createdAt: number;
}

export interface MemoInput {
  groupId: string;
  title: string;
  content: string;
  createdBy: string;
  mentionIds: string[];
  reminderTimes: number[];
}
