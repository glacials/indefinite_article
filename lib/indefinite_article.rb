require 'active_support'
require 'active_support/core_ext/string'

module IndefiniteArticle

  A_REQUIRING_PATTERNS = /^(([bcdgjkpqtuvwyz]|onc?e|onearmed|onetime|ouija)$|e[uw]|uk|ubi|ubo|oaxaca|ufo|ur[aeiou]|use|ut([^t])|unani|uni(l[^l]|[a-ko-z]))/i
  AN_REQUIRING_PATTERNS = /^([aefhilmnorsx]$|hono|honest|hour|heir|[aeiou]|8|11)/i
  UPCASE_A_REQUIRING_PATTERNS = /^([BCDGJKPQTUVWYZ][A-Z]*$|FEMA|LASER|NAFTA|NATO|SCUBA|SWAT)/
  UPCASE_AN_REQUIRING_PATTERNS = /^([AEFHILMNORSX][A-Z]*)$/

  def indefinite_article
    first_word = to_s.split(/[- ]/).first
    if (first_word[AN_REQUIRING_PATTERNS] || first_word[UPCASE_AN_REQUIRING_PATTERNS]) &&
       !(first_word[A_REQUIRING_PATTERNS] || first_word[UPCASE_A_REQUIRING_PATTERNS])
      'an'
    else
      'a'
    end unless first_word.nil?
  end

  def with_indefinite_article(upcase = false)
    "#{upcase ? indefinite_article.humanize : indefinite_article}#{ ' ' unless self.blank? }#{self}"
  end
  alias :indefinitize :with_indefinite_article
end

class String
  include ::IndefiniteArticle
end

class Symbol
  include ::IndefiniteArticle
end
