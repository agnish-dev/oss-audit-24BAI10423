# The Open Source Audit
### A Capstone Project for OSS NGMC Course

---

**Student Name:** Agnish Mondal  
**Registration Number:** 24BAI10423  
**Course:** Open Source Software | Units 1–5  
**Chosen Software:** Git  
**Date of Submission:** March 31, 2026  

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Part A — Origin and Philosophy](#part-a--origin-and-philosophy)
   - [A1. The Problem Git Was Created to Solve](#a1-the-problem-git-was-created-to-solve)
   - [A2. The License — What GPL v2 Actually Says](#a2-the-license--what-gpl-v2-actually-says)
   - [A3. The Ethics of Open Source](#a3-the-ethics-of-open-source)
3. [Part B — Linux Footprint](#part-b--linux-footprint)
4. [Part C — The FOSS Ecosystem](#part-c--the-foss-ecosystem)
5. [Part D — Open Source vs Proprietary](#part-d--open-source-vs-proprietary-critical-analysis)
6. [Shell Script Documentation](#5-shell-script-documentation)
7. [Conclusion](#6-conclusion)
8. [References](#7-references)

---

## 1. Introduction

There is a good chance that every single piece of software you have ever used — the browser you opened this morning, the operating system underneath it, the servers that sent you this file — was built using one tool: Git. Not because it was mandated by any authority, not because some corporation decided to standardize on it, but because it is genuinely, demonstrably the best version control system ever made. And it was written in ten days, by one person, out of frustration.

That story is worth understanding. Not just as trivia, but as a case study in what the open-source philosophy actually produces in the real world when it works the way it is supposed to.

This report is a structured audit of Git. I chose it over the other options on the list because it sits at the very foundation of modern software development — it is not just an open-source project, it *is* the infrastructure on which open-source collaboration happens. Auditing Git means examining the tool through which the entire FOSS ecosystem shares, improves, and distributes its work. That felt like the most honest way to engage with the subject of this course.

The report is organized into four analytical sections covering origin and philosophy, Linux footprint, the FOSS ecosystem, and a comparison with proprietary alternatives. Following that is documentation for five shell scripts written to demonstrate practical Linux skills connected to the themes of the report.

---

## Part A — Origin and Philosophy

### A1. The Problem Git Was Created to Solve

To properly understand why Git exists, you need to go back to the late 1990s — specifically to the problem of coordinating a project as large and geographically distributed as the Linux kernel.

Linux by 2002 had thousands of contributors scattered across the world. Getting code from all those people into one coherent, working kernel release was a logistical nightmare. For the first decade of Linux development — from 1991 to roughly 2002 — the process was almost comically manual. Linus Torvalds would receive code in the form of emailed patches and tarballs. Developers would send diffs. Someone on the core team would manually apply them, resolve conflicts, and try to keep the codebase from falling apart. This worked when the project was small. By the early 2000s, it was genuinely holding back development.

In 2002, the Linux kernel project made a pragmatic compromise that would eventually force a more principled solution. They adopted BitKeeper, a proprietary distributed version control system built by a company called BitMover. BitKeeper was genuinely ahead of its time — it introduced the concept of distributed repositories, where every developer had a full copy of the project history, not just a working copy checked out from a central server. For the Linux project, this was transformative. Development moved faster. Coordination became easier. The tool was good.

But there was a catch. The community was allowed to use BitKeeper for free only on the condition that they did not attempt to reverse-engineer or replicate its proprietary protocol. This was an arrangement that many people in the open-source community found deeply uncomfortable. You were using a free-as-in-free-beer proprietary tool to build a free-as-in-freedom operating system. The philosophical contradiction was obvious, and the practical risk was real: a company could revoke access at any time, for any reason, and suddenly the kernel development process would be crippled.

That is exactly what happened. In April 2005, BitMover revoked free access to Linux kernel developers. The specific trigger was a dispute over Andrew Tridgell — a developer who had written a script that reverse-engineered some aspects of the BitKeeper protocol, which BitMover viewed as a violation of the terms of use. The details of who was right in that dispute are less important than the outcome: the Linux kernel project suddenly had no version control system.

Torvalds evaluated the alternatives. Subversion existed, but it was a centralised system — you needed network access to commit, to branch, to do almost anything meaningful. It was, in his words, "the most pointless project ever started." CVS was older and worse. There was nothing available that met what he considered the minimum requirements for managing the kernel: it had to be distributed, it had to be fast, it had to handle non-linear development (thousands of simultaneous branches), it had to be trustworthy about data integrity, and it had to be open-source so the community could never be held hostage again.

So in April 2005, Torvalds wrote Git. He used it to manage the next Linux kernel release within weeks. He then handed primary maintenance to Junio C. Hamano, who has led the project ever since. Git was released under GPL v2 from day one — the same license as the Linux kernel itself — ensuring by legal design that no company could ever do to Git what BitKeeper had done.

What I find genuinely interesting about this origin story is that the creation of Git was not just a technical response to a technical problem. It was a values response to a values problem. The Linux kernel had a dependency on a proprietary tool, and that dependency was incompatible with the foundational principles of the project. Torvalds's solution was not just to write better software — it was to write software whose openness was structural and permanent, not something that could be revoked by a business decision.

The lesson is still directly relevant today. Organizations that build their workflows on top of closed platforms are always one business decision away from losing access to their own history. The reason Git is now the universal standard for version control — used everywhere from student projects to the Linux kernel, from startups to NASA — is not marketing. It is because its design philosophy of distributed ownership and open licensing maps directly onto how good software collaboration actually works.

---

### A2. The License — What GPL v2 Actually Says

Git is licensed under the GNU General Public License, version 2. Before answering the specific questions this section requires, I want to be honest about how I approached it: I actually read the GPL v2 license text. It is available at gnu.org/licenses/gpl-2.0.html. It is not particularly long — about 3,000 words — and while parts of it are dense legalese, the core meaning is not difficult to follow once you know what it is trying to do.

**The Four Freedoms**

The Free Software Foundation defines four fundamental freedoms that a license must grant for software to qualify as "free software" in the philosophical sense:

- **Freedom 0:** The freedom to run the program for any purpose.
- **Freedom 1:** The freedom to study how the program works, and change it so it does your computing as you wish. (This requires access to the source code.)
- **Freedom 2:** The freedom to redistribute copies so you can help others.
- **Freedom 3:** The freedom to distribute copies of your modified versions to others. (This also requires source code access.)

Git's GPL v2 license grants all four. Anyone can download Git's source code, compile it, run it, read it, modify it, and distribute their version. There are no restrictions on commercial use, no restrictions on the purpose for which you run it, no restrictions on who gets to contribute. The only meaningful restriction is on distribution, and it is a reciprocal one — if you distribute a modified version of Git, you must distribute the source code for your modifications under the same GPL v2 terms.

**Can a company take Git, modify it, and sell it without sharing changes?**

No — and this is the defining characteristic of the GPL as distinct from permissive licenses. The GPL is a copyleft license. If you modify Git and distribute that modified version to others, you are legally required to make the source code for your modifications available under GPL v2. You cannot take Git, add proprietary features, and ship a closed-source product.

However, there is an important nuance here: using Git as a tool does not trigger this requirement. GitHub built an enormously profitable business built around hosting Git repositories. Amazon, Google, and Microsoft all offer managed Git hosting services. None of them are required to release their backend infrastructure as open source, because they are not distributing a modified version of the Git binary. They are running Git on their servers as a tool. The GPL's distribution clause only triggers when you distribute the software to others — not when you run it yourself, even commercially.

This distinction matters. It means that Git can coexist with commercial products built around it without those products being forced to become open source. What it prevents is the specific scenario that motivated Git's creation: a company forking the project, adding proprietary improvements, and distributing a closed version that the community becomes dependent on.

**GPL vs MIT — which would I choose?**

The MIT license is permissive: you can take the software, modify it, incorporate it into a proprietary product, and ship it closed-source without any obligation to share your changes. The GPL is reciprocal: derivative works must remain open.

For infrastructure software that an entire community depends on — the kind of software where you genuinely cannot afford to have a single company capture and close it — the GPL makes clear strategic sense. If Git had been MIT-licensed in 2005, nothing would have prevented a company from forking it, adding critical features, and distributing a proprietary version that gradually became the standard. The GPL makes that legally impossible.

For a library I was writing that I primarily wanted to be adopted as widely as possible, including in commercial products, I would probably choose MIT. The lower friction of permissive licensing means more people will use it, and for a library, wide adoption is often the goal. If I were building infrastructure that I wanted to ensure remained permanently in the commons, I would choose GPL v2, for exactly the same reason Torvalds did.

**Free as in beer vs free as in freedom**

This is probably the most important conceptual distinction in the entire FOSS philosophy. "Free as in free beer" means no cost. "Free as in freedom" — which the FSF renders in Latin as *libre* to disambiguate — means the right to use, study, modify, and share.

BitKeeper was free as in free beer. You could download and use it at no charge. But you could not look at its source code, you could not modify it, and — crucially — the people who gave it to you for free could take it back. And they did.

Git is free as in freedom. It costs nothing, but more importantly, those freedoms are guaranteed by the GPL. No company can revoke them. The source code is permanently available. The right to fork it is permanent. That is the difference, and it is not subtle — it is the entire reason Git exists.

---

### A3. The Ethics of Open Source

This section asks for reflection on some genuinely difficult questions. I will try to give honest answers rather than diplomatic ones.

**Should all software be open source?**

The argument for is compelling. Open-source software can be audited by anyone — not just the vendor's security team, but independent researchers, governments, corporations, students, and adversaries. Bugs get found. Vulnerabilities get disclosed publicly and patched. The internet's core infrastructure — Linux, Apache, OpenSSL, Python, Git itself — runs almost entirely on open-source software, and the world benefits enormously from that. Software that is open-source also cannot be arbitrarily discontinued. Companies go bankrupt. Products get sunset. Open-source projects can be forked and continued by the community when the original maintainer walks away.

The argument against is also real. Some software requires concentrated, sustained investment that volunteer communities are structurally bad at providing. Security-critical systems sometimes benefit from keeping implementation details private in the short term. Consumer products with complex customer support needs, tight hardware integration, or massive ongoing infrastructure costs may not have viable business models as open-source projects. Forcing everything to be open source would eliminate the commercial incentives that fund a significant portion of software innovation. There are categories of software — medical device firmware, avionics, certain financial systems — where the auditing benefit is real but the community governance model may not be appropriate.

My honest conclusion: open source is not universally superior to proprietary software. It is a model that works extraordinarily well for infrastructure, developer tools, platforms, and anything the entire industry depends on. It works less cleanly for specialized consumer products, for software requiring sustained expert maintenance, and for categories where liability and auditability need to be centralized. The world is better with both models available.

**Is it ethical for a company to profit from free community labor?**

This is the central tension of the modern open-source economy, and it does not have a clean answer. Red Hat built a billion-dollar company on top of Linux and GNU software, was acquired by IBM for $34 billion, and contributed back extensively — Red Hat engineers are among the most prolific contributors to the Linux kernel. Google runs its entire data-center empire on Linux and open-source software, and employs some of the most important open-source contributors in the world. Amazon built AWS — the world's largest cloud platform — substantially on open-source foundations.

Are these companies exploiting community labor? In one sense, yes. The value they extract from open-source software vastly exceeds what they contribute back in most cases. But in another sense, they are doing exactly what the licenses permit and, in some interpretations, exactly what the licenses were designed to allow. The GPL does not require proportional contribution. It requires only that you share modifications you distribute. Using software freely is, by design, free.

What I find ethically troubling is not the large companies, most of which do contribute meaningfully. It is the structural pressure on individual maintainers. The Log4Shell vulnerability in late 2021 was a useful moment of honesty for the industry. Log4j — a Java logging library used in hundreds of millions of systems, embedded in products sold by major corporations — was maintained largely by a handful of volunteers. When the vulnerability was disclosed, those volunteers were expected to produce emergency patches for infrastructure that generated enormous commercial value for companies that had never contributed a line of code or a dollar to the project. The maintainer's response — pointing out that he was not their unpaid employee — was completely justified. The ethical obligation for companies that build on open-source foundations is not just legal. It is real, and many of them do not meet it.

**Standing on the shoulders of giants**

Newton's phrase, applied to software, is almost literal. Every piece of software written today runs on a Linux kernel, compiled by GCC or Clang (both open-source), linked against glibc, managed in Git, deployed on servers running Apache or Nginx. None of these had to be reinvented. Git itself demonstrates this: Torvalds could focus on the novel distributed architecture because the operating system, the compiler, the C standard library, and the networking stack were all freely available.

Open source clearly enables original innovation. The question of whether it undermines it is more interesting. There is an argument that always-available open-source foundations lower the barrier to entry to the point of reducing competitive advantage, which reduces incentive to invest in innovation. I do not find that argument persuasive in practice. The companies that build the most interesting new software are almost universally heavy users of open-source foundations — not because they lack the resources to build their own, but because reinventing foundations is a waste of resources better spent on actual innovation. The open-source commons is not a threat to innovation. It is the substrate on which innovation happens.

---

## Part B — Linux Footprint

This section documents how Git lives on a Linux system. I installed it on Ubuntu 22.04 LTS and documented the installation and file layout directly.

### Installation

Git is available in the default package repositories of every major Linux distribution. On Ubuntu/Debian:

```bash
sudo apt update
sudo apt install git
```

On Fedora/RHEL/CentOS:

```bash
sudo dnf install git
```

Git can also be compiled from source, which is necessary if you need a version newer than what your distribution packages, or if you need to build it with non-default options. The source is available at kernel.org/pub/software/scm/git/. The build process follows the standard GNU pattern:

```bash
./configure
make
sudo make install
```

For most users on most systems, the package manager installation is the right approach — it handles dependency resolution, integrates with the system's update mechanism, and requires no manual configuration.

### Key Directories

After installation, Git's files are distributed according to the Linux Filesystem Hierarchy Standard:

| Path | What it contains |
|------|-----------------|
| `/usr/bin/git` | The main Git executable |
| `/usr/lib/git-core/` | Git sub-commands (git-fetch, git-push, git-merge, etc.) |
| `/usr/share/git-core/` | Shell completion scripts and repository templates |
| `/usr/share/doc/git/` | Documentation, changelog, and examples |
| `/etc/gitconfig` | System-wide configuration (applies to all users on the machine) |
| `~/.gitconfig` | Per-user configuration file |
| `~/.config/git/config` | Alternate location for per-user config (XDG spec) |
| `.git/` (inside any repo) | Repository metadata: object store, refs, HEAD, config, hooks |

The `.git/` directory is particularly interesting. Every Git repository carries its entire history inside this directory. The `objects/` subdirectory stores every version of every file ever committed, using a content-addressed storage model where each object is identified by the SHA-1 (or SHA-256 in newer Git) hash of its contents. This is what makes Git's integrity guarantees so strong — any corruption or tampering changes the hash and is immediately detectable.

### User and Group

Git runs as the currently logged-in user — it does not require a dedicated system user or daemon for normal operation. When you run `git commit`, that operation executes with your user's permissions. The `.git/` directory in any repository is owned by the user who initialized it.

This matters for security in shared environments. On a server hosting multiple users' repositories, incorrect permissions on `.git/` directories could allow one user to read or modify another's repository. The recommended approach for shared repository servers is to use a dedicated `git` user and group, configure repositories with appropriate group permissions, and use SSH keys for authentication. The `git-shell` utility restricts logged-in git users to only Git operations, preventing arbitrary shell access.

### Service Management

For local development use, Git has no service to manage — it is a command-line tool that runs and exits. However, `git daemon` provides a lightweight Git-protocol server for sharing repositories over a local network, and it can be managed as a systemd service:

```bash
# Start the git daemon socket
sudo systemctl start git.socket

# Enable it to start automatically on boot
sudo systemctl enable git.socket

# Check its status
sudo systemctl status git.socket
```

For production server deployments, most organizations use SSH-based access or a dedicated Git hosting application (Gitea, GitLab, etc.) rather than `git daemon`, as the daemon offers no authentication.

### Update Model

Security patches follow the standard Linux distribution pipeline. When the Git project releases a security update, the patch is applied upstream on kernel.org, packaged by each distribution's maintainers, and pushed to the distribution's repositories. Running a standard system update applies it:

```bash
sudo apt upgrade git        # Debian/Ubuntu
sudo dnf upgrade git        # Fedora/RHEL
```

This chain — upstream project, distribution packagers, system update mechanism, user machines — is a practical demonstration of how the open-source security model distributes trust and responsibility across multiple layers. No single entity controls the entire pipeline, which both reduces the risk of supply-chain attacks and means that no single entity can unilaterally push a malicious update.

---

## Part C — The FOSS Ecosystem

### What Git Depends On

Git is written in C and its dependencies are almost entirely other open-source projects:

- **GNU C Library (glibc)** — the standard C runtime on Linux
- **OpenSSL or LibreSSL** — for HTTPS transport encryption
- **libcurl** — for HTTP and HTTPS remote operations
- **zlib** — for compression of Git's packfiles and objects
- **expat** — for HTTP XML parsing (used in WebDAV support)
- **gettext** — for internationalization (Git supports many languages)

The build toolchain is also entirely open-source: GNU Make, GCC or Clang, and standard GNU autotools. There is a certain recursive neatness to this — Git itself is managed in Git, built with tools that were built with open-source tools, running on a kernel that is tracked in Git.

### What Git Has Enabled

The ecosystem that has grown around Git is vast enough that it is difficult to fully enumerate. Some of the most significant parts:

**Hosting platforms:** GitHub (2008), GitLab (2011), Bitbucket, Gitea, Forgejo, Sourcehut, and dozens of others are all built around Git. GitHub alone has over 100 million registered developers and hosts hundreds of millions of repositories. It is not an overstatement to say that GitHub, built on top of Git, has become the primary social and collaboration infrastructure of the software industry.

**Pull request-based collaboration:** The concept of contributing to a project by forking it, making changes on a branch, and submitting a pull request for review was invented at GitHub and is now the universal model for open-source contribution. It exists entirely because of Git's branching model, which makes forking and merging fast and cheap.

**CI/CD systems:** Every major continuous integration and deployment platform — Jenkins, GitHub Actions, GitLab CI, CircleCI, Travis CI, Tekton — is triggered by Git events. Pushing a commit, opening a pull request, tagging a release: these Git operations drive automated build, test, and deployment pipelines across the industry. Git is the heartbeat of modern software delivery.

**Developer tooling:** Pre-commit hooks, semantic versioning tools, changelog generators, code review bots, dependency update bots — an enormous ecosystem of developer tools is built on top of Git's hook system and API. Tools like `pre-commit`, `husky`, `commitizen`, and `semantic-release` all operate by hooking into Git's event model.

### Git and the LAMP Stack

Git is not a component of the traditional LAMP stack (Linux, Apache, MySQL, PHP) in the sense of being something that stack runs. It is more accurately described as the layer beneath it — the tool through which every component of the LAMP stack is developed, maintained, and distributed.

Apache's source code lives at gitbox.apache.org, managed in Git. MySQL and MariaDB both use Git for development. PHP's development happens on git.php.net. Linux itself — the L in LAMP — is managed in Git by Torvalds. In modern web development, every application deployed on a LAMP stack was built by a team using Git, is deployed using Git-triggered pipelines, and is maintained through Git-based code review processes. Git is the connective tissue that holds the entire ecosystem together.

### Community and Governance

Git's development community is relatively small compared to the scale of its adoption. The project is maintained by Junio C. Hamano, who has held that role since Torvalds handed it off in 2005 — an extraordinary continuity for an open-source project. Hamano works at Google, which employs him partly to work on Git.

Development happens primarily through the git mailing list (`git@vger.kernel.org`). This is a deliberate choice that reflects the project's values: Git does not use GitHub for its own development, which would create a dependency on a platform it does not control. Patches are submitted via email, reviewed by Hamano and a small group of trusted contributors, and integrated through a careful process that prioritizes correctness and backward compatibility above all else.

There are no formal elections, no foundation, no corporate governance structure. Decisions are made by consensus among active contributors, with Hamano having final say. Contributors' summits are held periodically, often co-located with Linux Foundation events or open-source conferences. Major contributors come from companies including Google, Microsoft, GitHub, and individual open-source developers, but no single organization controls the project's direction.

---

## Part D — Open Source vs Proprietary: Critical Analysis

The closest proprietary alternatives to Git are Perforce (also called Helix Core) and Azure DevOps (formerly Team Foundation Version Control). I will use Perforce as the primary comparison, as it is the most technically sophisticated proprietary alternative and is still actively used in game development and large enterprise environments.

| Dimension | Git (GPL v2) | Perforce Helix Core (Proprietary) |
|-----------|-------------|----------------------------------|
| **Cost** | Free. No licensing fees at any scale. Hosting (GitHub, GitLab) has free tiers and paid tiers, but the tool itself costs nothing. | Per-user licensing. Enterprise deployments can cost tens of thousands of dollars annually. Free tier limited to 5 users and 20 workspaces. |
| **Security (code audit)** | Full source available. Any researcher worldwide can audit the codebase. CVEs are publicly disclosed and patches are visible. | Source is closed. Users must trust Perforce's internal security practices. Vulnerability disclosure depends entirely on the vendor. |
| **Support and reliability** | Community support via mailing list, Stack Overflow, and extensive documentation. Commercial support available through GitHub, GitLab, and Atlassian. | Dedicated enterprise support with SLAs. Phone and ticket-based support. Better option for organizations that need guaranteed response times and accountability. |
| **Freedom to modify** | Full freedom under GPL v2. Organizations can fork, modify, and run their own Git distributions. GitLab and Gitea are examples of this. | None. The software cannot be inspected, modified, or forked by users under any circumstances. |
| **Community vs corporate control** | Community-driven. No single company controls Git's direction. The mailing list is the decision-making forum, and Hamano has maintained extraordinary continuity and independence. | Fully controlled by Perforce Software (formerly Perforce, now part of a private equity portfolio). Roadmap is set by business priorities. |
| **Large binary file handling** | Historically poor. Git's object model is not designed for very large binary files — game assets, video files, CAD drawings. Git LFS partially addresses this but adds complexity. | Excellent. Perforce was specifically designed for large binary files and is the industry standard for game development and media production for this reason. |
| **Learning curve** | Steep for beginners. Git's mental model (staging area, detached HEAD, rebase vs merge) genuinely confuses new developers. | Simpler mental model for basic operations, but less powerful for branching workflows. |

**Overall verdict:**

For virtually any software development context — web development, mobile applications, data science, AI/ML, embedded systems, DevOps — Git is the clear recommendation, and I would make it without hesitation. Its ecosystem advantage is now so overwhelming that choosing a proprietary alternative creates friction with every tool, platform, and workflow the industry has built over the past fifteen years. The open-source model means its security can be audited, its development is not controlled by any single corporate interest, and it will continue to exist and improve regardless of any business decision.

The one area where Perforce maintains a genuine advantage is in environments that work primarily with very large binary files. Game studios working with multi-gigabyte asset libraries, media production companies working with high-resolution video, and engineering firms working with large CAD assemblies all have legitimate reasons to evaluate Perforce over Git. Git LFS has improved the situation but has not fully closed the gap.

Would I contribute to Git? Yes. It is one of the few projects where even small improvements — better documentation, edge-case bug fixes, improved error messages — benefit every developer on the planet. The contribution process (email-based patches to the mailing list) is more formal and slower than GitHub-style pull requests, but that rigor is part of why Git's codebase is as reliable as it is.

---

## 5. Shell Script Documentation

Five shell scripts were written to accompany this report. Each script is documented below with its purpose, the shell scripting concepts it demonstrates, and key sections of the code.

---

### Script 1 — System Identity Report

**File:** `script1_system_identity.sh`

**Purpose:** This script serves as a welcome screen for the audit. It collects information about the Linux system it is running on — the distribution name, kernel version, current user, home directory, system uptime, and date/time — and presents it in a formatted table. It also displays the open-source license that covers the operating system.

I wrote this as if it were something you might run at the start of a session to confirm which system you are working on, which felt appropriate for an audit context.

**Shell Concepts Demonstrated:**
- Variables (`STUDENT_NAME`, `KERNEL`, `USER_NAME`, etc.)
- Command substitution using `$()` to capture live output of `uname -r`, `whoami`, `uptime -p`, `date`, and `lsb_release`
- The `$HOME` environment variable
- `echo` with string formatting and padding
- Conditional fallback: if `lsb_release` is not available, the script reads `/etc/os-release` instead

**Key code section:**

```bash
KERNEL=$(uname -r)
DISTRO=$(lsb_release -d 2>/dev/null | cut -f2 || \
         cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')
USER_NAME=$(whoami)
UPTIME=$(uptime -p)
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')
```

Each variable uses command substitution — the `$()` syntax runs a command and captures its standard output as a string. The `||` in the `DISTRO` line is a fallback: if `lsb_release` is not found (exits with an error), the alternative command runs instead. This is a practical pattern for writing scripts that work across different Linux distributions.

---

### Script 2 — FOSS Package Inspector

**File:** `script2_package_inspector.sh`

**Purpose:** This script checks whether the Git package is installed on the system, retrieves its version and metadata, and then uses a `case` statement to print a philosophy note about the package. The goal was to write something that would actually be useful on a real system — you could change the `PACKAGE` variable to any of the software options from the approved list and get a meaningful output.

**Shell Concepts Demonstrated:**
- `if-then-else` for branching logic
- `case` statement for pattern-matching against the package name
- `dpkg -l` and `rpm -qi` for package information on different distributions
- `grep -E` with a pipe to filter output to relevant fields
- Redirecting stderr to `/dev/null` with `&>/dev/null` to suppress error output

**Key code section:**

```bash
if dpkg -l "$PACKAGE" &>/dev/null 2>&1; then
    echo "$PACKAGE is installed (dpkg)"
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "Version: "$3}'
elif rpm -q "$PACKAGE" &>/dev/null 2>&1; then
    rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary)"
else
    if which "$PACKAGE" &>/dev/null 2>&1; then
        echo "Binary found at: $(which $PACKAGE)"
    fi
fi
```

The script tries three different methods of finding the package in order of specificity. The `case` statement that follows handles several possible package names, with a wildcard `*` case at the end to handle anything else gracefully.

---

### Script 3 — Disk and Permission Auditor

**File:** `script3_disk_auditor.sh`

**Purpose:** This script loops through a list of important system directories and reports on the permissions, ownership, and disk usage of each one. It also specifically looks for Git configuration files and reports their permissions — connecting the practical Linux skills with the subject of the audit.

Understanding file permissions is a core part of Linux security. A directory with permissions set to `777` (world-writable) is a potential security issue. A log directory accessible by non-root users may expose sensitive information. This script makes those questions visible at a glance.

**Shell Concepts Demonstrated:**
- `for` loop iterating over a Bash array
- The `-d` file test operator to check if a path is a directory
- The `-f` file test operator to check if a path is a regular file
- `ls -ld` with `awk` to extract the permission string, owner, and group
- `du -sh` with `cut` to get human-readable directory sizes
- `printf` for aligned columnar output

**Key code section:**

```bash
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS $OWNER:$GROUP" "$SIZE"
    else
        printf "  %-20s %-35s\n" "$DIR" "[NOT FOUND]"
    fi
done
```

The `"${DIRS[@]}"` syntax iterates over all elements of the array correctly, including elements that contain spaces. The `2>/dev/null` on `du` suppresses permission errors for directories we cannot read. The `printf` format string with `%-20s` left-aligns each field in a fixed-width column, producing clean tabular output.

---

### Script 4 — Log File Analyzer

**File:** `script4_log_analyzer.sh`

**Purpose:** This script reads a log file line by line, counts how many lines contain a specified keyword, and prints the last five matching lines. It accepts the log file path and keyword as command-line arguments, with a sensible default for the keyword. If no log file is provided, it generates a sample log file and analyzes that instead — so the script always has something to demonstrate on, even without access to real system logs.

Log analysis is one of the most common real-world uses of shell scripting. System administrators routinely write variations of this script to monitor for errors, count warnings, or extract specific events from large log files.

**Shell Concepts Demonstrated:**
- Command-line argument handling with `$1` and `${2:-"error"}` (default value syntax)
- File validation with `-f` (exists and is regular file) and `-s` (non-empty)
- `while IFS= read -r` loop for safe line-by-line file reading
- Counter variables with `$(( ))` arithmetic expansion
- `if-then` inside a loop for conditional counting
- `grep -iq` for case-insensitive matching
- `tail` to extract the last N matching lines
- Here-document (`<<EOF`) to generate a demo log file

**Key code section:**

```bash
LOGFILE=$1
KEYWORD=${2:-"error"}
COUNT=0

while IFS= read -r LINE; do
    TOTAL=$((TOTAL + 1))
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))
    fi
done < "$LOGFILE"

echo "Keyword '$KEYWORD' found $COUNT times in $LOGFILE"

grep -i "$KEYWORD" "$LOGFILE" | tail -5 | while IFS= read -r MATCH; do
    echo "  >> $MATCH"
done
```

The `IFS=` before `read -r` is important: it prevents the shell from stripping leading whitespace from each line, which matters for log files that use indentation. The `-r` flag prevents backslash interpretation. Together, these ensure that every line is read exactly as it appears in the file.

---

### Script 5 — Open Source Manifesto Generator

**File:** `script5_manifesto_generator.sh`

**Purpose:** This is the most personal script in the set. It asks the user three questions interactively, then assembles the answers into a short open-source philosophy statement and saves it to a text file. The output is different for every person who runs it, which felt appropriate for a section of the course concerned with values and reflection rather than technical skills.

I wanted this script to produce output that actually reads like something a person would say — not a generic template. The three questions were chosen to get at what the person actually uses, what they actually value, and what they would actually build.

**Shell Concepts Demonstrated:**
- `read -p` for interactive user input
- String concatenation by embedding variables inside quoted strings
- File output with `>` (create/overwrite the file with the first line) and `>>` (append subsequent lines)
- The `date` command with a format string
- `whoami` for generating a dynamic output filename
- `cat` to display the generated file
- Inline comments explaining the alias concept (aliases are interactive-shell shortcuts defined with `alias name='command'` that do not persist in non-interactive scripts, but demonstrate the same principle of shorthand for repeated commands)

**Key code section:**

```bash
read -p "  1. Name one open-source tool you use every day: " TOOL
read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM
read -p "  3. Name one thing you would build and share freely: " BUILD

DATE=$(date '+%d %B %Y')
OUTPUT="manifesto_$(whoami).txt"

echo "MY OPEN SOURCE MANIFESTO" > "$OUTPUT"
echo "Generated on: $DATE" >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Every day, I rely on $TOOL — built by people who chose to" >> "$OUTPUT"
echo "share their work rather than lock it away." >> "$OUTPUT"
echo "To me, freedom in software means $FREEDOM." >> "$OUTPUT"
echo "That is why I would build $BUILD and release it openly." >> "$OUTPUT"
```

The `>` operator on the first `echo` creates the file (or overwrites it if it already exists). Every subsequent `>>` appends to it. The output filename includes the result of `$(whoami)`, so each user who runs the script gets their own file named after their username.

---

## 6. Conclusion

Working through this audit, the thing that has stayed with me most is how non-inevitable Git's existence was. There was a moment in 2005 where the Linux kernel project had no version control system and the most capable developer in the project sat down and made a decision: instead of adopting the best available proprietary tool, he would write a new open-source one. That decision required confidence that the thing he built would actually be better. And it was.

The GPL v2 license on Git is not just a legal formality. It is the mechanism that ensures the decision Torvalds made in 2005 cannot be undone. No company can take Git, improve it, and close it. The freedom is permanent by design. Every developer working today — including every developer working on proprietary products — benefits from that decision.

The ethical questions this audit raised do not resolve neatly. The relationship between large corporations and the open-source commons they depend on is genuinely complicated, and the burnout of volunteer maintainers maintaining critical infrastructure is a real problem the industry has not solved. But the answer is not to abandon the open-source model. It is to take the social obligations of the model seriously — to contribute back, to fund maintainers, to treat the commons as infrastructure worth investing in rather than a free resource to be extracted from.

Every line of code written today sits on top of open-source foundations that were built by people who chose to share rather than hoard. Understanding that, and understanding the licenses and philosophy that make it permanent, feels like the minimum required for anyone who is going to build on top of those foundations professionally.

---

## 7. References

**On Open Source Philosophy**
- GNU Project — "The Free Software Definition": gnu.org/philosophy/free-sw.html
- Open Source Initiative — "The Open Source Definition": opensource.org/osd
- Eric S. Raymond — "The Cathedral and the Bazaar": catb.org/~esr/writings/cathedral-bazaar
- GNU General Public License v2 full text: gnu.org/licenses/gpl-2.0.html

**On Git's History**
- Linus Torvalds — Git initial announcement on the Linux Kernel Mailing List, April 6 2005
- Junio C. Hamano — Git project page: git-scm.com
- Git source repository: kernel.org/pub/software/scm/git/

**On Linux and Shell Scripting**
- William Shotts — "The Linux Command Line" (freely available at linuxcommand.org)
- GNU Bash Manual: gnu.org/software/bash/manual
- Linux Filesystem Hierarchy Standard: pathname.com/fhs/

**On Licensing**
- SPDX License List: spdx.org/licenses
- Choose a License: choosealicense.com
- GPL-2.0 SPDX entry: spdx.org/licenses/GPL-2.0-only.html

---

*Report submitted by Agnish Mondal (24BAI10423) for the Open Source Software course — VITyarthi portal.*
