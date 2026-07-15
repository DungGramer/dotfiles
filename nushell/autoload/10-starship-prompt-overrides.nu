# Overrides for the generated `vendor/autoload/starship.nu`.
#
# Nushell loads user autoload files (this directory) AFTER vendor autoload files, so anything
# set here wins. Editing `vendor/autoload/starship.nu` directly would not survive: `config.nu`
# regenerates that file on every startup via `starship init nu | save -f`.

# `starship.toml` defines no `right_format`, so `starship prompt --right` always returns "".
# Keeping the generated closure would spawn starship.exe once per prompt (plus `job list`,
# since starship 1.26) only to render nothing. That closure is also what reports
#
#     Error: nu::shell::error
#       x Operation interrupted
#
# when Ctrl+C lands while the prompt is still rendering: nushell prints the interrupt, then
# falls back to its built-in date/time right prompt.
#
# Assign a plain "" rather than unsetting the variable. With PROMPT_COMMAND_RIGHT unset,
# nushell renders its own date/time right prompt instead of an empty one.
#
# Delete this file if `right_format` is ever added to starship.toml.
$env.PROMPT_COMMAND_RIGHT = ""
