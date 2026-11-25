<p align="center"><img src="docs/icon.png" width="128" alt="Editroom icon"></p>

# Editroom（简体中文版）

快速而强大的 Mac 视频剪辑软件——免费、开源，永远属于你。

本仓库是 [robbietilton/Editroom](https://github.com/robbietilton/Editroom) 的**简体中文版分叉（Fork）**，通过苹果原生 String Catalog（`Localizable.xcstrings` / `InfoPlist.xcstrings`）为界面、菜单、导出、调色、快捷键与「魔法剪辑」等模块提供简体中文（`zh-Hans`）本地化，并保留英文回退与原项目结构兼容。

Editroom 仅约 7.5 MB，却拥有你所需的专业剪辑工具——调色、变速曲线、转场、混音、响度标准以及任意比例导出，无需代理文件或缓冲即可实时播放 4K 素材。只需说出你的想法，就能看着 Claude、ChatGPT 或你的 Mac 本机为你完成剪辑。

正因为它是开源的，你可以下载 Xcode 工程，按自己的工作流增删或修改任何功能。

![Editroom](docs/screenshot.webp)

## 安装与运行

> **提示**：由于 macOS 应用及签名 DMG 必须在 macOS + Xcode 环境下构建，本分叉仓库当前发布的是已完整本地化的源码，尚未提供预编译的中文版 `.dmg` 安装包。

在装有 Xcode 26 或更高版本的 Apple Silicon Mac 上：

1. 克隆本仓库：`git clone https://github.com/Kyoma233/Editroom.git`
2. 用 Xcode 打开 `Editroom.xcodeproj`。
3. 选择 **Editroom** Scheme 并运行（`⌘R`），或在系统首选语言为简体中文时直接启动编译出的应用。
4. 若需要自行调试更新机制或发布分叉版本 DMG，请先将 `Info.plist` 中的 `SUFeedURL` / `SUPublicEDKey` 及 `scripts/release.sh` 中的开发者团队证书替换为自己的签名信息（本分叉已默认关闭指向原英文仓库的自动更新检查，以免被英文原版覆盖）。

## 功能特性

### 剪辑
- 从编辑到导出全程 4K 实时锐利呈现：无卡顿、无缓冲、无需代理文件
- 支持几乎所有格式：iPhone、佳能、索尼、尼康、富士拍摄素材，以及 macOS 原生无法打开的文件（MXF、MKV、WebM…）
- 支持标记（Markers）与入点 / 出点，方便标注重点时刻并局部编辑或导出
- 支持分割、波纹删除、闭合空隙、分离音频、制作副本、定格帧与倒放
- 支持文字标题与纯色背景，按需添加任意数量的视频和音频轨道
- 支持自定义键盘快捷键

### 调色
- 专业调色：载入自定义 `.cube` LUT 或选用内置风格滤镜，并微调曝光、对比度、白平衡与饱和度
- 支持从一个片段拷贝调色并粘贴到其他片段

### 变速与转场
- 变速曲线（Speed Ramps）：将片段局部减速或加速，并平滑恢复原速
- 片段间支持叠化（Dissolve）、浸入黑场（Dip to Black）或划像（Wipe）转场
- 画面与声音均支持多种曲线的淡入淡出

### 音频
- 踩点剪辑：自动将画面切点对齐音乐节拍
- 每个轨道均可独立设置独奏（Solo）、静音（Mute）与音量电平，并配备电平表与波形显示
- 跨片段一键均衡音频响度

### 导出
- 响度标准预设：无需专业音频知识，直接按 YouTube、播客或广播电视标准（如 −14 LUFS 等）导出合适音量
- 任意比例导出：一键将同一条时间线转为竖屏、方形或竖向 4:5 成片，并可自由选择画面保留区域

### 快速定位素材瞬间
- 画面内容检索：搜索片段中的人物、场景与物体（如海滩、汽车、夜景、笑声、狗…）
- 语音自动转录：搜索片段里说过的每一句话

### 魔法剪辑（Magic）
直接说出你想剪的效果，看着它自动完成。例如输入 *"Make an intro montage from the best moments. Cut to the beat. Slow-mo on @birthday-party when cake is thrown"*，并选择由谁来执行：

- **Claude** — 通过 Claude 应用使用你自己的 Claude 订阅额度
- **ChatGPT** — 通过 ChatGPT 应用 / Codex 使用你自己的 ChatGPT 订阅额度
- **本地（Local）** — 完全在你的 Mac 上借助 Apple 设备端模型运行，数据不离开本机

可用 `@` 引用媒体或片段，或用 `@playhead` 指向播放头位置。每一次魔法剪辑操作均支持一键撤销。

### 与 AI 助手协同工作
- Claude 与 ChatGPT 可通过 MCP 直接编辑已打开的项目，并在时间线上呈现独立的光标与操作轨迹。在「设置 › 魔法剪辑」中一键连接，无需额外配置 API 密钥。

## 系统与编译要求

- 配备 Apple Silicon 芯片的 Mac，运行 macOS 14 或更高版本
- 魔法剪辑的「本地」模式需要 Apple 智能（macOS 26 或更高版本）
- 魔法剪辑的 Claude 和 ChatGPT 选项需要安装对应的 Claude 应用或 ChatGPT / Codex，并已登录你的订阅账号
- 从源码构建需要 Xcode 26 或更高版本

## 源码构建

打开 `Editroom.xcodeproj` 并运行 **Editroom** Scheme 即可。

## 打包发布

`scripts/release.sh` 会构建 Release 版本、使用 Developer ID 签名、公证并装订（Notarize & Staple），最后生成 `dist/Editroom-<version>.dmg`。之后可通过 `scripts/publish.sh` 创建 GitHub Release 并更新 Sparkle 源（`appcast.xml`）。

打包脚本依赖以下本地环境配置（均不保存在仓库中）：

- 登录钥匙串中的 **Developer ID Application** 证书
- 通过 `xcrun notarytool store-credentials "editroom-notary" …` 保存的公证凭据
- 登录钥匙串中的 Sparkle 签名私钥（`generate_keys --account editroom`）
- [`create-dmg`](https://github.com/create-dmg/create-dmg)（`brew install create-dmg`）与 [`gh`](https://cli.github.com)

## 开源协议

MIT — 详见 [LICENSE](LICENSE)。

Editroom 内置了基于 GNU LGPL 2.1 或更高版本许可的 [FFmpeg](https://ffmpeg.org) 9.1（作为独立进程运行，用于解码 macOS 原生不支持的媒体格式），源码与构建选项见 [Vendor/ffmpeg](Vendor/ffmpeg/README.md)。软件更新功能由 [Sparkle](https://sparkle-project.org)（MIT 协议）提供支持。
