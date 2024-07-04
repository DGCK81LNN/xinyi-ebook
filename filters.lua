-- Avatars
local avatar_data = {
  ["龚"] = {
    filename = "gong.png",
    title = "龚观燕",
  },
  ["王"] = {
    filename = "wang.png",
    title = "王昕仪",
  },
  ["李"] = {
    filename = "li.png",
    title = "李彤涛",
  },
  ["杜"] = {
    filename = "du.png",
    title = "杜向哲",
  },
  ["陈"] = {
    filename = "chen.png",
    title = "陈颖",
  },
  ["阎"] = {
    filename = "yan.png",
    title = "阎柳岩"
  },
  ["魂"] = {
    filename = "pruxi.png",
  },
  ["吴"] = {
    filename = "wu.png",
    title = "吴宪留",
  },
  ["司机"] = {
    filename = "driver.png",
    title = "司机",
  },
  ["卢"] = {
    filename = "lu.png",
    title = "卢普",
  },
  ["阿姨"] = {
    filename = "woman.png",
    title = "阿姨",
  },
  ["徐"] = {
    filename = "xu.png",
    title = "徐佳瑶",
  },
}
local add_avatars = {
  Para = function (el)
    local new_content = pandoc.List()
    for i = 1, #el.content do
      local sub_el = el.content[i]
      if sub_el.t == "Str" then
        local start = 1
        for j = 1, pandoc.text.len(sub_el.text) do
          local cur = pandoc.text.sub(sub_el.text, j, j)
          if cur == ")" or cur == "]" or cur == "}" then
            local k
            local empty_alt = false
            if j - 2 >= start
            and pandoc.text.sub(sub_el.text, j - 2, j - 2) == "("
            and avatar_data[pandoc.text.sub(sub_el.text, j - 1, j - 1)]
            and cur == ")"
            then
              k = j - 2
            elseif j - 3 >= start
            and pandoc.text.sub(sub_el.text, j - 3, j - 3) == "("
            and avatar_data[pandoc.text.sub(sub_el.text, j - 2, j - 1)]
            and cur == ")"
            then
              k = j - 3
            elseif j - 2 >= start
            and pandoc.text.sub(sub_el.text, j - 2, j - 2) == "["
            and avatar_data[pandoc.text.sub(sub_el.text, j - 1, j - 1)]
            and cur == "]"
            then
              k = j - 2
              empty_alt = true
            elseif j - 3 >= start
            and pandoc.text.sub(sub_el.text, j - 3, j - 3) == "["
            and avatar_data[pandoc.text.sub(sub_el.text, j - 2, j - 1)]
            and cur == "]"
            then
              k = j - 3
              empty_alt = true
            elseif j - 2 >= start
            and pandoc.text.sub(sub_el.text, j - 2, j - 2) == "{"
            and avatar_data[pandoc.text.sub(sub_el.text, j - 1, j - 1)]
            and cur == "}"
            then
              k = j - 2
              empty_alt = true
            elseif j - 3 >= start
            and pandoc.text.sub(sub_el.text, j - 3, j - 3) == "{"
            and avatar_data[pandoc.text.sub(sub_el.text, j - 2, j - 1)]
            and cur == "}"
            then
              k = j - 3
              empty_alt = true
            end
            if k then
              data = avatar_data[pandoc.text.sub(sub_el.text, k + 1, j - 1)]
              if k - 1 >= start then
                new_content[#new_content + 1] = pandoc.Str(pandoc.text.sub(sub_el.text, start, k - 1))
              end
              local alt_text
              if empty_alt then
                alt_text = pandoc.Str("")
              else
                alt_text = pandoc.text.sub(sub_el.text, k, j)
              end
              new_content[#new_content + 1] = pandoc.Image(
                alt_text,
                "assets/avatars/" .. data.filename,
                data.title,
                { class = "avatar" }
              )
              start = j + 1
            end
          end
        end
        if start <= pandoc.text.len(sub_el.text) then
          new_content[#new_content + 1] = pandoc.Str(pandoc.text.sub(sub_el.text, start))
        end
      else
        new_content[#new_content + 1] = sub_el
      end
    end
    el.content = new_content
    return el
  end,
}

return {
  add_avatars,
}
