#!/usr/bin/env python3

import os

from kitty.boss import Boss

COMMIT_TYPE_ICONS = {
    "feat": "🌟",
    "fix": "🐛",
    "docs": "📚",
    "refactor": "🔨",
    "perf": "🚀",
    "test": "🚨",
    "build": "🚧",
    "dev": "🎩",
    "ci": "🤖",
    "chore": "🧹",
    "a11y": "♿️",
}


def to_camel_case(s: str) -> str:
    s = s.replace("-", "_").replace(".", "_")
    return "".join(part.capitalize() for part in s.split("_") if part)


def project_abbr(project: str) -> str:
    env_key = "PROJECT_" + project.upper().replace("-", "_").replace(".", "_")
    override = os.environ.get(env_key)
    if override:
        return override
    if any(c.isupper() for c in project):
        abbr = "".join(c for c in project if c.isupper())
        if abbr:
            return abbr
    return "".join(
        part[0].upper()
        for part in project.replace("-", "_").replace(".", "_").split("_")
        if part
    )


def worktree_short(worktree: str) -> str:
    parts = worktree.split("-", 1)
    if len(parts) == 2 and parts[0] in COMMIT_TYPE_ICONS:
        icon = COMMIT_TYPE_ICONS[parts[0]]
        return f"{icon}{parts[1]}"
    if len(parts) == 2 and parts[0] in {"style", "revert"}:
        return f"{parts[0]}:{parts[1]}"
    return worktree


def main(args) -> str | None:
    cwd = os.path.abspath(args[1]) if len(args) > 1 else os.getcwd()
    projects_dir = os.environ.get("PROJECTS", os.path.expanduser("~/projects"))
    dotfiles_dir = os.path.expanduser("~/dotfiles")

    if cwd.startswith(dotfiles_dir):
        return "dotfiles"

    if cwd.startswith(projects_dir + os.sep):
        parts = os.path.relpath(cwd, projects_dir).split(os.sep)

        # Legacy layout: ~/projects/worktrees/<project>/<worktree>
        if parts[0] == "worktrees" and len(parts) >= 3:
            return f"[{project_abbr(parts[1])}]{worktree_short(parts[2])}"

        if parts[0] == "sandbox" and len(parts) >= 2:
            return f"🏖️{to_camel_case(parts[1])}"

        # Per-project layout: ~/projects/<project>/{repo,worktrees,docs}
        if len(parts) >= 3 and parts[1] == "worktrees":
            return f"[{project_abbr(parts[0])}]{worktree_short(parts[2])}"
        if len(parts) >= 2 and parts[1] == "docs":
            return f"📚{to_camel_case(parts[0])}"

        if parts[0]:
            return to_camel_case(parts[0])

    return input("Enter a title for the tab: ").strip() or None


def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss):
    window = boss.window_id_map.get(target_window_id)
    tab = boss.tab_for_id(window.tab_id) if window else None
    if tab is None:
        tab = boss.active_tab

    if tab is None:
        return

    if answer:
        tab.set_title(answer)
