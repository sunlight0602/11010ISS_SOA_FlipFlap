# frozen_string_literal: true

TAB = "\t"
NEWLINE = "\n"

# tsv data to hash
def to_yml_hash(data, keys)
  tsv_hash = {}
  data = data.split(TAB)
  keys.each_with_index { |key, idx| tsv_hash[key] = data[idx] }

  tsv_hash
end

# Convert hash to tsv
def to_tsv_format(data)
  values = data.map { |_key, value| value }
  values = values.join(TAB)
  "\n#{values}"
end

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    tsv_data = tsv.split(NEWLINE)
    keys = tsv_data.first.split(TAB) # get keys

    @data = tsv_data[1..].map { |data| to_yml_hash(data, keys) }
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    header = @data.first.keys.join(TAB)
    body = @data.map { |d| to_tsv_format(d) }

    body.unshift(header).join + NEWLINE
  end
end
