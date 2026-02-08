# 🚀 Cursor AI Rules & Prompts Collection

> **Transform your Cursor IDE into a powerful project management system using IC Design methodologies**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/mintianxin-web/cursor-ai-rules.svg?style=social)](https://github.com/mintianxin-web/cursor-ai-rules)

## ✨ What Makes This Special?

This isn't just another AI prompt collection. It's a **complete workflow system** that bridges the gap between hardware design thinking and software development. If you're an engineer who thinks in terms of **FPGA/ASIC**, **IP Cores**, and **Tape-out**, this is your perfect match.

### 🎯 Why You'll Love This

- **🧠 Hardware-First Mental Models**: Think in terms you already know (Docker = SiP, API Keys = IP Licenses)
- **⚡ Auto-Routing Intelligence**: Automatically selects the right mode (Standard/STDD/Tone) based on your task
- **🛡️ Built-in Safety**: Never accidentally commit API keys or delete important files
- **📊 State Machine Workflow**: Clear, structured project lifecycle from spec to deployment
- **🔧 Ready-to-Use Prompts**: Four specialized architect prompts for different project phases

## 🎬 Quick Start (30 seconds)

```bash
# Clone this repository
git clone https://github.com/mintianxin-web/cursor-ai-rules.git

# Copy to your project
cd your-project
cp -r cursor-ai-rules/.cursorrules .
cp -r cursor-ai-rules/cursor_prompts .

# That's it! Cursor IDE will automatically load the rules
```

## 📁 What's Inside?

```
cursor-ai-rules/
├── .cursorrules              # 🎯 Main rule engine (workspace-level)
├── scratchpad.md             # 🧠 Project memory & state tracker
├── cursor_prompts/           # 📚 Specialized prompt templates
│   ├── 01_spec_architect.md    # Interviewer mode: Extract requirements
│   ├── 02_stdd_architect.md    # Consultant mode: Make vs Buy decisions
│   ├── 03_tone_stylist.md      # Mimicry mode: Match your writing style
│   └── 04_code_reviewer.md     # LVS mode: Security & logic checks
└── README.md                 # 📖 This file
```

## 🧩 The Mental Model (For IC Designers)

| Software Concept | Hardware Analogy | Why It Matters |
|-----------------|------------------|----------------|
| **Docker** | Package / SiP | Containerized, reusable components |
| **API Key** | IP Core License | External service access credentials |
| **SQLite** | DMA/DDR Memory | Fast, local data storage |
| **Next.js** | ASIC | Mass production, SEO optimized |
| **Streamlit** | FPGA | Rapid prototyping, internal tools |

## 🔄 The Workflow (6 States)

```
STATE 0: Intent Classification → Auto-route to correct mode
    ↓
STATE 1: Spec Definition → Extract complete requirements
    ↓
STATE 2: Architecture Selection → FPGA (Streamlit) vs ASIC (Next.js)
    ↓
STATE 3: Pre-flight BOM → Check .env, permissions, dependencies
    ↓
STATE 4: Implementation Loop → Baby steps with auto-testing
    ↓
STATE 5: Deployment (Tape-out) → Git push & publish
```

## 💡 Real-World Example

**You say:**
```
"New Project: Build a task management tool"
```

**AI responds:**
```
⚡ Auto-Mux: Detected Logic/Data. Switching to Mode B (STDD). 
Phase 1 Initiated.

📋 Phase A1: Discovery
- Domain: Tool/Dashboard
- Access: Local or Public Web?
- Data: Need persistent database?
- Budget: Vercel/OpenAI accounts?
```

The system automatically routes you to the right workflow mode and guides you through each phase.

## 🎨 Three Modes, Three Purposes

| Mode | Trigger | Best For |
|------|---------|----------|
| **Mode A (Standard)** | Simple/Static tasks | Quick scripts, static sites |
| **Mode B (STDD)** | Logic/Data/Reliability | Complex apps, databases, APIs |
| **Mode C (Tone)** | Writing/Email | Content creation, documentation |

## 🛡️ Safety First

- ✅ **API Key Protection**: Never hardcodes secrets (uses `os.getenv()`)
- ✅ **Deletion Safeguards**: Requires explicit confirmation before deleting files
- ✅ **Scope Control**: Only implements what you ask for (no feature creep)
- ✅ **Auto .gitignore**: Sensitive files automatically excluded

## 📚 The Prompt Templates

### 01_spec_architect.md
**Role**: Interviewer Mode  
**Purpose**: Extract complete Software Requirement Specification (SRS)  
**Method**: Constraint-first questioning (Tape-out, I/O, PDK)

### 02_stdd_architect.md
**Role**: Consultant & Scout Mode  
**Purpose**: Make vs Buy decisions, find existing IP Cores  
**Method**: Discovery → IP Scouting → Strategy Selection → Spec Generation

### 03_tone_stylist.md
**Role**: Personal Tone Stylist  
**Purpose**: Mimic your writing style (avoid AI-voice)  
**Method**: Few-shot learning from your samples

### 04_code_reviewer.md
**Role**: LVS Tool (Layout vs Schematic)  
**Purpose**: Security & logic validation  
**Checks**: API keys, error handling, spec compliance

## 🚦 Getting Started

1. **Install**: Copy `.cursorrules` and `cursor_prompts/` to your project
2. **Configure**: Set up your `.env` file (see `.env.txt` template)
3. **Start**: Say "New Project..." and watch the magic happen!

## 🤝 Contributing

Found a bug? Have an improvement idea? 

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Designed for **analog IC designers** transitioning to software development
- Inspired by **hardware design methodologies** (STDD, LVS, Tape-out)
- Built for the **Cursor IDE** community

## ⭐ Star History

If you find this useful, please consider giving it a star! ⭐

---

**Made with ❤️ by [@mintianxin-web](https://github.com/mintianxin-web)**

*"Slow is Smooth, Smooth is Fast" - PPA Optimized*
