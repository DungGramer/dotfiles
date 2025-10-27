## Dotfiles

### Add Global gitignore

```bash
mv .gitignore_global ~/
git config --global core.excludesFile ~/.gitignore_global
```

```bash
mv .gitconfig ~/
```

```bash
mv .gitattributes_global ~/
git config --global core.attributesfile ~/.gitattributes_global
```

### Add Nushell config

```bash
mv ./nushell/config.nu ~/AppData/Roaming/nushell/config.nu
mv ./nushell/env.nu ~/AppData/Roaming/nushell/env.nu
```


### Aliases

#### Change directory
| Command | Replacement     | Description                             |
| ------- | -----------     | --------------------------------------- |
| `..`    | `cd ..`         | Go to parent directory                  |
| `...`   | `cd ../..`      | Go to grandparent directory             |
| `....`  | `cd ../../..`   | Go to great grandparent directory       |
| `.....` | `cd ../../../..`| Go to great great grandparent directory |
| `~`     | `cd ~`          | Go to home directory                    |

#### NPM

| Command | Replacement              | Description                                                                |
| ------- | ------------------------ | -------------------------------------------------------------------------- |
| `n`     | `npm`                    | NPM is a package manager for JavaScript and related programming languages. |
| `ns`    | `npm start`              | Start the project.                                                         |
| `nr`    | `npm run`                | Start the project.                                                         |
| `nrb`   | `npm run build`          | Build the project.                                                         |
| `ni`    | `npm install`            | Install all dependencies for the project.                                  |
| `nig`   | `npm i -g`               | Install package globally.                                                  |
| `nid`   | `npm install --save-dev` | Install package as dev dependency.                                         |
| `nio`   | `npm i -O`               | Install package as optional dependency.                                    |
| `nu`    | `npm uninstall`          | Uninstall package.                                                         |
| `nug`   | `npm uninstall -g`       | Uninstall package globally.                                                |
| `nup`   | `npm prune`              | Remove extraneous packages.                                                |
| `npk`   | `npx npkill`             | Find and remove old and heavy node_modules folders                         |

#### Yarn
| Command | Replacement              | Description                                                                |
| ------- | ------------------------ | -------------------------------------------------------------------------- |
| `y`     | `yarn`                   | Yarn is a package manager that doubles down as project manager.            |
| `yi`    | `yarn install`           | Install all dependencies for the project.                                  |
| `ya`    | `yarn add`               | Install one or more packages in your `dependencies`.                       |
| `yad`   | `yarn add --dev`         | Install one or more packages in your `devDependencies`.                    |
| `yag`   | `yarn global add`        | Install one or more packages globally.                                     |
| `yr`    | `yarn remove`            | Remove one or more packages.                                               |
| `yrg`   | `yarn global remove`     | Remove one or more packages globally.                                      |
| `yl`    | `yarn link`              | Linked a package to your global folder.                                    |
| `ylu`   | `yarn unlink`            | Unlink a package from your global folder.                                  |
| `ys`    | `yarn start`             | Start the project.                                                         |
| `yw`    | `yarn workspace`         | Run a command in a specific workspace.                                     |
| `ywi`   | `yarn workspaces info`   | Display information about workspaces.                                      |
| `ycc`   | `yarn cache clean`       | Clear the Yarn cache.                                                      |

#### PNPM
| Command | Replacement              | Description                                                                |
| ------- | ------------------------ | -------------------------------------------------------------------------- |
| `pn`    | `pnpm`                   | PNPM is a fast, disk space efficient package manager.                      |
| `px`    | `pnpm dlx`               | Fetch a package without installing, hotload and run it's command           |
| `pex`   | `pnpm exec`              | Execute a shell command in scope of a project                              |
| `pi`    | `pnpm install`           | Install dependencies defined in `package.json`                             |
| `pa`    | `pnpm add`               | Install one or more packages in your `dependencies`.                       |
| `pad`   | `pnpm add --save-dev`    | Install one or more packages in your `devDependencies`.                    |
| `pag`   | `pnpm add --global`      | Install one or more packages globally.                                     |
| `pr`    | `pnpm remove`            | Remove one or more packages.                                               |
| `prg`   | `pnpm remove --global`   | Remove one or more packages globally.                                      |
| `pf`    | `pnpm -r --filter`       | In monorepo, use filter restrict commands to specific packages.            |

#### Image Optimization
| Command | Replacement                      | Description                                                        |
| ------- | -------------------------------- | -------------------------------------------------------------------|
| `iowebp`| `npx @squoosh/cli --webp auto`   | Optimize image to webp format.                                     |
| `iopng` | `npx @squoosh/cli --oxipng auto` | Optimize image to png format.                                      |
| `ioavif`| `npx @squoosh/cli --avif auto`   | Optimize image to avif format.                                     |

### Function Aliases

#### Git clone and cd to repo and open VS Code

```bash
gitcl https://github.com/dunggramer/example.git
```

#### Git clear branch not found in remote

```bash
git_clean
```

#### Delete previous branch
```bash
del_prev_branch
```

#### Delete all node_modules in current directory

```bash
del_node_modules
```

### Neovim
#### Clean Neovim config
+ MacOS, Ubuntu
Remove all `~/.local/share/nvim` (nvim downloaded all plugins) and `~/.config/nvim` (nvim config)
