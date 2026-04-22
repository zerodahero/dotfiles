#!/usr/bin/env python3

import os
from kitty.boss import Boss

COMMIT_TYPE_ICONS = {
    'feat':     '🌟',
    'fix':      '🐛',
    'docs':     '📚',
    'refactor': '🔨',
    'perf':     '🚀',
    'test':     '🚨',
    'build':    '🚧',
    'ci':       '🤖',
    'chore':    '🧹',
}

def to_camel_case(s: str) -> str:
    s = s.replace('-', '_').replace('.', '_')
    return "".join(part.capitalize() for part in s.split('_') if part)

def project_abbr(project: str) -> str:
    env_key = 'PROJECT_' + project.upper().replace('-', '_').replace('.', '_')
    override = os.environ.get(env_key)
    if override:
        return override
    if any(c.isupper() for c in project):
        abbr = ''.join(c for c in project if c.isupper())
        if abbr:
            return abbr
    return ''.join(part[0].upper() for part in project.replace('-', '_').replace('.', '_').split('_') if part)

def worktree_short(worktree: str) -> str:
    parts = worktree.split('-', 1)
    if len(parts) == 2 and parts[0] in COMMIT_TYPE_ICONS:
        icon = COMMIT_TYPE_ICONS[parts[0]]
        return f"{icon}:{parts[1]}"
    if len(parts) == 2 and parts[0] in {'style', 'revert'}:
        return f"{parts[0]}:{parts[1]}"
    return worktree

def main(args) -> str | None:
    cwd = os.getcwd()
    projects_dir = os.environ.get('PROJECTS', os.path.expanduser('~/projects'))
    dotfiles_dir = os.path.expanduser('~/dotfiles')

    if cwd.startswith(dotfiles_dir):
        return "dotfiles"

    worktrees_dir = os.path.join(projects_dir, 'worktrees')
    if cwd.startswith(worktrees_dir + os.sep):
        parts = os.path.relpath(cwd, worktrees_dir).split(os.sep)
        if len(parts) >= 2:
            return f"[{project_abbr(parts[0])}] {worktree_short(parts[1])}"

    if cwd.startswith(projects_dir + os.sep):
        try:
            relative_path = os.path.relpath(cwd, projects_dir)
        except ValueError:
            return None

        if relative_path and relative_path != '.':
            project_name = relative_path.split(os.sep)[0]
            if project_name:
                return to_camel_case(project_name)

    return input('Enter a title for the tab: ').strip() or None

def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss):
    tab = boss.active_tab

    if tab is None:
        return

    if answer:
        tab.set_title(answer)
