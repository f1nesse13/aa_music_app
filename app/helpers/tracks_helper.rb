module TracksHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    new_lyrics = ""
    lyrics.each_line do |line|
      new_line = "&#9835; #{line}"
      new_lyrics += new_line
    end
    "<pre>#{new_lyrics}</pre>".html_safe
  end
end
