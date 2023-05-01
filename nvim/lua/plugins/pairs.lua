require('nvim-autopairs').setup()
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }

-- Integration w/ nvim-cmp
require('cmp').event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)

npairs.add_rules({
  Rule('$', '$', { 'tex', 'latex' })
    -- don't add a pair if the next character is %
    :with_pair(
      cond.not_after_regex('%%')
    )
    -- don't add a pair if  the previous character is xxx
    :with_pair(
      cond.not_before_regex('xxx', 3)
    )
    -- don't move right when repeat character
    :with_move(cond.none())
    -- don't delete if the next character is xx
    :with_del(
      cond.not_after_regex('xx')
    )
    -- disable adding a newline when you press <cr>
    :with_cr(cond.none()),

  Rule(' ', ' ', { 'tex', 'latex' }):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({
      '$' .. '$',
    }, pair)
  end),
})

npairs.add_rules({
  Rule(' ', ' '):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({
      brackets[1][1] .. brackets[1][2],
      brackets[2][1] .. brackets[2][2],
      brackets[3][1] .. brackets[3][2],
    }, pair)
  end),
})

for _, bracket in pairs(brackets) do
  npairs.add_rules({
    Rule(bracket[1] .. ' ', ' ' .. bracket[2])
      :with_pair(function()
        return false
      end)
      :with_move(function(opts)
        return opts.prev_char:match('.%' .. bracket[2]) ~= nil
      end)
      :use_key(bracket[2]),
  })
end
