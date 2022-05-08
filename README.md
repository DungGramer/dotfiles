## Dotfiles

### Add Global gitignore

```bash
git config --global core.excludesFile ~/.gitignore_global
mv .gitignore_global ~/
```

### Aliases

| Command | Replacement              | Description                                                                |
| ------- | ------------------------ | -------------------------------------------------------------------------- |
| `n`     | `npm`                    | npm is a package manager for JavaScript and related programming languages. |
| `ns`    | `npm start`              | Start the project.                                                         |
| `nr`    | `npm run`                | Start the project.                                                         |
| `nu`    | `npm uninstall`          | Uninstall package.                                                         |
| `ng`    | `npm i -g`               | Install package globally.                                                  |
| `nid`   | `npm install --save-dev` | Install package as dev dependency.                                         |
| `ys`    | `yarn start`             | Start the project.                                                         |
| `yr`    | `yarn run`               | Start the project.                                                         |

### Function Aliases

#### Git clone and cd to repo and open VS Code

```bash
gitcl https://github.com/dunggramer/example.git
```
