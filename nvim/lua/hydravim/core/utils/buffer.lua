--- Module containing functions related to buffer management and formatting.
-- @module buffer_utils

local M = {}

--- Save the specified buffer.
-- @param bufnr The buffer number to be saved.
function M.save_buffer(bufnr)
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  local readonly = vim.api.nvim_buf_get_option(bufnr, "readonly")
  if modified then
    if readonly then
      vim.api.nvim_buf_set_option(bufnr, "readonly", false)
    end
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd.write()
    end)
  end
end

-- Save all modified buffers.
function M.save_all()
  local buffers = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(bufnr, "modified") then
      M.save_buffer(bufnr)
    end
  end
end

--- Deletes the specified buffer.
-- If the buffer is modified, it prompts the user to save changes before deleting.
-- @param bufnr The buffer number to be deleted.
-- @param switch (optional) Move to next buffer (bnext) or previous buffer (bprev)
function M.delete_buffer(bufnr, switch)
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    local option = vim.fn.input "Buffer modified. Do you want to save changes? [y/N]: "
    if option:lower() == "y" then
      M.save_buffer(bufnr)
    end
  end

  if switch == "bnext" then
    vim.cmd.bnext()
  elseif switch == "bprev" then
    vim.cmd.bprev()
  end

  vim.api.nvim_buf_delete(bufnr, { force = true })
end

--- Delete all buffers.
-- @param keep_current (optional) If true keep the current buffer
function M.delete_all(keep_current)
  local current_bufnr = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if buf ~= current_bufnr or not keep_current then
      M.delete_buffer(buf)
    end
  end
  vim.cmd "redraw"
end

--- Deletes the current buffer.
-- If the buffer is modified, it prompts the user to save changes before deleting.
function M.delete_current()
  if not vim.tbl_contains({ "NvimTree", "dash" }, vim.bo.filetype) then
    local bufnr = vim.api.nvim_get_current_buf()
    M.delete_buffer(bufnr, "bnext")
  end
end

--- Deletes empty buffers.
function M.delete_all_empty_buffers()
  local buflisted = vim.fn.getbufinfo { buflisted = 1 }

  for _, bufnr in ipairs(buflisted) do
    local buf_content = vim.api.nvim_buf_get_lines(bufnr.bufnr, 0, -1, false)
    if bufnr.name == "" and #buf_content == 1 and buf_content[1] == "" then
      vim.api.nvim_buf_delete(bufnr.bufnr, { force = true })
    end
  end
  vim.cmd "redraw"
end

--- Formats the contents of the current buffer using the language server's formatting capabilities.
function M.format(opts)
  vim.lsp.buf.format(opts or { async = true })
end

--- Formats the contents of all open buffers using the language server's formatting capabilities.
function M.format_all(opts)
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    vim.api.nvim_buf_call(buf, function()
      M.format(opts)
    end)
  end
end

return M
