default:
    @just --justfile ~/.window.justfile --list

resize width height id="":
    yabai -m window {{ id }} --resize abs:{{ width }}:{{ height }}

resize-1080 id="":
    @just --justfile ~/.window.justfile resize-window 1920 1080 {{ id }}

resize-900 id="":
    @just --justfile ~/.window.justfile resize-window 1600 900 {{ id }}

resize-768 id="":
    @just --justfile ~/.window.justfile resize-window 1024 768 {{ id }}

resize-720 id="":
    @just --justfile ~/.window.justfile resize-window 1280 720 {{ id }}

show:
    yabai -m query --windows | jq '.[] | {id,app,title}'

this-id:
    yabai -m query --windows | jq '.[] | select(."has-focus" == true).id'
