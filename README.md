# My configuration for Neovim

## Requirements

- Neovim 0.12 or newer.
- [ripgrep](https://github.com/BurntSushi/ripgrep) on `PATH` for Telescope's live grep (`<leader>sg`).
- Node.js and npm for the Cucumber language server, which Mason installs as `cucumber-language-server`.

Restart Neovim after installing dependencies so it picks up the updated `PATH`.

## Gherkin step definitions

Open a `.feature` file and press `gd` on a step to find its definition. The first
index can take some time. The language server uses its default feature and glue
patterns unless overridden for a project.

For project-specific patterns or Cucumber parameter types, create
`cucumber-projects.lua` in the Neovim configuration directory. It is ignored by
Git and returns settings for the current project's root:

```lua
return function(client)
  local root = vim.fs.normalize(client.config.root_dir or "")
  if root == "/path/to/project" then
    return {
      features = { "features/**/*.feature" },
      glue = { "steps/**/*.ts" },
      parameterTypes = {
        { name = "custom", regexp = "[A-Za-z]+" },
      },
    }
  end
end
```

Patterns are relative to the project root. For very large projects, limiting
`features` to the initially opened feature can reduce indexing time; step
definition navigation still works in other open features, but completion uses
the indexed feature's steps.
