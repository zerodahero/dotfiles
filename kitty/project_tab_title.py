#!/usr/bin/env python3

import os
from kitty.boss import Boss

def to_camel_case(s: str) -> str:
    s = s.replace('-', '_').replace('.', '_')
    return "".join(part.capitalize() for part in s.split('_') if part)

def main(args) -> str | None:
    # Get the current working directory of the active window.
    cwd = os.getcwd()
    projects_dir = os.environ.get('PROJECTS', os.path.expanduser('~/projects'))
    dotfiles_dir = os.path.expanduser('~/dotfiles')

    if cwd.startswith(dotfiles_dir):
        return "dotfiles"

    # Check if the current directory is a subdirectory of ~/projects.
    if cwd.startswith(projects_dir + os.sep):
        try:
            relative_path = os.path.relpath(cwd, projects_dir)
        except ValueError:
            return None # Should not happen on Unix-like systems

        # The first component of the relative path is the project folder name.
        if relative_path and relative_path != '.':
            project_name = relative_path.split(os.sep)[0]
            if project_name:
                return to_camel_case(project_name)

    # Not in a project directory, ask for a title.
    return input('Enter a title for the tab: ').strip() or None

def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss):
    # Get the tab that the kitten was launched from.
    tab = boss.active_tab

    if tab is None:
        return

    if answer:
        tab.set_title(answer)
    else:
        pass
