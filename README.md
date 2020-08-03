# toggle-line.vim

Hide vim statusline and tabline (and tmux statusline, if running inside tmux), because sometimes, they're just get in our way.

Or, we can display them again, because sometimes we love being distracted.

![](demo.gif)

## Usage

Press `<Space>ts` to toggle statusline.

See `:h toggle-line`.

## Installation

Install using any vim plugin manager, or with vim-plug:

    Plug 'pirey/toggle-line.vim'

Then run `:PlugInstall`

### Note for tmux users

You need to add this option to your `~/.tmux.conf` to make this plugin work properly when moving between tmux windows:

```
set -g focus-events on
```

Setting the option above is usually enough, but in case that doesn't help, you should install [this plugin](https://github.com/tmux-plugins/vim-tmux-focus-events)

## License

Copyright (c) Pirey.  Distributed under the same terms as Vim itself.
See `:help license`.
