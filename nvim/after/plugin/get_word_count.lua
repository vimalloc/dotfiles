local function get_word_count()
  local wc = vim.fn.wordcount()
  if wc.visual_words then
    return "Words: " .. wc.visual_words
  end
  return "Words: " .. wc.words
end

_G.get_word_count = get_word_count
