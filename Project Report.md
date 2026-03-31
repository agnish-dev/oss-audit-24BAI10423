# The Open Source Audit
### A Capstone Project for OSS NGMC Course

---

**Student Name:** Agnish Mondal  
**Registration Number:** 24BAI10423  
**Course:** Open Source Software | Units 1-5  
**Chosen Software:** Git  
**Date of Submission:** March 31, 2026  

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Part A - Origin and Philosophy](#part-a--origin-and-philosophy)
   - [A1. The Problem Git Was Created to Solve](#a1-the-problem-git-was-created-to-solve)
   - [A2. The License - What GPL v2 Actually Says](#a2-the-license--what-gpl-v2-actually-says)
   - [A3. The Ethics of Open Source](#a3-the-ethics-of-open-source)
3. [Part B - Linux Footprint](#part-b--linux-footprint)
4. [Part C - The FOSS Ecosystem](#part-c--the-foss-ecosystem)
5. [Part D - Open Source vs Proprietary](#part-d--open-source-vs-proprietary)
6. [Shell Script Documentation](#6-shell-script-documentation)
7. [Conclusion](#7-conclusion)
8. [References](#8-references)

---

## 1. Introduction

Git is the tool that makes collaboration on software projects practical. It is not only the version control system installed on nearly every developer workstation, but also the mechanism through which code history is preserved, shared, and improved.

This report examines Git from three perspectives: the practical reason it was created, the license that protects it, and the ethical commitments it represents. It also traces how Git behaves on Linux, how it fits into the broader open-source community, and how it compares to a proprietary alternative. Finally, I document the shell scripts I wrote for this project and explain the Linux skills they demonstrate.

---

## Part A - Origin and Philosophy

### A1. The Problem Git Was Created to Solve

In the early 2000s, the Linux kernel was already a huge project with developers distributed around the world. The workflow at the time relied on email patches, manual integration, and a handful of central maintainers. This process was fragile: patches arrived in different formats, branch histories were hard to reconcile, and coordination became a bottleneck.

To address that problem, the kernel project used BitKeeper for a while. BitKeeper introduced the idea that each developer could have a complete local copy of the repository, instead of depending on one central server. That model solved many collaboration problems, but it had one fatal flaw: BitKeeper was proprietary.

For an open-source project like Linux, depending on a closed tool created a risk. A vendor could change the terms, revoke access, or decide to withhold service. In 2005, that risk materialized when the free access arrangement ended. The kernel community suddenly needed a version control system that was both distributed and free.

Linus Torvalds responded by writing Git. He set out with a few clear requirements:

- every contributor must keep a complete history locally
- the system must support branching and merging efficiently
- data integrity must be verifiable
- the tool must be open and redistributable

Git was developed quickly and used for the next kernel release within weeks. It was released under GPL v2 immediately, ensuring that the community would never again be dependent on a single proprietary source-control vendor.

### A2. The License - What GPL v2 Actually Says

Git is distributed under the GNU General Public License version 2. This license is important because it defines what users are allowed to do with the software.

The key freedoms in GPL v2 are:

- run the software for any purpose
- study and modify the source code
- redistribute copies of the original
- redistribute copies of modified versions under the same license

These freedoms are the reason Git is not just free in price, but free in rights. Anyone may inspect the code, make changes, and share those changes.

The GPL is also a reciprocal license. If you distribute a modified version of Git, you must also distribute the source code for those modifications under GPL v2. That prevents a company from taking Git, adding proprietary changes, and shipping a closed version.

There is an important distinction to understand, however. Using Git as a tool does not trigger the copyleft requirement. Services such as GitHub, GitLab, and Bitbucket can run Git on their servers and provide hosted repositories without having to open-source their infrastructure. The requirement only applies when modified software is distributed to others.

This is why GPL v2 is often chosen for shared infrastructure software. A permissive license such as MIT allows anyone to take the code and incorporate it into a closed product. GPL v2 makes it much harder for a tool that the community relies on to be captured and closed.

### A3. The Ethics of Open Source

Open source is not simply a technical alternative to proprietary software; it is a set of values.

Should all software be open source? For infrastructure, development tools, and libraries that many people depend on, the answer is strong yes. Open source means the code can be audited, bugs can be fixed by anyone, and the project does not disappear when a company stops supporting it.

But not every project is best served by open source. Some products require substantial, centralized investment. Some industries need strict regulatory accountability, and some ideas need temporary secrecy for legal or safety reasons. The healthiest software ecosystem supports both models while making sure the commons are respected.

Is it ethical for companies to profit from community contributions? This is a difficult question. Large firms often extract enormous value from open-source software. Many of them also contribute back, but the balance is uneven.

A clearer ethical rule is this: if you build on open-source components, you should support the people who maintain them. The Log4j incident in 2021 showed how fragile that ecosystem can be. A vulnerability in a widely used library affected countless products, while the maintainers who had to fix it were largely unpaid volunteers. That outcome is a sign that our industry needs better funding and recognition for maintainers.

Open source is most powerful when it is treated as shared infrastructure rather than free labor. In that sense, Git is a model: it is free software that also protects the community from dependency on a single, proprietary vendor.

---

## Part B - Linux Footprint

Git is available in every major Linux distribution, and it can be installed from package repositories or built from source.

### Installing Git

On Debian/Ubuntu based systems:

```bash
sudo apt update
sudo apt install git
```

On Fedora/RHEL based systems:

```bash
sudo dnf install git
```

To build from source:

```bash
./configure
make
sudo make install
```

### Important Git locations on Linux

| Path | Purpose |
|------|---------|
| `/usr/bin/git` | primary executable |
| `/usr/lib/git-core/` | helper subcommands like `git-fetch`, `git-merge` |
| `/usr/share/git-core/` | completion scripts and templates |
| `/usr/share/doc/git/` | documentation and release notes |
| `/etc/gitconfig` | system-wide default settings |
| `~/.gitconfig` | user-specific configuration |
| `.git/` inside a repo | repository history and metadata |

The `.git/` directory stores the full object database, references, and config for each repository. That means every cloned repository has a complete history locally.

### Permissions and security

Git commands run with the privileges of the current user. There is no system service required for normal development work. In a shared environment, incorrect permissions on repository directories can expose data or allow unauthorized changes.

For hosted repositories, it is common to create a dedicated `git` user, limit access with SSH keys, and use tools such as `git-shell` to restrict users to Git operations only.

### Server support

Git itself is a command-line tool, but it can also run as a basic network service via `git daemon`. On Linux, this socket can be managed with systemd:

```bash
sudo systemctl start git.socket
sudo systemctl enable git.socket
sudo systemctl status git.socket
```

For real production hosting, services like GitLab or Gitea are preferred. They provide authentication, web interfaces, and repository management beyond what `git daemon` offers.

### Update model

Security and bug fixes flow from the Git project to distribution maintainers to end users. When a new Git release is published, distributions package it and distribute it through their normal update system. Users then receive the update through `apt upgrade` or `dnf upgrade`.

This chain is a practical example of how open-source software is maintained by a network of collaborators rather than a single vendor.

---

## Part C - The FOSS Ecosystem

### Git's dependencies

Git is written in C and built on open-source components:

- `glibc` for standard runtime support
- `zlib` for compression
- `libcurl` for network access
- `OpenSSL` or `LibreSSL` for secure transport
- `expat` for XML parsing in some remote protocols
- `gettext` for translation support

The build environment itself is also open source, including `make`, `gcc`/`clang`, and the tools used to assemble the source.

### What Git enabled

Git is the foundation for many modern workflows:

- hosted repository services such as GitHub, GitLab, and Bitbucket
- pull request and merge request collaboration models
- CI/CD pipelines triggered by Git events
- developer tooling such as hooks, code linters, and release automation

The pull request workflow, for example, depends on Git's cheap branching and merging. That model has become the default way teams review and integrate changes.

### Git and Linux-based development

Git is not part of the LAMP stack itself, but it is the tool used to build and maintain components of that stack. Apache, MySQL, PHP, and many web applications use Git to manage releases, track patches, and collaborate across teams.

In practice, every major open-source server project uses Git, and almost every deployment pipeline is driven by Git commits and tags.

### Community and governance

Git's development is intentionally small and focused. Junio C. Hamano has been the project maintainer since Linus passed the responsibility to him. Development happens on the `git` mailing list, not on commercial hosting platforms.

That governance model reflects the project's values: avoid depending on someone else's platform, keep the workflow transparent, and let the code speak for itself. Patches are reviewed by a core group of maintainers, and backward compatibility is treated as a central concern.

---

## Part D - Open Source vs Proprietary

For comparison, I evaluate Git against Perforce Helix Core, a proprietary version control system commonly used in industries with large binary assets.

| Dimension | Git (GPL v2) | Perforce Helix Core |
|-----------|--------------|---------------------|
| Cost | free software with no license fee | paid license required for large teams |
| Auditability | source code available for review | source closed, trust required |
| Modification | can be forked and changed under GPL | cannot modify the core server software |
| Governance | community-driven, no single owner | controlled by Perforce Software |
| Large binary files | supported with Git LFS but not ideal | designed for large assets and binaries |
| Learning curve | steeper for newcomers | often easier for basic operations |

Git is the better choice for the vast majority of software teams because its ecosystem is broad, its tooling is interoperable, and it can be hosted almost anywhere. Proprietary systems like Perforce are still useful when the workload includes very large non-text assets and when an organization prefers a vendor-supported solution.

The strongest argument for Git is not only its technical capabilities, but also the fact that it is a shared foundation rather than a proprietary platform. That makes it safer for long-term collaboration.

---

## 6. Shell Script Documentation

Five supporting shell scripts were created for this audit. Each script illustrates a different Linux scripting concept.

### Script 1 - System Identity Report

- File: `script1_system_identity.sh`
- Purpose: collect system metadata and display it in a readable format
- Concepts: command substitution, environment variables, fallback commands

This script reads the kernel version, distribution name, current user, uptime, and current date. It uses `$()` to capture command output and provides a fallback when `lsb_release` is not available.

### Script 2 - FOSS Package Inspector

- File: `script2_package_inspector.sh`
- Purpose: check whether a package is installed and display its version
- Concepts: conditional statements, package query commands, pattern matching

It tests for Debian and RPM installations, then reports version details if the package is found. A `case` statement is used to print a short note based on the target package.

### Script 3 - Disk and Permission Auditor

- File: `script3_disk_auditor.sh`
- Purpose: examine directory ownership, permissions, and disk usage
- Concepts: arrays, loops, file tests, formatted output

The script iterates over a list of directories, verifies whether each exists, and prints the result in aligned columns. It also uses `du` to compute directory size information.

### Script 4 - Log File Analyzer

- File: `script4_log_analyzer.sh`
- Purpose: count keyword matches in a log file and display recent matches
- Concepts: command-line arguments, safe line reading, counters, text filtering

The script accepts a log file and an optional search keyword. It reads the file line by line, counts matches, and prints the final summary plus the last few matching entries.

### Script 5 - Open Source Manifesto Generator

- File: `script5_manifesto_generator.sh`
- Purpose: prompt the user for input and create a short personal manifesto
- Concepts: interactive input, file redirection, string interpolation

This script asks three questions and writes a formatted statement to a text file. It demonstrates how to gather user responses and save them to disk.

---

## 7. Conclusion

Git was created because the Linux kernel community needed a version control system that could scale without surrendering control to a proprietary vendor. The project?s origins are a reminder that technical design and social values are deeply connected.

GPL v2 is what keeps Git open to this day. It allows anyone to use, inspect, and improve the software, while preventing a distributed derivative from being closed.

The ethics of open source are not simple, but they are clear enough to matter: if you rely on free software, you should support the people who maintain it. Open source is strongest when it is treated as shared infrastructure rather than a free resource to be consumed without contribution.

In my view, Git is one of the best examples of that model. It solves a concrete collaboration problem, it is protected by a license that keeps it open, and it has enabled an ecosystem of tools and workflows that power modern software development.

---

## 8. References

- GNU Project - "The Free Software Definition": https://www.gnu.org/philosophy/free-sw.html
- Open Source Initiative - "The Open Source Definition": https://opensource.org/osd
- GNU General Public License v2: https://www.gnu.org/licenses/old-licenses/gpl-2.0.html
- Git project site: https://git-scm.com/
- Kernel.org Git source: https://kernel.org/pub/software/scm/git/
- Linux Filesystem Hierarchy Standard
- GNU Bash Manual
