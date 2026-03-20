import { User, Group, Memo, MemoInput, Notification } from './Types';

// 数据层抽象接口 - MVP 用内存实现，后续替换为 HTTP 实现
export interface IDataStore {
  // 用户
  getUsers(): User[];
  getCurrentUser(): User;
  switchUser(id: string): void;

  // 群组
  getGroups(userId: string): Group[];
  getGroup(id: string): Group | undefined;
  createGroup(name: string, memberIds: string[]): Group;

  // 备忘录
  getMemos(groupId: string): Memo[];
  getMemo(id: string): Memo | undefined;
  createMemo(input: MemoInput): Memo;
  updateMemo(id: string, input: MemoInput): boolean;
  toggleDone(id: string): boolean;
  deleteMemo(id: string): boolean;

  // 通知
  getNotifications(userId: string): Notification[];
  getUnreadCount(userId: string): number;
  markRead(id: string): void;
  markAllRead(userId: string): void;
}
