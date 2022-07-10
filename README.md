# GIS

Sweet! What a cute Genshin Impact script!

**!!NO CHEATS!!**

<<<<<<< HEAD
- [Features](./doc/feature.md)
- [Keymap](./doc/keymap.md)
- [Tactic](./doc/tactic.md)
- [Recording](./doc/recording.md)
- [Note](./doc/note.md)
- [FAQ](./doc/faq.md)
- [Contact](./doc/contact.md)
- [Disclaimer](./doc/disclaimer.md)
=======
[English](./readme-en.md)

## 简介

一个基于`AHK`实现，为原神玩家提供一点点额外小功能的游戏脚本。

**不含任何作弊功能。**

## 功能

### 快速拾取物品/跳过对话

按下`F`键时快速拾取物品/跳过对话。

### 技能计时器

可显示元素战技的冷却时间及效果持续时间。

### 登场动作

使用`数字键`切换角色时，可配置登场时的动作。

### 自定义动作模组

可为每个角色独立配置自定义的战斗动作，长按`左键`即可自动循环。

### 自动拾取

自动拾取/跳过对话，按下`Alt + F`开关该模式。

### 自动前行

自动前进，按下`Alt + W`开关该模式。

### 钓鱼模式

自动钓鱼，按下`F11`开关该模式。

### 进程优先级调整

当游戏窗口处于非活动状态时，将进程优先级设为最低。

## 使用

**注意，需要在游戏中将`切换走/跑`功能由`左Ctrl`变更为`右Ctrl`。**

下载[压缩文档](https://github.com/phonowell/genshin-impact-script/releases/download/0.0.28/Genshin_Impact_Script_CN_0.0.28.zip)并解压。

进入解压文件夹双击其中的`start.exe`即可（会提示是否应用管理员权限，选择应用）。

### 技能计时器

在使用该功能前，需要通过如下动作识别队伍角色：在右侧队员头像可见情况下，按下`F12`键。

改变队伍阵容后，应重新识别角色。

以下角色目前暂不支持：

- 空
- 荧

## 配置

详细请参考[功能配置](./data/config.ini)内的说明。

当完成编辑后，按下`Ctrl + F5`即可即时生效。

### 角色

在文件底部加入角色名以开启针对特定角色的配置。

例如：

```ini
[klee]
on-long-press = a, a~

[zhongli]
on-switch = e~
```

#### on-long-press

自定义的动作模组。详情请点击[这里](./doc/tactic.md)。

#### on-switch

登场方式。可为以下数值之一：

- `e` 依据登场按下数字键的时长，使用对应的元素战技
- `e~` 登场时使用角色的元素战技（长按）

## 注意

- 所有操作均绑定默认按键；但`切换走/跑`除外，它应当由`左Ctrl`变更为`右Ctrl`
- 使用`右键`进行冲刺，而非`左Shift`
- 游戏应以`16:9`分辨率运行
- 避免在公开场合讨论

## 常见问题

点击[这里](./doc/qa.md)。

## 免责声明

你们懂的。
>>>>>>> parent of e64cb9c (updated to v0.0.29)
