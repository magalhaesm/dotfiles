#!/usr/bin/env python3
# -*- encoding: utf-8 -*-

import os
import subprocess
import sys

import bat_themes

CONFIG = os.getenv("XDG_CONFIG_HOME")
KITTY_THEMES = CONFIG + "/kitty/themes"
COLORS = CONFIG + "/terminal/colors"


bat_themes = bat_themes.themes


def get_themes_from(path: str, full=False) -> list:
    """Obtém temas em um diretório."""
    themes = os.listdir(path)
    themes.reverse()
    exclude = "diff.conf"
    if exclude in themes:
        themes.remove("diff.conf")
    if full:
        return [path + "/" + theme for theme in themes]
    return [theme for theme in themes]


def basename(file: str) -> str:
    """Remove a extensão do nome de um arquivo."""
    return os.path.basename(file).split(".")[0]


def get_name(file: str) -> str:
    name = basename(file)
    return " ".join([s.capitalize() for s in name.split("_")])


def extract_colors(file: str) -> dict:
    """Retorna a paleta de cores de um arquivo de tema."""
    colors = {}
    with open(file, "r") as f:
        data = f.readlines()
        for line in data:
            if line.startswith("color"):
                parts = line.split(" ")
                key = parts[0]
                value = parts[-1].replace("\n", "")
                colors[key] = value
    return colors


def export_colors(file: str, colors: dict) -> None:
    with open(file, "w") as f:
        name = get_name(file)
        print(f"Creating {name}")

        f.write(f"# THEME: {name}\n")
        f.write(f"export TERMINAL_THEME='{basename(file)}'\n\n")
        for k, v in colors.items():
            f.write(f"export {k}='{v}'\n")

        bat_theme = bat_themes.get(name)
        if bat_theme:
            f.write(f"\nexport BAT_THEME='{bat_theme}'\n")


def load_themes():
    themes = get_themes_from(KITTY_THEMES, True)

    for theme in themes:
        colors = extract_colors(theme)
        new_file = COLORS + "/" + basename(theme)
        export_colors(new_file, colors)


def select_theme():
    themes = get_themes_from(COLORS)
    selection = "\n".join([get_name(theme) for theme in themes])

    try:
        echo = subprocess.Popen(["echo", selection], stdout=subprocess.PIPE)
        selected = subprocess.check_output(["fzf"], stdin=echo.stdout)
    except subprocess.CalledProcessError:
        return None
    else:
        return selected.decode("utf-8")


def set_theme():
    theme = select_theme()
    if theme:
        theme = theme.replace("\n", "")
        kitty_cmd = "kitty +kitten themes --reload-in=all " + theme
        subprocess.run([kitty_cmd], shell=True)
        print(theme.lower().replace(" ", "_"))


if __name__ == "__main__":
    if sys.argv[1] == "set":
        set_theme()
    elif sys.argv[1] == "load":
        load_themes()
