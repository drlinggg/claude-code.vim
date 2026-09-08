" Get root directory of this plugin
let s:root = fnamemodify(expand('<sfile>'), ':h:h')

" Add vendored dependencies to runtimepath
execute 'set runtimepath^=' . fnameescape(s:root . '/vendor/plenary.nvim')
execute 'set runtimepath^=' . fnameescape(s:root . '/vendor/claude-code.nvim')

" Claude Code configuration
lua << EOF
local cc = require('claude-code')

cc.setup({
  window = {
    position = 'botright',
    split_ratio = 1.0,
  },
})

function _G.ClaudeOpen(position, ratio)
  cc.config.window.position = position
  cc.config.window.split_ratio = ratio
  cc.toggle()
end
EOF

" Horizontal
command! ClaudeHorizontal lua ClaudeOpen('botright', 1.0)

" Vertical
command! ClaudeVertical lua ClaudeOpen('botright vsplit', 0.4)

" Keymaps
nnoremap <silent> <leader>ci :ClaudeHorizontal<CR>
nnoremap <silent> <leader>cv :ClaudeVertical<CR>

